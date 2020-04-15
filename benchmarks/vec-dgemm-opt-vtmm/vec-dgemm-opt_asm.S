## Hwacha v4 VVADD ASM code

.text

.globl dgemm_opt_v_8_8_vpset
.globl dgemm_opt_v_8_8
.globl dgemm_opt_v_8_8_last
.globl dgemm_opt_v_8_8_pre
.globl dgemm_opt_v_8_8_post

.align 3
dgemm_opt_v_8_8_vpset:
    vpset vp0
    vstop

.align 3
dgemm_opt_v_8_8_pre:
    vld vv0, va0 # c0
    vld vv1, va1 # c1
    vld vv2, va2 # c2
    vld vv3, va3 # c3
    vld vv4, va4 # c4
    vld vv5, va5 # c5
    vld vv6, va6 # c6
    vld vv7, va7 # c7


    vld vv8, va8                          # b0
    vld vv9, va9                          # b1
    vld vv10, va10                        # b2
    vld vv11, va11                        # b3

    vstop

.align 3
dgemm_opt_v_8_8:
    #vlsegstdd vv16, va16, va17, 4
    #vlsegstdd vv20, va16, va17, 4
    vldd vv16, va16, 4                    # a0
    vldd vv17, va17, 4                    # a1
    vldd vv18, va18, 4                    # a2
    vldd vv19, va19, 4                    # a3
    vfvmmadd.d.vvv vv0, vv16, vv8, vv0, 4 # c0 += a0 * b[0-3]
    vfvmmadd.d.vvv vv1, vv17, vv8, vv1, 4 # c1 += a1 * b[0-3]
    vld vv12, va12                        # b4
    vld vv13, va13                        # b5
    vfvmmadd.d.vvv vv2, vv18, vv8, vv2, 4 # c2 += a2 * b[0-3]
    vfvmmadd.d.vvv vv3, vv19, vv8, vv3, 4 # c3 += a3 * b[0-3]

    vldd vv20, va20, 4                    # a4
    vldd vv21, va21, 4                     # a5
    vldd vv22, va22, 4                     # a6
    vldd vv23, va23, 4                     # a7
    vfvmmadd.d.vvv vv4, vv20, vv8, vv4, 4 # c4 += a4 * b[0-3]
    vfvmmadd.d.vvv vv5, vv21, vv8, vv5, 4 # c5 += a5 * b[0-3]
    vld vv14, va14                        # b6
    vld vv15, va15                        # b7
    vfvmmadd.d.vvv vv6, vv22, vv8, vv6, 4 # c6 += a6 * b[0-3]
    vfvmmadd.d.vvv vv7, vv23, vv8, vv7, 4 # c7 += a7 * b[0-3]

    vldd vv16, va24, 4                    # a0
    vldd vv17, va25, 4                    # a1
    vldd vv18, va26, 4                    # a2
    vldd vv19, va27, 4                    # a3
    vfvmmadd.d.vvv vv0, vv16, vv12, vv0, 4 # c0 += a0 * b[4-7]
    vfvmmadd.d.vvv vv1, vv17, vv12, vv1, 4 # c1 += a1 * b[4-7]
    vld vv8, va8                          # b0
    vld vv9, va9                          # b1
    vfvmmadd.d.vvv vv2, vv18, vv12, vv2, 4 # c2 += a2 * b[4-7]
    vfvmmadd.d.vvv vv3, vv19, vv12, vv3, 4 # c3 += a3 * b[4-7]

    vldd vv20, va28, 4                    # a4
    vldd vv21, va29, 4                     # a5
    vldd vv22, va30, 4                     # a6
    vldd vv23, va31, 4                     # a7
    vfvmmadd.d.vvv vv4, vv20, vv12, vv4, 4 # c4 += a4 * b[4-7]
    vfvmmadd.d.vvv vv5, vv21, vv12, vv5, 4 # c5 += a5 * b[4-7]
    vld vv10, va10                        # b2
    vld vv11, va11                        # b3
    vfvmmadd.d.vvv vv6, vv22, vv12, vv6, 4 # c6 += a6 * b[4-7]
    vfvmmadd.d.vvv vv7, vv23, vv12, vv7, 4 # c7 += a7 * b[4-7]

    vstop

