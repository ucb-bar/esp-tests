# See LICENSE for license details.

#*****************************************************************************
# amoand_w.S
#-----------------------------------------------------------------------------
#
# Test amoand.w instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,0
  li a4,2048
  vsetvl a4,a4

  la a5,amodest
  vmss vs2,a5
  li a5,-1
  vmss vs3,a5
  la a6,dest
  vmsa va1,a6
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a1,0
  li a2,0
loop:
  lw a0,0(a6)
  addi TESTNUM,a1,2
  bne a0,a2,fail
  addi a6,a6,4
  addi a1,a1,1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vadd 1,0,0, vx2,vs2,vs0
  vamoand.w 1,0,1, vx1,vs3,vx2
  vsw vx1, va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

amodest:
  .word 0
dest:
  .skip 16384

RVTEST_DATA_END
