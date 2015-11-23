## Hwacha v4 SAXPY ASM code

.text
.align 2

.globl vec_sdaxpy_asm
.type  vec_sdaxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa1 has float a  <---
# a2 has float* x
# a3 has float* y
vec_sdaxpy_asm:
    vsetcfg 3, 1 # from TEST_CASE_NREG
    fmv.x.d a1, fa1
    vmss vs1, a1
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmsa va0, a2
    vmsa va1, a3
    la t5, sdaxpy_v
    vf 0(t5)
    fence
    slli t1, t0, 2
    slli t2, t0, 3
    add a2, a2, t1
    add a3, a3, t2
    sub a0, a0, t0
    bnez a0, stripmine
    ret

# vector thread asm
.align 3
sdaxpy_v:
    vpset vp0
    vlw vv0, va0
    vfcvt.d.s vv2, vv0
    vld vv1, va1
    vfmadd.d vv0, vs1, vv2, vv1
    vsd vv0, va1
    vstop
