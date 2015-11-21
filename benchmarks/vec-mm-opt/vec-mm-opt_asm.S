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
    vlw vv5, va4  # C
    vlw vv11, va6  # C
    vlw vv16, va8  # C
    vstop

# vector thread asm
.align 3
mm_opt_v_4_4:
    vpset vp0
    vlw vv0, va1  # B

    vfmadd.s vv1, vv0, vs1, vv2
    vfmadd.s vv3, vv0, vs5, vv1

    vlw vv6, va3  # B

    vfmadd.s vv4, vv0, vs9, vv3
    vfmadd.s vv2, vv0, vs13, vv4


    vfmadd.s vv7, vv6, vs2, vv5
    vfmadd.s vv8, vv6, vs6, vv7

    vlw vv10, va5  # B

    vfmadd.s vv9, vv6, vs10, vv8
    vfmadd.s vv5, vv6, vs14, vv9

    vfmadd.s vv12, vv10, vs3, vv11
    vfmadd.s vv13, vv10, vs7, vv12

    vlw vv15, va7  # B

    vfmadd.s vv14, vv10, vs11, vv13
    vfmadd.s vv11, vv10, vs15, vv14

    vfmadd.s vv17, vv15, vs4, vv16
    vfmadd.s vv18, vv15, vs8, vv17

    vfmadd.s vv19, vv15, vs12, vv18
    vfmadd.s vv16, vv15, vs16, vv19
    vstop

.align 3
mm_opt_v_4_4_post:
    vpset vp0
    vsw vv2, va2  # C
    vsw vv5, va4  # C
    vsw vv11, va6  # C
    vsw vv16, va8  # C
    vstop


