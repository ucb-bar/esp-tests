/*
 * 3x3 convolution routine
 *
 * extern void conv3x3(size_t rows,
 *                     size_t cols,
 *                     size_t a_stride,
 *                     size_t b_stride,
 *                     const float k[3][3],
 *                     const float *a,
 *                     float *b);
 *
 * Based on T0 assembly code by Krste Asanovic:
 *   apps/box3x3/box3x3_mi16mu8_mi8s.S
 *
 * The routine takes an input image stored as unsigned 8-bit pixels,
 * calculates the convolution with an arbitrary signed 16-bit kernel,
 * and writes the scaled, rounded, and saturated result as a signed
 * 8-bit image.  The kernel values are read into into nine shared
 * registers.  The source image is read with a neighbor access pattern
 * to align the three pixels on each row with each output element.
 * Each source vector is reused three times by three output pixels down
 * each column.
 */

#include "vec-util.h"

#define rows        a0
#define cols        a1
#define a_stride    a2
#define b_stride    a3
#define k           a4
#define a           a5
#define b           a6

#define ap          t3
#define bp          t4
#define vlen        t5
#define row_count   t6

#define k_offset(x,y) ((((x) * 3) + (y)) << 2)

#define k00     vs1
#define k01     vs2
#define k02     vs3
#define k10     vs4
#define k11     vs5
#define k12     vs6
#define k20     vs7
#define k21     vs8
#define k22     vs9

#define vrshift vs10

#define vload0  vv0
#define vload1  vv1
#define vload2  vv2
#define vrow1   vv3
#define vrow2   vv4
#define vrow3   vv5

#define vap00   va0
#define vap01   va1
#define vap02   va2
#define vap10   va3
#define vap11   va4
#define vap12   va5
#define vap20   va6
#define vbp     va7


    .global conv3x3
conv3x3:
    beqz rows, conv3x3_exit

    lw t0, k_offset(0,0)(k)
    lw t1, k_offset(0,1)(k)
    lw t2, k_offset(0,2)(k)
    vmcs k00, t0
    vmcs k01, t1
    vmcs k02, t2
    lw t0, k_offset(1,0)(k)
    lw t1, k_offset(1,1)(k)
    lw t2, k_offset(1,2)(k)
    vmcs k10, t0
    vmcs k11, t1
    vmcs k12, t2
    lw t0, k_offset(2,0)(k)
    lw t1, k_offset(2,1)(k)
    lw t2, k_offset(2,2)(k)
    vmcs k20, t0
    vmcs k21, t1
    vmcs k22, t2

    li t0, VCFG(0, 6, 0, 1)
    vsetcfg t0

    slli a_stride, a_stride, 2
    slli b_stride, b_stride, 2

conv3x3_col_loop:
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
    auipc t0, %pcrel_hi(conv3x3_col_vec)
    vf %pcrel_lo(1b)(t0)

    move bp, b
    addi row_count, rows, -1

conv3x3_row_loop:
    addi t0, ap, 4
    addi t1, ap, 8
    vmca vap01, t0
    vmca vap02, t1
    vmca vbp, bp

    beqz row_count, 2f

    add ap, ap, a_stride
1:
    auipc t0, %pcrel_hi(conv3x3_row_vec)
    vmca vap10, ap
    vf %pcrel_lo(1b)(t0)

    add bp, bp, b_stride
    addi row_count, row_count, -1
    j conv3x3_row_loop

2:
    auipc t0, %pcrel_hi(conv3x3_row_vec_post)
    vf %pcrel_lo(2b)(t0)

    sub cols, cols, vlen
    slli vlen, vlen, 2
    add a, a, vlen
    add b, b, vlen

    bnez cols, conv3x3_col_loop
    fence

conv3x3_exit:
    ret


    .align 3
conv3x3_col_vec:
    vpset vp0

    vlw vload0, vap00
    vfmul.s.vs vrow1, vload0, k00
    vlw vload1, vap01
    vfmadd.s.vsv vrow1, vload1, k01, vrow1
    vlw vload2, vap02
    vfmadd.s.vsv vrow1, vload2, k02, vrow1

    vlw vload0, vap10
    vfmul.s.vs vrow2, vload0, k00
    vfmadd.s.vsv vrow1, vload0, k10, vrow1

    vlw vload1, vap11
    vfmadd.s.vsv vrow2, vload1, k01, vrow2
    vfmadd.s.vsv vrow1, vload1, k11, vrow1

    vlw vload2, vap12
    vfmadd.s.vsv vrow2, vload2, k02, vrow2
    vfmadd.s.vsv vrow1, vload2, k12, vrow1

    vlw vload0, vap20           # Start software pipeline

    vstop

    .align 3
conv3x3_row_vec:
    /*
     * vrow1 accumulates k20..k22 products
     * vrow2 accumulates k10..k12 products
     * vrow3 accumulates k00..k02 products
     */
    vlw vload1, vap01

    vfmadd.s.vsv vrow1, vload0, k20, vrow1
    vfmadd.s.vsv vrow2, vload0, k10, vrow2
    vfmul.s.vs vrow3, vload0, k00

    vlw vload2, vap02

    vfmadd.s.vsv vrow1, vload1, k21, vrow1
    vfmadd.s.vsv vrow2, vload1, k11, vrow2
    vfmadd.s.vsv vrow3, vload1, k01, vrow3

    vlw vload0, vap10          # Prefetch

    vfmadd.s.vsv vrow1, vload2, k22, vrow1
    vsw vrow1, vbp

    vfmadd.s.vsv vrow1, vload2, k12, vrow2
    vfmadd.s.vsv vrow2, vload2, k02, vrow3

    vstop

    .align 3
conv3x3_row_vec_post:
    vfmadd.s.vsv vrow1, vload0, k20, vrow1

    vlw vload1, vap01
    vfmadd.s.vsv vrow1, vload1, k21, vrow1

    vlw vload2, vap02
    vfmadd.s.vsv vrow1, vload2, k22, vrow1

    vsw vrow1, vbp

    vstop
