# See LICENSE for license details.

#*****************************************************************************
# amomin_d.S
#-----------------------------------------------------------------------------
#
# Test amomin.d instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,1
  li a4,2048
  vsetvl a4,a4

  li a5,-1
  vmss vs1,a5
  la a5,amodest
  vmss vs2,a5
  la a6,dest
  vmsa va1,a6
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a1,0
  li a2,-1
loop:
  ld a0,0(a5)
  addi TESTNUM,a1,2
  bne a0,a2,fail
  addi a5,a5,8
  addi a1,a1,1
  addi a2,a2,-1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  veidx vv3
  vaddi vs3, vs0, 3
  vsll 1,1,0, vv3, vv3, vs3
  vadd 1,0,1, vv2, vs2, vv3
  veidx vv3
  vaddi vs3,vs0,1
  vadd 1,1,0, vv3,vv3,vs3
  vmul 1,1,0, vv3,vv3,vs1
  vadd 1,0,0, vv1,vs0,vs1
  vamomin.d 1,1,1, vv1,vv3,0(vv2)
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

amodest:
  .skip 16384
dest:
  .skip 16384

RVTEST_DATA_END
