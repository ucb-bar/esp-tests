## Hwacha v4 VVADD ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_vadd_asm
.type  vec_vadd_asm,@function

# assumes calling convention:
# a0 has int n
# a1 has float* result  <---
# a2 has float* x
# a3 has float* y
vec_vadd_asm:
    li a4, VCFG(3, 0, 0, 1)
    vsetcfg a4
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vld v0, a2
    vld v1, a3
    vadd v2, v0, v1
    vst v2, a1
    slli t1, t0, 2
    add a1, a1, t1
    add a2, a2, t1
    add a3, a3, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret
