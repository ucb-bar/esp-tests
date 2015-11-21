## Hwacha v4 VVADD ASM code

.text
.align 2

.globl vec_mm_naive_asm
.type  vec_mm_naive_asm,@function

# assumes calling convention:
# a0 has int n
# a1 has float* result  <---
# a2 has float* x
# a3 has float* y
vec_mm_naive_asm:
    ret

.globl mm_opt_v_2_2

# vector thread asm
.align 3
mm_opt_v_2_2:
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

.globl mm_opt_v_4_4
.globl mm_opt_v_4_4_pre
.globl mm_opt_v_4_4_post


.align 3
mm_opt_v_4_4_pre:
    vpset vp0
    vlw vv2, va2  # C
    vlw vv8, va4  # C
    vlw vv14, va6  # C
    vlw vv20, va8  # C
    vstop




# vector thread asm
.align 3
mm_opt_v_4_4:
    vpset vp0
    vlw vv1, va1  # B
    vfmadd.s vv3, vv1, vs1, vv2
    vfmadd.s vv4, vv1, vs5, vv3

    vlw vv7, va3  # B

    vfmadd.s vv5, vv1, vs9, vv4
    vfmadd.s vv2, vv1, vs13, vv5


    vfmadd.s vv9, vv7, vs2, vv8
    vfmadd.s vv10, vv7, vs6, vv9

    vlw vv13, va5  # B

    vfmadd.s vv11, vv7, vs10, vv10
    vfmadd.s vv8, vv7, vs14, vv11

    vfmadd.s vv15, vv13, vs3, vv14
    vfmadd.s vv16, vv13, vs7, vv15

    vlw vv19, va7  # B

    vfmadd.s vv17, vv13, vs11, vv16
    vfmadd.s vv14, vv13, vs15, vv17

    vfmadd.s vv21, vv19, vs4, vv20
    vfmadd.s vv22, vv19, vs8, vv21

    vfmadd.s vv23, vv19, vs12, vv22
    vfmadd.s vv20, vv19, vs16, vv23

    vstop

.align 3
mm_opt_v_4_4_post:
    vpset vp0
    vsw vv2, va2  # C
    vsw vv8, va4  # C
    vsw vv14, va6  # C
    vsw vv20, va8  # C
    vstop


