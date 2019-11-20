/*
 * 3x3 image box filter routine
 *
 * extern void box3x3_mi16mu8_mi8s(size_t rows,
 *                                 size_t cols,
 *                                 size_t a_stride,
 *                                 size_t b_stride,
 *                                 const int16_t k[3][3],
 *                                 const uint8_t *a,
 *                                 int8_t *b,
 *                                 unsigned int rshift);
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
#define rshift      a7

#define ap          t3
#define bp          t4
#define vlen        t5
#define row_count   t6

#define k_offset(x,y) ((((x) * 3) + (y)) << 1)

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
#define vprod0  vv3
#define vprod1  vv4
#define vrow1   vv5
#define vrow2   vv6
#define vrow3   vv7

#define vap00   va0
#define vap01   va1
#define vap02   va2
#define vap10   va3
#define vap11   va4
#define vap12   va5
#define vap20   va6
#define vbp     va7


    .global box3x3_mi16mu8_mi8s
box3x3_mi16mu8_mi8s:
    beqz rows, box3x3_exit

    lh t0, k_offset(0,0)(k)
    lh t1, k_offset(0,1)(k)
    lh t2, k_offset(0,2)(k)
    vmcs k00, t0
    vmcs k01, t1
    vmcs k02, t2
    lh t0, k_offset(1,0)(k)
    lh t1, k_offset(1,1)(k)
    lh t2, k_offset(1,2)(k)
    vmcs k10, t0
    vmcs k11, t1
    vmcs k12, t2
    lh t0, k_offset(2,0)(k)
    lh t1, k_offset(2,1)(k)
    lh t2, k_offset(2,2)(k)
    vmcs k20, t0
    vmcs k21, t1
    vmcs k22, t2

    li t0, VCFG(0, 8, 0, 0)
    li t1, 1    # round-to-nearest-even (RNE)
    vmcs vrshift, rshift
    vsetcfg t0
    vsetxrm zero, t1

box3x3_col_loop:
    vsetvl vlen, cols

    addi t0, a, 1
    addi t1, a, 2
    add ap, a, a_stride
    vmca vap00, a
    vmca vap01, t0
    vmca vap02, t1

    addi t0, ap, 1
    addi t1, ap, 2
    vmca vap10, ap
    add ap, ap, a_stride
    vmca vap11, t0
    vmca vap12, t1
    vmca vap20, ap

1:
    auipc t0, %pcrel_hi(box3x3_col_vec)
    vf %pcrel_lo(1b)(t0)

    move bp, b
    addi row_count, rows, -1

box3x3_row_loop:
    addi t0, ap, 1
    addi t1, ap, 2
    vmca vap01, t0
    vmca vap02, t1
    vmca vbp, bp

    beqz row_count, 2f

    add ap, ap, a_stride
1:
    auipc t0, %pcrel_hi(box3x3_row_vec)
    vmca vap10, ap
    vf %pcrel_lo(1b)(t0)

    add bp, bp, b_stride
    addi row_count, row_count, -1
    j box3x3_row_loop

2:
    auipc t0, %pcrel_hi(box3x3_row_vec_post)
    vf %pcrel_lo(2b)(t0)

    sub cols, cols, vlen
    add a, a, vlen
    add b, b, vlen

    bnez cols, box3x3_col_loop
    fence

box3x3_exit:
    ret


    .align 3
box3x3_col_vec:
    vlbu vload0, vap00
    vlbu vload1, vap01
    vlbu vload2, vap02

    vmul.vs vrow1, vload0, k00
    vmul.vs vprod0, vload1, k01
    vmul.vs vprod1, vload2, k02

    vlbu vload0, vap10

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod0, vload0, k10

    vadd.vv vrow1, vrow1, vprod1
    vmul.vs vrow2, vload0, k00

    vlbu vload1, vap11

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod0, vload1, k11

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod0, vload1, k01

    vlbu vload2, vap12

    vadd.vv vrow2, vrow2, vprod0
    vmul.vs vprod0, vload2, k12

    vlbu vload0, vap20          # Start software pipeline
    vadd.ss vprod1, vs0, vs0    # Clear vprod1

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod0, vload2, k02

    vadd.vv vrow3, vrow2, vprod0

    vstop

    .align 3
box3x3_row_vec:
    /*
     * vrow1 accumulates k20..k22 products
     * vrow2 accumulates k10..k12 products
     * vrow3 accumulates k00..k02 products
     */
    vmul.vs vprod0, vload0, k20

    vlbu vload1, vap01

    vadd.vv vrow2, vrow3, vprod1
    vmul.vs vprod1, vload0, k10

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod0, vload1, k21

    vlbu vload2, vap02

    vadd.vv vrow2, vrow2, vprod1
    vmul.vs vprod1, vload2, k22

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vrow3, vload0, k00

    vlbu vload0, vap10          # Prefetch

    vadd.vv vrow1, vrow1, vprod1
    vmul.vs vprod0, vload1, k11

    vclipb.vs vrow1, vrow1, vrshift

    vmul.vs vprod1, vload1, k01
    vsb vrow1, vbp

    vadd.vv vrow2, vrow2, vprod0
    vmul.vs vprod0, vload2, k12

    vadd.vv vrow3, vrow3, vprod1
    vmul.vs vprod1, vload2, k02

    vadd.vv vrow1, vrow2, vprod0

    vstop

    .align 3
box3x3_row_vec_post:
    vmul.vs vprod0, vload0, k20

    vlbu vload1, vap01
    vlbu vload2, vap02

    vadd.vv vrow1, vrow1, vprod0
    vmul.vs vprod1, vload1, k21
    vmul.vs vprod0, vload2, k22

    vadd.vv vrow1, vrow1, vprod1
    vadd.vv vrow1, vrow1, vprod0

    vclipb.vs vrow1, vrow1, vrshift
    vsb vrow1, vbp

    vstop
