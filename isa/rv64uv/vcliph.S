# See LICENSE for license details.

#*****************************************************************************
# vvadd_w.S
#-----------------------------------------------------------------------------
#
# Test vvadd w.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a3, VCFG(0,32,0,1)
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
  lh a1,0(a5)
  li a2,1
  li TESTNUM,2
  bne a1,a2,fail
  lh a1,2(a5)
  li a2,2
  li TESTNUM,3
  bne a1,a2,fail
  lh a1,4(a5)
  li a2,2
  li TESTNUM,4
  bne a1,a2,fail
  lh a1,6(a5)
  li a2,3
  li TESTNUM,5
  bne a1,a2,fail
  lh a1,8(a5)
  li a2,3
  li TESTNUM,6
  bne a1,a2,fail
  lh a1,10(a5)
  li a2,4
  li TESTNUM,7
  bne a1,a2,fail
  lh a1,12(a5)
  li a2,4
  li TESTNUM,8
  bne a1,a2,fail
  lh a1,14(a5)
  li a2,5
  li TESTNUM,9
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vlw vv2,va2
  vlh vv3,va3
  vcliph vv5,vv2,vv3
  vsh vv5,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .word 0x00010000
  .word 0x00018000
  .word 0x00020000
  .word 0x00028000
  .word 0x00030000
  .word 0x00038000
  .word 0x00040000
  .word 0x00048000
  .word 0x00050000
src2:
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
  .hword 0x10
dest:
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead
  .hword 0xdead

RVTEST_DATA_END
