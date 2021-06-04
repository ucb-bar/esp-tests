# See LICENSE for license details.

#*****************************************************************************
# amomin_w.S
#-----------------------------------------------------------------------------
#
# Test amomin.w instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a4, VCFG(0,4,0,1)
  vsetcfg a4
  li a4,2048
  vsetvl a4,a4

  li a5,-1
  vmcs vs1,a5
  la a5,amodest
  vmcs vs2,a5
  la a6,dest
  vmca va1,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,0
  li a2,-1
loop:
  lw a0,0(a5)
  addi TESTNUM,a1,2
  bne a0,a2,fail
  addi a5,a5,4
  addi a1,a1,1
  addi a2,a2,-1
  bne a1,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  veidx vv3
  vaddi vs3, vs0, 2
  vsll.vs vv3, vv3, vs3
  vadd.sv vv2, vs2, vv3
  veidx vv3
  vaddi vs3,vs0,1
  vadd.vs vv3,vv3,vs3
  vmul.vs vv3,vv3,vs1
  vadd.ss vv1,vs0,vs1
  vamomin.w.vv vv1,0(vv2),vv3
  vsw vv1,va1
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
