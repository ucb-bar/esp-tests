# See LICENSE for license details.

#*****************************************************************************
# eidx_empty.S
#-----------------------------------------------------------------------------
#
# Test empty eidx instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 5,2
  li a2,2048
  vsetvl a2,a2

  la a4,dest
  vmca va1, a4
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,1
  li a5,0
loop:
  ld a0,0(a4)
  addi TESTNUM,a1,2
  and a3,a1,a5
  bne a0,a3,fail
  addi a4,a4,8
  addi a1,a1,1
  not a5,a5
  bne a1,a2,loop
  j pass

.align 3
vtcode:
  vpset vp0
  veidx vv1
  vaddi vs1,vs0,1
  vand.vs vv2,vv1,vs1
  vcmpeq.vs vp1,vv2,vs0
  @!vp1 veidx vv2
  @!vp1 vadd.vs vv2,vv2,vs1
  vsd vv2,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 16384

RVTEST_DATA_END
