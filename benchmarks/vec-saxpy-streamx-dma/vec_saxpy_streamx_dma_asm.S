## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text
.align 2

# vector thread asm
.align 3
.globl saxpy_streamx_v
saxpy_streamx_v:
    vpset vp0
    vlw vv0, va0
    vlw vv1, va1
    # appears to be faster if we write into vv1 instead of using a new reg?
    vfmadd.s vv1, vs1, vv0, vv1
    vsw vv1, va1
    vstop
