## Hwacha v4 stream ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_stream_asm
.type  vec_stream_asm,@function

# assumes calling convention:
# a0 has int n
# fa1 has float a  <---
# a2 has float* x
# a3 has float* y
vec_stream_asm:
    li t0, VCFG(0, 2, 0, 1)
    vsetcfg t0
    fmv.x.s a1, fa1
    vmcs vs1, a1
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a2
    vmca va1, a3
    la t5, stream_v
    vf 0(t5)
    slli t1, t0, 2
    add a2, a2, t1
    add a3, a3, t1
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
