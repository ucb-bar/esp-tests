# See LICENSE for license details.

#*****************************************************************************
# vvadd_d.S
#-----------------------------------------------------------------------------
#
# Direct test for scheduling sreg and xbar.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 8,1
  li a3,128
  vsetvl a3,a3

  li a5, 1024
  vmcs vs1, a5
  la a5,dest
  vmca va0,a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  li a0, 0
loop:
  ld a1, 0(a5)
  add t0, a0, 2
  mv TESTNUM,t0
  bne a0, a1, fail
  add a0, a0, 1
  add a5, a5, 8
  bne a0, a3, loop

  j pass

.align 3
vtcode1:
  vpset vp0
  vmul vv0, vs1, vs1
  veidx vv0
  vsd vv0, va0
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 1024

RVTEST_DATA_END
