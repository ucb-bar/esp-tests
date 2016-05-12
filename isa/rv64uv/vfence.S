# See LICENSE for license details.

#*****************************************************************************
# vfence.S
#-----------------------------------------------------------------------------
#
# Test vfence instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 2,1
  li a2,2048
  vsetvl a2,a2

  la a4,dest
  vmca va1, a4
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,1
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
  veidx vv1
  vaddi vs1,vs0,1
  vadd.vs vv1,vv1,vs1
  vsd vv1,va1
  vfence
  vld vv0,va1
  vfence
  vsd vv0,va1
  vfence
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 16384

RVTEST_DATA_END
