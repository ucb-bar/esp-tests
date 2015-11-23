## Hwacha v4 VVADD ASM code

.text
.align 2

.globl hsgemm_opt_v_2_2

# vector thread asm
.align 3
hsgemm_opt_v_2_2:
    vpset vp0
    
    vlh vv0, va1  # B
    vlh vv1, va2  # C
    vfmadd.s vv2, vv0, vs1, vv1 

    vlh vv3, va3  # B
    vlh vv4, va4  # C
    vfmadd.s vv7, vv3, vs2, vv4 

    vfmadd.s vv5, vv0, vs3, vv2 
    vsh vv5, va2  # store back to C

    vfmadd.s vv6, vv3, vs4, vv7 
    vsh vv6, va4  # store back to C

    vstop

.globl hsgemm_opt_v_4_4
.globl hsgemm_opt_v_4_4_pre
.globl hsgemm_opt_v_4_4_post


.align 3
hsgemm_opt_v_4_4_pre:
    vpset vp0
    vlh vv1, va2  # C
    vfcvt.s.h vv2, vv1
    vlh vv4, va4  # C
    vfcvt.s.h vv5, vv4
    vlh vv8, va6  # C
    vfcvt.s.h vv9, vv8
    vlh vv7, va8  # C
    vfcvt.s.h vv10, vv7
    vstop

# vector thread asm
.align 3
hsgemm_opt_v_4_4:
    vpset vp0

    vlh vv19, va1  # B
    vfcvt.s.h vv0, vv19

    vfcvt.s.h vs1, vs1
    vfcvt.s.h vs5, vs5
    vfcvt.s.h vs9, vs9
    vfcvt.s.h vs13, vs13

    vfmadd.s vv1, vv0, vs1, vv2
    vfmadd.s vv11, vv0, vs5, vv5

    vlh vv18, va3  # B
    vfcvt.s.h vs2, vs2
    vfcvt.s.h vs6, vs6

    vfcvt.s.h vv6, vv18

    vfcvt.s.h vs3, vs3
    vfcvt.s.h vs4, vs4


    vfmadd.s vv14, vv0, vs9, vv9
    vfmadd.s vv17, vv0, vs13, vv10

    vlh vv15, va5  # B
    vfcvt.s.h vv7, vv15

    vfmadd.s vv3, vv6, vs2, vv1
    vfmadd.s vv12, vv6, vs6, vv11

    vlh vv13, va7  # B

    vfcvt.s.h vs7, vs7
    vfcvt.s.h vs8, vs8
    vfcvt.s.h vs10, vs10

    vfcvt.s.h vv8, vv13

    vfmadd.s vv4, vv7, vs3, vv3
    vfmadd.s vv2, vv8, vs4, vv4

    vfcvt.s.h vs11, vs11
    vfcvt.s.h vs12, vs12
    vfcvt.s.h vs14, vs14
    vfcvt.s.h vs15, vs15
    vfcvt.s.h vs16, vs16


    vfmadd.s vv13, vv7, vs7, vv12
    vfmadd.s vv5, vv8, vs8, vv13

    vfmadd.s vv15, vv6, vs10, vv14
    vfmadd.s vv16, vv7, vs11, vv15
    vfmadd.s vv9, vv8, vs12, vv16

    vfmadd.s vv18, vv6, vs14, vv17
    vfmadd.s vv19, vv7, vs15, vv18
    vfmadd.s vv10, vv8, vs16, vv19



    vstop

.align 3
hsgemm_opt_v_4_4_post:
    vpset vp0
    vfcvt.h.s vv1, vv2
    vsh vv1, va2  # C
    vfcvt.h.s vv4, vv5
    vsh vv4, va4  # C
    vfcvt.h.s vv8, vv9
    vsh vv8, va6  # C
    vfcvt.h.s vv7, vv10
    vsh vv7, va8  # C
    vstop


