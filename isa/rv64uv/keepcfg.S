# See LICENSE for license details.

#*****************************************************************************
# utidx.S
#-----------------------------------------------------------------------------
#
# Test utidx instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 2,0
  li s0,2048
  vsetvl s0,s0

  la a4,dest1
  vmsa va1, a4
  lui a0,%hi(vtcode1)
  vf %lo(vtcode1)(a0)

  vsetcfg 3,0
  li s1,2048
  vsetvl s1,s1

  la a4,dest2
  vmsa va1,a4
  lui a0,%hi(vtcode2)
  vf %lo(vtcode2)(a0)

  fence

  la a4,dest1
  li a1,1
loop1:
  ld a0,0(a4)
  addi TESTNUM,a1,2
  bne a0,a1,fail
  addi a4,a4,8
  addi a1,a1,1
  bne a1,s0,loop1

  la a4,dest2
  li a1,1024
  li a2,1
loop2:
  ld a0,0(a4)
  addi TESTNUM,a1,2
  bne a0,a1,fail
  addi a4,a4,8
  addi a1,a1,1
  addi a2,a2,1
  bne a2,s1,loop2

  j pass

vtcode1:
  veidx vx1
  vaddi vs1,vs0,1
  vadd 1,1,0, vx1,vx1,vs1
  vsd vx1,va1
  vstop

vtcode2:
  veidx vx1
  vaddi vs1,vs0,1024
  vadd 1,1,0, vx1,vx1,vs1
  vsd vx1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest1:
  .skip 16384

dest2:
  .skip 16384

RVTEST_DATA_END
