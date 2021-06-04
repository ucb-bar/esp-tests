## Hwacha v4 VVADD ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_vvadd_asm
.type  vec_vvadd_asm,@function

# assumes calling convention:
# a0 has int n
# a1 has float* result  <---
# a2 has float* x
# a3 has float* y
vec_vvadd_asm:
    li a4, VCFG(3, 0, 0, 1)
    vsetcfg a4
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a2
    vmca va1, a3
    vmca va2, a1
    la t5, vvadd_v
    vf 0(t5)
    slli t1, t0, 2
    add a1, a1, t1
    add a2, a2, t1
    add a3, a3, t1
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret

# vector thread asm
.align 3
vvadd_v:
    vpset vp0
    vlw vv0, va0
    vlw vv1, va1
    vfadd.s vv2, vv0, vv1
    vsw vv2, va2
    vstop
