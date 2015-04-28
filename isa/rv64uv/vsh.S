# See LICENSE for license details.

#*****************************************************************************
# vlh.S
#-----------------------------------------------------------------------------
#
# Test vlh instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 16,1
  li a4,512
  vsetvl a4,a4

  la a5,src
  vmsa va1,a5
  la a6,dest
  vmsa va2, a6
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a2,0
loop:
  lh a0,0(a6)
  lh a1,0(a5)
  addi TESTNUM,a2,2
  bne a0,a1,fail
  addi a6,a6,2
  addi a5,a5,2
  addi a2,a2,1
  bne a2,a4,loop
  j pass

.align 3
vtcode:
  vlh vv1, va1
  vsh vv1, va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src:
#include "data_d.h"

dest:
  .skip 16384

RVTEST_DATA_END
