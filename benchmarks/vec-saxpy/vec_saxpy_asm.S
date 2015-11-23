## Hwacha v4 SAXPY ASM code

.text
.align 2

.globl vec_saxpy_asm
.type  vec_saxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa1 has float a  <---
# a2 has float* x
# a3 has float* y
vec_saxpy_asm:
    li t0, 33280
    vsetcfg t0 # from TEST_CASE_NREG
    fmv.x.s a1, fa1
    vmss vs1, a1
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmsa va0, a2
    vmsa va1, a3
    la t5, saxpy_v
    vf 0(t5)
    fence
    slli t1, t0, 2
    add a2, a2, t1
    add a3, a3, t1
    sub a0, a0, t0
    bnez a0, stripmine
    ret

# vector thread asm
.align 3
saxpy_v:
    vpset vp0
    vlw vv0, va0
    vlw vv1, va1
    # appears to be faster if we write into vv1 instead of using a new reg?
    vfmadd.s vv1, vs1, vv0, vv1
    vsw vv1, va1
    vstop
