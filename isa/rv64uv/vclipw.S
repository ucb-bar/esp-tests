# See LICENSE for license details.

#*****************************************************************************
# vclipw.S
#-----------------------------------------------------------------------------
#
# Test vclipw.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a3, VCFG(32,0,0,1)
  vsetcfg a3
  li a3,9
  vsetvl a3,a3
  li a3,0
  vsetxrm a3,a3

  la a3,src1
  vmca va2,a3
  la a4,src2
  vmca va3,a4
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  lw a1,0(a5)
  li a2,1
  li TESTNUM,2
  bne a1,a2,fail
  lw a1,4(a5)
  li a2,2
  li TESTNUM,3
  bne a1,a2,fail
  lw a1,8(a5)
  li a2,2
  li TESTNUM,4
  bne a1,a2,fail
  lw a1,12(a5)
  li a2,3
  li TESTNUM,5
  bne a1,a2,fail
  lw a1,16(a5)
  li a2,3
  li TESTNUM,6
  bne a1,a2,fail
  lw a1,20(a5)
  li a2,4
  li TESTNUM,7
  bne a1,a2,fail
  lw a1,24(a5)
  li a2,4
  li TESTNUM,8
  bne a1,a2,fail
  lw a1,28(a5)
  li a2,5
  li TESTNUM,9
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vld vv2,va2
  vlw vv3,va3
  vclipw vv5,vv2,vv3
  vsw vv5,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .dword 0x000100000000
  .dword 0x000180000000
  .dword 0x000200000000
  .dword 0x000280000000
  .dword 0x000300000000
  .dword 0x000380000000
  .dword 0x000400000000
  .dword 0x000480000000
  .dword 0x000500000000
src2:
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
  .word 0x20
dest:
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef

RVTEST_DATA_END
