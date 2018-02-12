## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_saxpy_asm
.type  vec_saxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa0 has float a  <---
# a1 has float* x
# a2 has float* y
vec_saxpy_asm:
    li t0, VCFG(0, 2, 0, 1)
    vsetcfg t0
    fmv.x.s a4, fa0
    vinsert v31, a4, zero
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vld v0, a1
    vld v1, a2
    # appears to be faster if we write into v1 instead of using a new reg?
    vmadd v1, v31, v0, v1
    vst v1, a2
    slli t1, t0, 2
    add a1, a1, t1
    add a2, a2, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret
