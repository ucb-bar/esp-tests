## Hwacha v4 SAXPY ASM code

#include "vec-util.h"

.text

# vector thread asm
.align 3
.globl histo_v
histo_v:
    vpset vp0
    vlw vv0, va0
    vdivuw.vs vv1, vv0, vs1 # bin[i] = input_data[i] / scale
    vsll.vs vv0, vv1, vs2 # offset[i] = bin[i] * 4
    vadd.vs vv1, vv0, vs3 # addr[i] = offset[i] + output_bins
    vamoadd.w.vs vv0, 0(vv1), vs4 # old[i] = *addr[i]++
    vstop