.align 3
dgemm_opt_v_8_8_last:
    vldd vv16, va16, 4                    # a0
    vldd vv17, va17, 4                    # a1
    vldd vv18, va18, 4                    # a2
    vldd vv19, va19, 4                    # a3
    vfvmmadd.d.vvv vv0, vv16, vv8, vv0, 4 # c0 += a0 * b[0-3]
    vfvmmadd.d.vvv vv1, vv17, vv8, vv1, 4 # c1 += a1 * b[0-3]
    vld vv12, va12                        # b4
    vld vv13, va13                        # b5
    vfvmmadd.d.vvv vv2, vv18, vv8, vv2, 4 # c2 += a2 * b[0-3]
    vfvmmadd.d.vvv vv3, vv19, vv8, vv3, 4 # c3 += a3 * b[0-3]

    vldd vv20, va20, 4                    # a4
    vldd vv21, va21, 4                     # a5
    vldd vv22, va22, 4                     # a6
    vldd vv23, va23, 4                     # a7
    vfvmmadd.d.vvv vv4, vv20, vv8, vv4, 4 # c4 += a4 * b[0-3]
    vfvmmadd.d.vvv vv5, vv21, vv8, vv5, 4 # c5 += a5 * b[0-3]
    vld vv14, va14                        # b6
    vld vv15, va15                        # b7
    vfvmmadd.d.vvv vv6, vv22, vv8, vv6, 4 # c6 += a6 * b[0-3]
    vfvmmadd.d.vvv vv7, vv23, vv8, vv7, 4 # c7 += a7 * b[0-3]

    vldd vv16, va24, 4                    # a0
    vldd vv17, va25, 4                    # a1
    vldd vv18, va26, 4                    # a2
    vldd vv19, va27, 4                    # a3
    vfvmmadd.d.vvv vv0, vv16, vv12, vv0, 4 # c0 += a0 * b[4-7]
    vfvmmadd.d.vvv vv1, vv17, vv12, vv1, 4 # c1 += a1 * b[4-7]
    #vld vv8, va8                          # b0
    #vld vv9, va9                          # b1
    vfvmmadd.d.vvv vv2, vv18, vv12, vv2, 4 # c2 += a2 * b[4-7]
    vfvmmadd.d.vvv vv3, vv19, vv12, vv3, 4 # c3 += a3 * b[4-7]

    vldd vv20, va28, 4                    # a4
    vldd vv21, va29, 4                     # a5
    vldd vv22, va30, 4                     # a6
    vldd vv23, va31, 4                     # a7
    vfvmmadd.d.vvv vv4, vv20, vv12, vv4, 4 # c4 += a4 * b[4-7]
    vfvmmadd.d.vvv vv5, vv21, vv12, vv5, 4 # c5 += a5 * b[4-7]
    #vld vv10, va10                        # b2
    #vld vv11, va11                        # b3
    vfvmmadd.d.vvv vv6, vv22, vv12, vv6, 4 # c6 += a6 * b[4-7]
    vfvmmadd.d.vvv vv7, vv23, vv12, vv7, 4 # c7 += a7 * b[4-7]

    vstop
    
