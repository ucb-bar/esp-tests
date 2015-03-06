# See LICENSE for license details.

#*****************************************************************************
# vmss.S
#-----------------------------------------------------------------------------
#
# Test vmss instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 3,0
  li a2,2048
  vsetvl a2,a2

  li a3,-1
  vmss vs2,a3
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

vtcode:
  veidx vx1
  vaddi vs1,vs0,1
  vadd 1,1,0, vx1, vx1, vs1
  vadd 1,1,0, vx2,vx1,vs2
  vsd vx2,va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 16384

RVTEST_DATA_END
