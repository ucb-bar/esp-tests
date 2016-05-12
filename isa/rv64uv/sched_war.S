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

  la a5,src
  ld a6,0(a5)
  vmcs vs1,a6
  ld a6,8(a5)
  vmcs vs2,a6
  ld a6,16(a5)
  vmcs vs3,a6
  li a6,24
  vmcs vs4,a6

  la a5,dest1
  vmca va0,a5
  la a6,dest2
  vmca va1,a6
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
1:auipc a0,%pcrel_hi(vtcode2)
  vf %pcrel_lo(1b)(a0)
  fence

  li a0, 0
  la a2, result
  ld a2, 0(a2)
loop2:
  ld a1, 0(a5)
  add t0, a0, 2
  mv TESTNUM,t0
  bne a2, a1, fail
  add a0, a0, 1
  add a5, a5, 8
  bne a0, a3, loop2

  li a0, 0
  li a2, 48
loop:
  ld a1, 0(a6)
  add t0, a0, 1000
  mv TESTNUM, t0
  bne a2, a1, fail
  add a0, a0, 1
  add a6, a6, 8
  bne a0, a3, loop

  j pass

.align 3
vtcode1:
  vpset vp0
  vadd vv0, vs0, vs1
  vadd vv1, vs0, vs2
  vadd vv2, vs0, vs3
  vstop
vtcode2:
  vpset vp0
  vfmadd.d vv3, vv0, vv1, vv2
  vadd vv2, vs4, vs4
  vsd vv3, va0
  vsd vv2, va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src:
  .double 0.5
  .double 1.0
  .double 2.0
dest1:
  .skip 1024
dest2:
  .skip 1024
result:
  .double 2.5

RVTEST_DATA_END
