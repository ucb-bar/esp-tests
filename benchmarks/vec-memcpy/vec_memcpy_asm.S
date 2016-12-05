#include "vec-util.h"

.text
.align 2

.globl vec_copy_d_asm
.type vec_copy_d_asm,@function

# a0 -> dst
# a1 -> src
# a2 -> n
vec_copy_d_asm:
  li t0, VCFG(1, 0, 0, 1)
  vsetcfg t0
stripmine:
  vsetvl t0, a2
  vmca va0, a0
  vmca va1, a1
  la t1, vcopy_d
  vf 0(t1)
  // update # of remaining words
  sub a2, a2, t0
  // x8 for # of bytes
  slli t0, t0, 3
  // update addresses
  add a0, a0, t0
  add a1, a1, t0
  // check if we're done
  bnez a2, stripmine
  fence
  ret

.align 3
vcopy_d:
  vld vv0, va1
  vsd vv0, va0
  vstop
