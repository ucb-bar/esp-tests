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

.globl mm_naive_v

# vector thread asm
.align 3
mm_naive_v:
    vpset vp0
    vlw vv0, va1  # B
    vlw vv1, va2  # C
    vfmul.s vv0, vv0, vs1 
    vfadd.s vv1, vv0, vv1
    vsw vv1, va2  # store back to C
    vstop
