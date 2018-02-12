## Hwacha v4 stream ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_stream_asm
.type  vec_stream_asm,@function

# assumes calling convention:
# a0 has int n
# fa0 has float a  <---
# a1 has float* x
# a2 has float* y
vec_stream_asm:
    li t0, VCFG(0, 2, 0, 1)
    vsetcfg t0
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vld v0, a1
    vld v1, a2
    vmul v0, v0, v0
    vmul v1, v1, v1
    vadd v0, v0, v1
    vsqrt v0, v0
    vst v0, a2
    slli t1, t0, 2
    add a1, a1, t1
    add a2, a2, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret
