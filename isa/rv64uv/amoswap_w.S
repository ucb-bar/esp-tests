# See LICENSE for license details.

#*****************************************************************************
# amoswap_w.S
#-----------------------------------------------------------------------------
#
# Test amoswap.w instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a4, VCFG(0,4,0,1)
  vsetcfg a4
  li a4,2048
  vsetvl a4,a4

  la a5,amodest
  vmcs vs2,a5
  la a6,dest
  vmca va1,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

#mark each value in an array
  li a1, 0
  la a2, tracker
  li a5, 1
tracker_loop:
  lw a0,0(a6)
  add a3, a2, a0
  sb a5, 0(a3)
  addi a6,a6,4
  addi a1,a1,1
  bne a1,a4,tracker_loop

#check that each value in the array is set
# NOTE: we actually only guarantee that vlen unique numbers between 0 and vlen
# inclusive are returned. The last amoswap doesn't need to be vlen it could
# be any other index and that index will not be in the tracker
  li a1,0
  li a3,0
loop:
  lb a0,0(a2)
  addi TESTNUM,a1,2
  bnez a0,1f
  bnez a3, fail
  addi a3, x0, 1
1:addi a2,a2,1
  addi a1,a1,1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  veidx vv3
  vaddi vs3,vs0,1
  vadd.vs vv3,vv3,vs3
  vadd.ss vv2,vs2,vs0
  vamoswap.w.vv vv1,0(vv2),vv3
  vsw vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  .skip 4
amodest:
  .word 0
dest:
  .skip 16384
tracker:
  .skip 16384

RVTEST_DATA_END
