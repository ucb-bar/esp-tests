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

# vector thread asm
.align 3
mm_opt_v_4_4:
    vpset vp0
    vlw vv1, va1  # B
    vlw vv2, va2  # C
    vfmadd.s vv2, vv1, vs1, vv2
    vfmadd.s vv2, vv1, vs5, vv2
    vfmadd.s vv2, vv1, vs9, vv2
    vfmadd.s vv2, vv1, vs13, vv2
    vsw vv2, va2

    vlw vv3, va3  # B
    vlw vv4, va4  # C
    vfmadd.s vv4, vv3, vs2, vv4
    vfmadd.s vv4, vv3, vs6, vv4
    vfmadd.s vv4, vv3, vs10, vv4
    vfmadd.s vv4, vv3, vs14, vv4
    vsw vv4, va4
  
    vlw vv5, va5  # B
    vlw vv6, va6  # C
    vfmadd.s vv6, vv5, vs3, vv6
    vfmadd.s vv6, vv5, vs7, vv6
    vfmadd.s vv6, vv5, vs11, vv6
    vfmadd.s vv6, vv5, vs15, vv6
    vsw vv6, va6

    vlw vv7, va7  # B
    vlw vv8, va8  # C
    vfmadd.s vv8, vv7, vs4, vv7
    vfmadd.s vv8, vv7, vs8, vv7
    vfmadd.s vv8, vv7, vs12, vv7
    vfmadd.s vv8, vv7, vs16, vv7
    vsw vv8, va8
    vstop

