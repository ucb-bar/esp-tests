# See LICENSE for license details.

#*****************************************************************************
# vssd.S
#-----------------------------------------------------------------------------
#
# Test vmss instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 6,0
  li a2,2048
  vsetvl a2,a2

  la a3,src1
  vmss vs1,a3
  la a4,dest
  vmss vs2,a4
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a1,1
  la a4, dest
  ld a0,0(a4)
  addi TESTNUM,a1,2
  bne a0,a1,fail
  j pass

.align 3
vtcode:
  vlsd vs3,vs1
  vssd vs2,vs3
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
src1:
  .dword 1

.align 3
dest:
  .skip 16384

RVTEST_DATA_END
