## Hwacha v4 VVADD ASM code

.text
.align 2

.globl hgemm_opt_v_4_4
.globl hgemm_opt_v_4_4_pre
.globl hgemm_opt_v_4_4_post



# vector thread asm
.align 3
hgemm_opt_v_4_4_pre:
    vpset vp0
    vlh vv2, va2  # C
    vlh vv5, va4  # C
    vlh vv9, va6  # C
    vlh vv10, va8  # C
    vstop


# vector thread asm
.align 3
hgemm_opt_v_4_4:
    vpset vp0
    vlh vv0, va1  # B
    vfmadd.h vv1, vv0, vs1, vv2
    vfmadd.h vv11, vv0, vs5, vv5
    vlh vv6, va3  # B
    vfmadd.h vv14, vv0, vs9, vv9
    vfmadd.h vv13, vv0, vs13, vv10

    vlh vv7, va5  # B



    vfmadd.h vv3, vv6, vs2, vv1
    vfmadd.h vv12, vv6, vs6, vv11

    vlh vv8, va7  # B


    vfmadd.h vv4, vv7, vs3, vv3
    vfmadd.h vv2, vv8, vs4, vv4


    vfmadd.h vv11, vv7, vs7, vv12
    vfmadd.h vv5, vv8, vs8, vv11

    vfmadd.h vv15, vv6, vs10, vv14
    vfmadd.h vv4, vv7, vs11, vv15
    vfmadd.h vv9, vv8, vs12, vv4

    vfmadd.h vv3, vv6, vs14, vv13
    vfmadd.h vv1, vv7, vs15, vv3
    vfmadd.h vv10, vv8, vs16, vv1



    vstop


# vector thread asm
.align 3
hgemm_opt_v_4_4_post:
    vpset vp0
    vsh vv2, va2  # C
    vsh vv5, va4  # C
    vsh vv9, va6  # C
    vsh vv10, va8  # C
    vstop


