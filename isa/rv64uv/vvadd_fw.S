# See LICENSE for license details.

#*****************************************************************************
# vvadd_fw.S
#-----------------------------------------------------------------------------
#
# Test vvadd fw.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 32,32
  li a3,4
  vsetvl a3,a3

  la a3,src1
  vmsa va2,a3
  la a4,src2
  vmsa va3,a4
  la a5,dest
  vmsa va1,a5
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence
  la a6,result
  lw a1,0(a5)
  lw a2,0(a6)
  li TESTNUM,2
  bne a1,a2,fail
  lw a1,4(a5)
  li TESTNUM,3
  bne a1,a2,fail
  lw a1,8(a5)
  li TESTNUM,4
  bne a1,a2,fail
  lw a1,12(a5)
  li TESTNUM,5
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vlw vv2,va2
  vlw vv3,va3
  vfadd.s 1,1,1, vv2,vv2,vv3
  vsw vv2,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .single 0.1
  .single 0.2
  .single 0.3
  .single 0.4
src2:
  .single 0.4
  .single 0.3
  .single 0.2
  .single 0.1
dest:
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
result:
  .single 0.5
  .single 0.5
  .single 0.5
  .single 0.5

RVTEST_DATA_END
