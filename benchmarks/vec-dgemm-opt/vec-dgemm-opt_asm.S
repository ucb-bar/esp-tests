## Hwacha v4 VVADD ASM code

.text
.align 2

.globl dgemm_opt_v_4_4
.globl dgemm_opt_v_4_4_pre
.globl dgemm_opt_v_4_4_post



# vector thread asm
.align 3
dgemm_opt_v_4_4_pre:
    vpset vp0
    vld vv2, va2  # C
    vld vv5, va4  # C
    vld vv9, va6  # C
    vld vv10, va8  # C
    vstop


# vector thread asm
.align 3
dgemm_opt_v_4_4:
    vpset vp0
    vld vv0, va1  # B
    vfmadd.d vv1, vv0, vs1, vv2
    vfmadd.d vv11, vv0, vs5, vv5
    vld vv6, va3  # B
    vfmadd.d vv14, vv0, vs9, vv9
    vfmadd.d vv13, vv0, vs13, vv10

    vld vv7, va5  # B



    vfmadd.d vv3, vv6, vs2, vv1
    vfmadd.d vv12, vv6, vs6, vv11

    vld vv8, va7  # B


    vfmadd.d vv4, vv7, vs3, vv3
    vfmadd.d vv2, vv8, vs4, vv4


    vfmadd.d vv11, vv7, vs7, vv12
    vfmadd.d vv5, vv8, vs8, vv11

    vfmadd.d vv15, vv6, vs10, vv14
    vfmadd.d vv4, vv7, vs11, vv15
    vfmadd.d vv9, vv8, vs12, vv4

    vfmadd.d vv3, vv6, vs14, vv13
    vfmadd.d vv1, vv7, vs15, vv3
    vfmadd.d vv10, vv8, vs16, vv1



    vstop


# vector thread asm
.align 3
dgemm_opt_v_4_4_post:
    vpset vp0
    vsd vv2, va2  # C
    vsd vv5, va4  # C
    vsd vv9, va6  # C
    vsd vv10, va8  # C
    vstop


