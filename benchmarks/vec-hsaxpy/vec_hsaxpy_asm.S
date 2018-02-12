## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_hsaxpy_asm
.type  vec_hsaxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa0 has float a  <---
# a1 has float* x
# a2 has float* y
vec_hsaxpy_asm:
    li t0, VCFG(0, 2, 1, 1)
    vsetcfg t0
    fmv.x.s a3, fa0
    vinsert v31, a3, zero
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vld v2, a1
    vcvt v0, v2
    vld v1, a2
    vmadd v1, v31, v0, v1
    vst v1, a2
    slli t1, t0, 1
    slli t2, t0, 2
    add a1, a1, t1
    add a2, a2, t2
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret
