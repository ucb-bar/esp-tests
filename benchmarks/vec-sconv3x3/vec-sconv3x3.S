/*
 * Spatially separable 3x3 convolution routine
 *
 * extern void sconv3x3(size_t rows,
 *                      size_t cols,
 *                      size_t a_stride,
 *                      size_t b_stride,
 *                      const float kw[3],
 *                      const float kh[3],
 *                      const float *a,
 *                      float *b);
 */

#include "vec-util.h"

#define rows        a0
#define cols        a1
#define a_stride    a2
#define b_stride    a3
#define kw          a4
#define kh          a5
#define a           a6
#define b           a7

#define ap          t3
#define bp          t4
#define vlen        t5
#define row_count   t6

#define kw0     vs1
#define kw1     vs2
#define kw2     vs3
#define kh0     vs4
#define kh1     vs5
#define kh2     vs6

#define vload0  vv0
#define vload1  vv1
#define vload2  vv2
#define vrow0   vv3
#define vrow1   vv4
#define vtmp    vv5

#define vap00   va0
#define vap01   va1
#define vap02   va2
#define vap10   va3
#define vap11   va4
#define vap12   va5
#define vap20   va6
#define vbp     va7


    .global sconv3x3
sconv3x3:
    beqz rows, sconv3x3_exit

    # 1x3 kernel
    lw t0, 0(kw)
    lw t1, 4(kw)
    lw t2, 8(kw)
    vmcs kw0, t0
    vmcs kw1, t1
    vmcs kw2, t2

    # 3x1 kernel
    lw t0, 0(kh)
    lw t1, 4(kh)
    lw t2, 8(kh)
    vmcs kh0, t0
    vmcs kh1, t1
    vmcs kh2, t2

    li t0, VCFG(0, 6, 0, 1)
    vsetcfg t0

    slli a_stride, a_stride, 2
    slli b_stride, b_stride, 2

sconv3x3_col_loop:
    vsetvl vlen, cols

    addi t0, a, 4
    addi t1, a, 8
    add ap, a, a_stride
    vmca vap00, a
    vmca vap01, t0
    vmca vap02, t1

    addi t0, ap, 4
    addi t1, ap, 8
    vmca vap10, ap
    add ap, ap, a_stride
    vmca vap11, t0
    vmca vap12, t1
    vmca vap20, ap

1:
    auipc t0, %pcrel_hi(sconv3x3_col_vec)
    vf %pcrel_lo(1b)(t0)

    move bp, b
    addi row_count, rows, -1

sconv3x3_row_loop:
    addi t0, ap, 4
    addi t1, ap, 8
    vmca vap01, t0
    vmca vap02, t1
    vmca vbp, bp

    beqz row_count, 2f

    add ap, ap, a_stride
1:
    auipc t0, %pcrel_hi(sconv3x3_row_vec)
    vmca vap10, ap
    vf %pcrel_lo(1b)(t0)

    add bp, bp, b_stride
    addi row_count, row_count, -1
    j sconv3x3_row_loop

2:
    auipc t0, %pcrel_hi(sconv3x3_row_vec_post)
    vf %pcrel_lo(2b)(t0)

    sub cols, cols, vlen
    slli vlen, vlen, 2
    add a, a, vlen
    add b, b, vlen

    bnez cols, sconv3x3_col_loop
    fence

sconv3x3_exit:
    ret



    .align 3
    /* Software pipeline prologue */
sconv3x3_col_vec:
    /*
     * vload0 = *vap00  # ap[0]
     * vload1 = *vap01  # ap[1]
     * vload2 = *vap02  # ap[2]
     * vrow0 = (kw0 * vload0) + (kw1 * vload1) + (kw2 * vload2)
     * vrow0 = kh0 * vrow0
     *
     * vload0 = *vap10  # ap[a_stride]
     * vload1 = *vap11  # ap[a_stride+1]
     * vload2 = *vap12  # ap[a_stride+2]
     * vtmp = (kw0 * vload0) + (kw1 * vload1) + (kw2 * vload2)
     * vrow0 += kh1 * vtmp
     * vrow1 = kh0 * vtmp
     *
     * vload0 = *vap20  # ap[2*a_stride]
     */
    vpset vp0

    # 1x3 convolution
    vlw vload0, vap00
    vlw vload1, vap01
    vlw vload2, vap02
    vfmul.s.vs vrow0, vload0, kw0
    vfmadd.s.vsv vrow0, vload1, kw1, vrow0
    vfmadd.s.vsv vrow0, vload2, kw2, vrow0

    vlw vload0, vap10
    vlw vload1, vap11
    vlw vload2, vap12
    vfmul.s.vs vrow0, vrow0, kh0

    # 1x3 convolution
    vfmul.s.vs vtmp, vload0, kw0
    vfmadd.s.vsv vtmp, vload1, kw1, vtmp
    vfmadd.s.vsv vtmp, vload2, kw2, vtmp

    vlw vload0, vap20                       # Prefetch third row

    vfmadd.s.vsv vrow0, vtmp, kh1, vrow0
    vfmul.s.vs vrow1, vtmp, kh0

    vstop


    .align 3
    /* Software pipeline loop */
sconv3x3_row_vec:
    /*
     * vload1 = *vap01  # ap[1]
     * vload2 = *vap02  # ap[2]
     * vtmp = (kw0 * vload0) + (kw1 * vload1) + (kw2 * vload2)
     * vrow0 += kh2 * vtmp
     * *vbp = vrow0
     *
     * vload0 = *vap10  # ap[a_stride]
     * vrow0 = vrow1 + (kh1 * vtmp)
     * vrow1 = kh0 * vtmp
     */

    # 1x3 convolution
    vfmul.s.vs vtmp, vload0, kw0
    vlw vload1, vap01
    vfmadd.s.vsv vtmp, vload1, kw1, vtmp
    vlw vload2, vap02
    vfmadd.s.vsv vtmp, vload2, kw2, vtmp

    vlw vload0, vap10                       # Prefetch next row

    vfmadd.s.vsv vrow0, vtmp, kh2, vrow0
    vsw vrow0, vbp

    vfmadd.s.vsv vrow0, vtmp, kh1, vrow1
    vfmul.s.vs vrow1, vtmp, kh0

    vstop


    .align 3
    /* Software pipeline epilogue */
sconv3x3_row_vec_post:
    /*
     * vload1 = *vap01  # ap[1]
     * vload2 = *vap02  # ap[2]
     * vtmp = (kw0 * vload0) + (kw1 * vload1) + (kw2 * vload2)
     * vrow0 += kh2 * vtmp
     * *vbp = vrow0
     */

    # 1x3 convolution
    vfmul.s.vs vtmp, vload0, kw0
    vlw vload1, vap01
    vfmadd.s.vsv vtmp, vload1, kw1, vtmp
    vlw vload2, vap02
    vfmadd.s.vsv vtmp, vload2, kw2, vtmp

    vfmadd.s.vsv vrow0, vtmp, kh2, vrow0
    vsw vrow0, vbp

    vstop
