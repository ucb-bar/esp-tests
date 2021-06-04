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
  vmcs vs2,a5
  li a6,0xaaaaaaaaaaaaaaaa
  vmcs vs3, a6
  la a6,dest
  vmca va1,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,0
  li a2,-1
  li t0,0xaaaaaaaaaaaaaaaa
  xor a2,a2,t0
  xor a3,a2,t0
loop:
  ld a0,0(a6)
  addi TESTNUM,a1,2
  bne a0,a3,else
  j skip
else:
  bne a0,a2,fail
skip:
  addi a6,a6,8
  addi a1,a1,1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vadd.ss vv3,vs3,vs0
  vadd.ss vv2,vs2,vs0
  vamoxor.d.vv vv1,0(vv2),vv3
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
