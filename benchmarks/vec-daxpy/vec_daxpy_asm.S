## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_daxpy_asm
.type  vec_daxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa1 has float a  <---
# a2 has float* x
# a3 has float* y
vec_daxpy_asm:
    li t0, VCFG(2, 0, 0, 1)
    vsetcfg t0
    fmv.x.d a1, fa1
    vmcs vs1, a1
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a2
    vmca va1, a3
    la t5, daxpy_v
    vf 0(t5)
    slli t1, t0, 3
    add a2, a2, t1
    add a3, a3, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret

# vector thread asm
.align 3
daxpy_v:
    vpset vp0
    vld vv0, va0
    vld vv1, va1
    vfmadd.d vv1, vs1, vv0, vv1
    vsd vv1, va1
    vstop
