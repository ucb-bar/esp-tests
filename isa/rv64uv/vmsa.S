# See LICENSE for license details.

#*****************************************************************************
# vmsa.S
#-----------------------------------------------------------------------------
#
# Test vmsa instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 3,1
  li a2,4
  vsetvl a2,a2

  la a3,src1
  vmsa va1,a3
  la a4,dest
  vmsa va2,a4
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a1,0
loop:
  ld a0,0(a4)
  addi TESTNUM,a1,2
  bne a0,a1,fail
  addi a4,a4,8
  addi a1,a1,1
  bne a1,a2,loop
  j pass

.align 3
vtcode:
  vld vx1,va1
  vsd vx1,va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
src1:
  .dword 0
  .dword 1
  .dword 2
  .dword 3

dest:
  .skip 16384

RVTEST_DATA_END
