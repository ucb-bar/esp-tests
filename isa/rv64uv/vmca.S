# See LICENSE for license details.

#*****************************************************************************
# vmca.S
#-----------------------------------------------------------------------------
#
# Test vmca instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 3,1
  li a2,4
  vsetvl a2,a2

  la a3,src1
  vmca va1,a3
  la a4,dest
  vmca va2,a4
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
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
  vpset vp0
  vld vv1,va1
  vsd vv1,va2
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
