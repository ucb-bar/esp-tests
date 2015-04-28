# See LICENSE for license details.

#*****************************************************************************
# amoxor_d.S
#-----------------------------------------------------------------------------
#
# Test amoxor.d instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,1
  li a4,2048
  vsetvl a4,a4

  la a5,amodest
  vmss vs2,a5
  li a6,0xaaaaaaaaaaaaaaaa
  vmss vs3, a6
  la a6,dest
  vmsa va1,a6
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a1,0
  li a2,-1
  li t0,0xaaaaaaaaaaaaaaaa
loop:
  ld a0,0(a6)
  addi TESTNUM,a1,2
  bne a0,a2,fail
  addi a6,a6,8
  addi a1,a1,1
  xor a2,a2,t0
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vadd 1,0,0, vv3,vs3,vs0
  vadd 1,0,0, vv2,vs2,vs0
  vamoxor.d 1,1,1, vv1,vv3,0(vv2)
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

amodest:
  .dword -1
dest:
  .skip 16384

RVTEST_DATA_END
