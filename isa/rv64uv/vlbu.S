# See LICENSE for license details.

#*****************************************************************************
# vlbu.S
#-----------------------------------------------------------------------------
#
# Test vlbu instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 16,1
  li a4,512
  vsetvl a4,a4

  la a5,src
  vmca va1,a5
  la a6,dest
  vmca va2, a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a2,0
loop:
  lbu a0,0(a6)
  lbu a1,0(a5)
  addi TESTNUM,a2,2
  bne a0,a1,fail
  addi a6,a6,1
  addi a5,a5,1
  addi a2,a2,1
  bne a2,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vlbu vv1, va1
  vsb vv1, va2
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
