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
    vmcs vs1, a3
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a1
    vmca va1, a2
    la t5, hsaxpy_v
    vf 0(t5)
    slli t1, t0, 1
    slli t2, t0, 2
    add a1, a1, t1
    add a2, a2, t2
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret

# vector thread asm
.align 3
hsaxpy_v:
    vpset vp0
    vlh vv2, va0
    vfcvt.s.h vv0, vv2
    vlw vv1, va1
    vfmadd.s vv1, vs1, vv0, vv1
    vsw vv1, va1
    vstop
