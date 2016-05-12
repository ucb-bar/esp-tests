# See LICENSE for license details.

#*****************************************************************************
# ld.S
#-----------------------------------------------------------------------------
#
# Test ld instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 16,1
  li a4,8
  vsetvl a4,a4

  la a5,src
  la a6,dest
  vmcs vs1,a5
  vmcs vs2,a6
  vmca va1,a5
  vmca va2,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a2,0
loop:
  ld a0,0(a6)
  ld a1,0(a5)
  addi TESTNUM,a2,2
  bne a0,a1,fail
  addi a6,a6,8
  addi a5,a5,8
  addi a2,a2,1
  bne a2,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  veidx vv3
  vaddi vs3,vs0,3
  vsll.vs vv3,vv3,vs3
  vadd.sv vv2,vs2,vv3
  vsd vv2,va2
  vlxd vv3,vs0,vv2
  vlxd vv4,vs0,vv3
  vlxd vv5,vs0,vv4
  vsd vv5,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src:
#include "data_d.h"

dest:
  .skip 16384

RVTEST_DATA_END
