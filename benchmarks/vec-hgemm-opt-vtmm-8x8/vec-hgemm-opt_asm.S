## Hwacha v4 VVADD ASM cowe

.text

.globl hgemm_opt_v_8_8_vpset
.globl hgemm_opt_v_8_8_even
.globl hgemm_opt_v_8_8_odd
.globl hgemm_opt_v_8_8_first
.globl hgemm_opt_v_8_8_last
.globl hgemm_opt_v_8_8_pre
.globl hgemm_opt_v_8_8_post

.align 3
hgemm_opt_v_8_8_vpset:
    vpset vp0
    vpset vp1
    vpset vp2
    vpset vp3
    vpset vp4
    vpset vp5
    vpset vp6
    vpset vp7
    vpset vp8
    vpset vp9
    vpset vp10
    vpset vp11
    vpset vp12
    vpset vp13
    vpset vp14
    vpset vp15
    vstop

.align 3
hgemm_opt_v_8_8_first:
    vlsmh vv8, va8, va10, 8 #b0-7
    vlsmh vv0, va0, va11, 4 #c0-3
    vlsmh vv4, va1, va11, 4 #c4-7
    vstop

.align 3
hgemm_opt_v_8_8_pre:
    vlsmh vv0, va0, va11, 4 #c0-3
    vlsmh vv4, va1, va11, 4 #c4-7
    vstop

.align 3
hgemm_opt_v_8_8_even:
    vldsmh vv16, va16, va18, 4, 8          # a0-3
    vfvmmadd.h.vvv vv0, vv16, vv8, vv0, 8 # c0 += a0 * b[0-7]
    vfvmmadd.h.vvv vv1, vv17, vv8, vv1, 8 # c1 += a1 * b[0-7]
    vlsmh vv24, va8, va10, 4               #nb0-3
    vfvmmadd.h.vvv vv2, vv18, vv8, vv2, 8 # c2 += a2 * b[0-7]
    vfvmmadd.h.vvv vv3, vv19, vv8, vv3, 8 # c3 += a3 * b[0-7]

    vldsmh vv20, va17, va18, 4, 8          # a4-7
    vlsmh vv28, va9, va10, 4               #nb4-7
    vfvmmadd.h.vvv vv4, vv20, vv8, vv4, 8 # c4 += a4 * b[0-7]
    vfvmmadd.h.vvv vv5, vv21, vv8, vv5, 8 # c5 += a5 * b[0-7]
    vfvmmadd.h.vvv vv6, vv22, vv8, vv6, 8 # c6 += a6 * b[0-7]
    vfvmmadd.h.vvv vv7, vv23, vv8, vv7, 8 # c7 += a7 * b[0-7]
    vstop

.align 3
hgemm_opt_v_8_8_odd:
    vldsmh vv16, va16, va18, 4, 8          # a0-3
    vfvmmadd.h.vvv vv0, vv16, vv24, vv0, 8 # c0 += a0 * b[0-7]
    vfvmmadd.h.vvv vv1, vv17, vv24, vv1, 8 # c1 += a1 * b[0-7]
    vlsmh vv8, va8, va10, 4                #nb0-3
    vfvmmadd.h.vvv vv2, vv18, vv24, vv2, 8 # c2 += a2 * b[0-7]
    vfvmmadd.h.vvv vv3, vv19, vv24, vv3, 8 # c3 += a3 * b[0-7]

    vldsmh vv20, va17, va18, 4, 8          # a4-7
    vlsmh vv12, va9, va10, 4               #nb4-7
    vfvmmadd.h.vvv vv4, vv20, vv24, vv4, 8 # c4 += a4 * b[0-7]
    vfvmmadd.h.vvv vv5, vv21, vv24, vv5, 8 # c5 += a5 * b[0-7]
    vfvmmadd.h.vvv vv6, vv22, vv24, vv6, 8 # c6 += a6 * b[0-7]
    vfvmmadd.h.vvv vv7, vv23, vv24, vv7, 8 # c7 += a7 * b[0-7]
    vstop

.align 3
hgemm_opt_v_8_8_last:
    vldsmh vv16, va16, va18, 4, 8          # a0-3
    vfvmmadd.h.vvv vv0, vv16, vv24, vv0, 8 # c0 += a0 * b[0-7]
    vfvmmadd.h.vvv vv1, vv17, vv24, vv1, 8 # c1 += a1 * b[0-7]
    vfvmmadd.h.vvv vv2, vv18, vv24, vv2, 8 # c2 += a2 * b[0-7]
    vfvmmadd.h.vvv vv3, vv19, vv24, vv3, 8 # c3 += a3 * b[0-7]

    vldsmh vv20, va17, va18, 4, 8          # a4-7
    vfvmmadd.h.vvv vv4, vv20, vv24, vv4, 8 # c4 += a4 * b[0-7]
    vfvmmadd.h.vvv vv5, vv21, vv24, vv5, 8 # c5 += a5 * b[0-7]
    vfvmmadd.h.vvv vv6, vv22, vv24, vv6, 8 # c6 += a6 * b[0-7]
    vfvmmadd.h.vvv vv7, vv23, vv24, vv7, 8 # c7 += a7 * b[0-7]
    vstop

.align 3
hgemm_opt_v_8_8_post:
    vssmh vv0, va0, va11, 4 #c0-3
    vssmh vv4, va1, va11, 4 #c4-7
    vstop
