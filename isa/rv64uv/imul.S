# See LICENSE for license details.

#*****************************************************************************
# imul.S
#-----------------------------------------------------------------------------
#
# Test imul instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 3,1
  li a3,2048
  vsetvl a3,a3

  li a4,20
  li s0,2
  vmcs vs1,a4
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)

  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  mul s1,a4,s0

  fence

  li s2,40
  li TESTNUM,2
  bne s1,s2,fail

  li a1,0
  li a2,0
loop:
  ld a0,0(a5)
  addi TESTNUM,a2,3
  bne a0,a1,fail
  addi a5,a5,8
  addi a1,a1,20
  addi a2,a2,1
  bne a2,a3,loop
  j pass

.align 3
vtcode:
  vpset vp0
  veidx vv2
  vmul.vs vv1,vv2,vs1
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 16384

RVTEST_DATA_END
