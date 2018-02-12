## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_sdaxpy_asm
.type  vec_sdaxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa0 has float a  <---
# a1 has float* x
# a2 has float* y
vec_sdaxpy_asm:
    li t0, VCFG(2, 1, 0, 1)
    vsetcfg t0
    fmv.x.d a4, fa0
    vinsert v31, a4, zero
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vld v2, va0
    vcvt v0, v2
    vld v1, a2
    vmadd v1, v31, v0, v1
    vst v1, a2
    slli t1, t0, 2
    slli t2, t0, 3
    add a1, a1, t1
    add a2, a2, t2
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret
