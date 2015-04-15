# See LICENSE for license details.

#*****************************************************************************
# vvadd_d.S
#-----------------------------------------------------------------------------
#
# Test vvadd d.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 32,0
  li a3,4
  vsetvl a3,a3

  la a3,src1
  vmsa va2,a3
  la a4,src2
  vmsa va3,a4
  la a5,dest
  vmsa va1,a5
  lui a0,%hi(vtcode1)
  vf %lo(vtcode1)(a0)
  fence

  ld a1,0(a5)
  li a2,5
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a5)
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a5)
  li TESTNUM,4
  bne a1,a2,fail
  ld a1,24(a5)
  li TESTNUM,5
  bne a1,a2,fail

  la a3,src1
  vmsa va2,a3
  la a5,dest
  vmsa va1,a5
  lui a0,%hi(vtcode2)
  vf %lo(vtcode2)(a0)
  fence

  ld a1,0(a5)
  li a2,1
  li TESTNUM,6
  bne a1,a2,fail
  ld a1,8(a5)
  li a2,2
  li TESTNUM,7
  bne a1,a2,fail
  ld a1,16(a5)
  li a2,3
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,24(a5)
  li a2,4
  li TESTNUM,9
  bne a1,a2,fail

  la a3,src2
  vmsa va2,a3
  la a5,dest
  vmsa va1,a5
  lui a0,%hi(vtcode3)
  vf %lo(vtcode3)(a0)
  fence

  ld a1,0(a5)
  li a2,4
  li TESTNUM,6
  bne a1,a2,fail
  ld a1,8(a5)
  li a2,3
  li TESTNUM,7
  bne a1,a2,fail
  ld a1,16(a5)
  li a2,2
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,24(a5)
  li a2,1
  li TESTNUM,9
  bne a1,a2,fail

  j pass

.align 3
vtcode1:
  vld vx2,va2
  vld vx3,va3
  vadd 1,1,1, vx2,vx2,vx3
  vsd vx2,va1
  vstop

.align 3
vtcode2:
  vld vx2,va2
  vadd 1,0,1, vx1,vs0,vx2
  vsd vx1,va1
  vstop

.align 3
vtcode3:
  vld vx2,va2
  vadd 1,1,0, vx1,vx2,vs0
  vsd vx1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .dword 1
  .dword 2
  .dword 3
  .dword 4
src2:
  .dword 4
  .dword 3
  .dword 2
  .dword 1
dest:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe

RVTEST_DATA_END
