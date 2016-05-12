# See LICENSE for license details.

#*****************************************************************************
# amoand_d.S
#-----------------------------------------------------------------------------
#
# Test amoand.d instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,1
  li a4,2048
  vsetvl a4,a4

  la a5,amodest
  vmcs vs2,a5
  li a5,-1
  vmcs vs3,a5
  la a6,dest
  vmca va1,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,0
  li a2,0
loop:
  ld a0,0(a6)
  addi TESTNUM,a1,2
  bne a0,a2,fail
  addi a6,a6,8
  addi a1,a1,1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vadd.ss vv2,vs2,vs0
  vamoand.d.vs vv1,0(vv2),vs3
  vsd vv1, va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

amodest:
  .dword 0
dest:
  .skip 16384

RVTEST_DATA_END
