## Hwacha v4 VVADD ASM code

.text
.align 2

.globl sdgemm_opt_v_4_4
.globl sdgemm_opt_v_4_4_pre
.globl sdgemm_opt_v_4_4_post

.align 3
sdgemm_opt_v_4_4_pre:
    vpset vp0
    vlw vv20, va2  # C
    vfcvt.d.s vv2, vv20
    vlw vv20, va4  # C
    vfcvt.d.s vv5, vv20
    vlw vv20, va6  # C
    vfcvt.d.s vv9, vv20
    vlw vv20, va8  # C
    vfcvt.d.s vv10, vv20
    vstop

# vector thread asm
.align 3
sdgemm_opt_v_4_4:
    vpset vp0

    vlw vv20, va1  # B
    vfcvt.d.s vv0, vv20

    vfcvt.d.s vs1, vs1
    vfcvt.d.s vs5, vs5
    vfcvt.d.s vs9, vs9
    vfcvt.d.s vs13, vs13

    vfmadd.d vv1, vv0, vs1, vv2
    vfmadd.d vv11, vv0, vs5, vv5

    vlw vv20, va3  # B
    vfcvt.d.s vs2, vs2
    vfcvt.d.s vs6, vs6

    vfcvt.d.s vv6, vv20

    vfcvt.d.s vs3, vs3
    vfcvt.d.s vs4, vs4


    vfmadd.d vv14, vv0, vs9, vv9
    vfmadd.d vv17, vv0, vs13, vv10

    vlw vv20, va5  # B
    vfcvt.d.s vv7, vv20

    vfmadd.d vv3, vv6, vs2, vv1
    vfmadd.d vv12, vv6, vs6, vv11

    vlw vv20, va7  # B

    vfcvt.d.s vs7, vs7
    vfcvt.d.s vs8, vs8
    vfcvt.d.s vs10, vs10

    vfcvt.d.s vv8, vv20

    vfmadd.d vv4, vv7, vs3, vv3
    vfmadd.d vv2, vv8, vs4, vv4

    vfcvt.d.s vs11, vs11
    vfcvt.d.s vs12, vs12
    vfcvt.d.s vs14, vs14
    vfcvt.d.s vs15, vs15
    vfcvt.d.s vs16, vs16


    vfmadd.d vv13, vv7, vs7, vv12
    vfmadd.d vv5, vv8, vs8, vv13

    vfmadd.d vv15, vv6, vs10, vv14
    vfmadd.d vv16, vv7, vs11, vv15
    vfmadd.d vv9, vv8, vs12, vv16

    vfmadd.d vv18, vv6, vs14, vv17
    vfmadd.d vv19, vv7, vs15, vv18
    vfmadd.d vv10, vv8, vs16, vv19



    vstop

.align 3
sdgemm_opt_v_4_4_post:
    vpset vp0
    vfcvt.s.d vv20, vv2
    vsw vv20, va2  # C
    vfcvt.s.d vv20, vv5
    vsw vv20, va4  # C
    vfcvt.s.d vv20, vv9
    vsw vv20, va6  # C
    vfcvt.s.d vv20, vv10
    vsw vv20, va8  # C
    vstop