#.align 3
#dgemm_opt_v_8_8_pre:
#    vld vv0, va0 # c0
#    vld vv1, va1 # c1
#    vld vv2, va2 # c2
#    vld vv3, va3 # c3
#    vld vv4, va4 # c4
#    vld vv5, va5 # c5
#    vld vv6, va6 # c6
#    vld vv7, va7 # c7
#
#
#    vld vv8, va8                          # b0
#    vld vv9, va9                          # b1
#    vld vv10, va10                        # b2
#    vld vv11, va11                        # b3
#    vld vv12, va12                        # b4
#    vld vv13, va13                        # b5
#    vld vv14, va14                        # b6
#    vld vv15, va15                        # b7
#
#    vstop
#.align 3
#dgemm_opt_v_8_8:
#    vldd vv16, va16, 8                    # a0
#    vfvmmadd.d.vvv vv0, vv16, vv8, vv0, 8 # c0 += a0 * b[0-7]
#    vld vv24, va8                         # nb0
#    vldd vv16, va17, 8                    # a1
#    vfvmmadd.d.vvv vv1, vv16, vv8, vv1, 8 # c1 += a1 * b[0-7]
#    vld vv24, va9                         # nb1
#    vldd vv16, va18, 8                    # a2
#    vfvmmadd.d.vvv vv2, vv16, vv8, vv2, 8 # c2 += a2 * b[0-7]
#    vld vv24, va10                        # nb2
#    vldd vv16, va19, 8                    # a3
#    vfvmmadd.d.vvv vv3, vv16, vv8, vv3, 8 # c3 += a3 * b[0-7]
#    vld vv24, va11                        # nb3
#    vldd vv16, va20, 8                    # a4
#    vfvmmadd.d.vvv vv4, vv16, vv8, vv0, 8 # c4 += a4 * b[0-7]
#    vld vv24, va12                        # nb4
#    vldd vv16, va21, 8                    # a5
#    vfvmmadd.d.vvv vv5, vv16, vv8, vv1, 8 # c5 += a5 * b[0-7]
#    vld vv24, va13                        # nb5
#    vldd vv16, va22, 8                    # a6
#    vfvmmadd.d.vvv vv6, vv16, vv8, vv2, 8 # c6 += a6 * b[0-7]
#    vld vv24, va14                        # nb6
#    vldd vv16, va23, 8                    # a7
#    vfvmmadd.d.vvv vv7, vv16, vv8, vv3, 8 # c7 += a7 * b[0-7]
#    vstop



    # vld vv4, va4                    # b0
    # vfmadd.d vv0, vv4, vs1, vv0     # c0 += a00 * b0
    # vfmadd.d vv1, vv4, vs5, vv1     # c1 += a10 * b0

    # vld vv5, va5                    # b1
    # vfmadd.d vv2, vv4, vs9, vv2     # c2 += a20 * b0
    # vfmadd.d vv3, vv4, vs13, vv3    # c3 += a30 * b0

    # vld vv6, va6                    # b2
    # vfmadd.d vv0, vv5, vs2, vv0     # c0 += a01 * b1
    # vfmadd.d vv1, vv5, vs6, vv1     # c1 += a11 * b1

    # vld vv7, va7                    # b3
    # vfmadd.d vv0, vv6, vs3, vv0     # c0 += a02 * b2
    # vfmadd.d vv1, vv6, vs7, vv1     # c1 += a12 * b2
    # vfmadd.d vv0, vv7, vs4, vv0     # c0 += a03 * b3
    # vfmadd.d vv1, vv7, vs8, vv1     # c1 += a13 * b3
    # vfmadd.d vv2, vv5, vs10, vv2    # c2 += a21 * b1
    # vfmadd.d vv3, vv5, vs14, vv3    # c3 += a31 * b1
    # vfmadd.d vv2, vv6, vs11, vv2    # c2 += a22 * b2
    # vfmadd.d vv3, vv6, vs15, vv3    # c3 += a32 * b2
    # vfmadd.d vv2, vv7, vs12, vv2    # c2 += a23 * b3
    # vfmadd.d vv3, vv7, vs16, vv3    # c3 += a33 * b3


.align 3
dgemm_opt_v_8_8_post:
    vsd vv0, va0 # c0
    vsd vv1, va1 # c1
    vsd vv2, va2 # c2
    vsd vv3, va3 # c3
    vsd vv4, va4 # c4
    vsd vv5, va5 # c5
    vsd vv6, va6 # c6
    vsd vv7, va7 # c7

    vstop
