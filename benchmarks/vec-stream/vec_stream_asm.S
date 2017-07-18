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
    fmv.x.s a4, fa0
    vmcs vs1, a4
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a1
    vmca va1, a2
    la t5, stream_v
    vf 0(t5)
    slli t1, t0, 2
    add a1, a1, t1
    add a2, a2, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret

# vector thread asm
.align 3
stream_v:
    vpset vp0
    vlw vv0, va0
    vlw vv1, va1
    vfmul.s vv0, vv0, vv0
    vfmul.s vv1, vv1, vv1
    vfadd.s vv0, vv0, vv1
    vfsqrt.s vv0, vv0
    vsw vv0, va1
    vstop
