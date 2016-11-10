#include "vec-util.h"

.text
.align 2

.globl vec_copy_d_asm
.type vec_copy_d_asm,@function

# a0 -> dst
# a1 -> src
# a2 -> n
vec_copy_d_asm:
  li t0, VCFG(2, 0, 0, 1)
  vsetcfg t0
stripmine:
  vsetvl t0, a2
  vmca va0, a0
  vmca va1, a1
  la t1, vcopy_d
  vf 0(t1)
  sub a0, a0, t0
  bnez a0, stripmine
  fence
  ret

.align 3
vcopy_d:
  vld vv0, va1
  vsd vv0, va0
  vstop
