## Hwacha v4 VVADD ASM code

.text
.align 2

.globl vec_sgemm_naive_asm
.type  vec_sgemm_naive_asm,@function

# assumes calling convention:
# a0 has int n
# a1 has float* result  <---
# a2 has float* x
# a3 has float* y
vec_sgemm_naive_asm:
    ret

.globl sgemm_naive_v

# vector thread asm
.align 3
sgemm_naive_v:
    vld v0, va1  # B
    vld v1, va2  # C
    vmadd v2, v0, vs1, v1 
    vst v2, va2  # store back to C
