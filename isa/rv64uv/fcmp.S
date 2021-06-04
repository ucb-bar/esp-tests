# See LICENSE for license details.

#*****************************************************************************
# fcmp.S
#-----------------------------------------------------------------------------
#
# Test vcmpf* instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a4, VCFG(0,2,1,2)
  vsetcfg a4
  li a4,2048
  vsetvl a4,a4

  la a5,src1
  vmcs vs1,a5
  la a6,src2
  vmca va1,a6
  la a7,dest
  vmca va2, a7
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a2,0
  flw f0,0(a5)
loop:
  flw f1,0(a6)
  lb a1,0(a7)
  flt.s a0,f0,f1
  addi TESTNUM,a2,2
  bne a0,a1,fail
  addi a7,a7,1
  addi a6,a6,4
  addi a2,a2,1
  bne a2,a4,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vlsw vs1,vs1
  vlw vv1,va1
  vcmpflt.s vp1,vs1,vv1
  vaddi vs2,vs0,1
  vadd vv2,vs0,vs0
@vp1 vor vv2,vv2,vs2
  vsb vv2,va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .float 1.0
src2:
#include "data_fw.h"

dest:
  .fill 2048,1,0xff

RVTEST_DATA_END
