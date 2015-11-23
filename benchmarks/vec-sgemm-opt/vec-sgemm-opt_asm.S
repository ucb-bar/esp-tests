## Hwacha v4 VVADD ASM code

.text
.align 2

.globl sgemm_opt_v_2_2

# vector thread asm
.align 3
sgemm_opt_v_2_2:
    vpset vp0
    
    vlw vv0, va1  # B
    vlw vv1, va2  # C
    vfmadd.s vv2, vv0, vs1, vv1 

    vlw vv3, va3  # B
    vlw vv4, va4  # C
    vfmadd.s vv7, vv3, vs2, vv4 

    vfmadd.s vv5, vv0, vs3, vv2 
    vsw vv5, va2  # store back to C

    vfmadd.s vv6, vv3, vs4, vv7 
    vsw vv6, va4  # store back to C

    vstop

.globl sgemm_opt_v_4_4
.globl sgemm_opt_v_4_4_pre
.globl sgemm_opt_v_4_4_post


.align 3
sgemm_opt_v_4_4_pre:
    vpset vp0
    vlw vv2, va2  # C
    vlw vv5, va4  # C
    vlw vv9, va6  # C
    vlw vv10, va8  # C
    vstop

# vector thread asm
.align 3
sgemm_opt_v_4_4:
    vpset vp0
    vlw vv0, va1  # B
    vfmadd.s vv1, vv0, vs1, vv2
    vfmadd.s vv11, vv0, vs5, vv5
    vlw vv6, va3  # B
    vfmadd.s vv14, vv0, vs9, vv9
    vfmadd.s vv17, vv0, vs13, vv10

    vlw vv7, va5  # B



    vfmadd.s vv3, vv6, vs2, vv1
    vfmadd.s vv12, vv6, vs6, vv11

    vlw vv8, va7  # B


    vfmadd.s vv4, vv7, vs3, vv3
    vfmadd.s vv2, vv8, vs4, vv4


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
sgemm_opt_v_4_4_post:
    vpset vp0
    vsw vv2, va2  # C
    vsw vv5, va4  # C
    vsw vv9, va6  # C
    vsw vv10, va8  # C
    vstop


