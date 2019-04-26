# See LICENSE for license details.

#*****************************************************************************
# vclipb.S
#-----------------------------------------------------------------------------
#
# Test vclipb
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
  lb a1,0(a5)
  li a2,1
  li TESTNUM,2
  bne a1,a2,fail
  lb a1,1(a5)
  li a2,2
  li TESTNUM,3
  bne a1,a2,fail
  lb a1,2(a5)
  li a2,2
  li TESTNUM,4
  bne a1,a2,fail
  lb a1,3(a5)
  li a2,3
  li TESTNUM,5
  bne a1,a2,fail
  lb a1,4(a5)
  li a2,3
  li TESTNUM,6
  bne a1,a2,fail
  lb a1,5(a5)
  li a2,4
  li TESTNUM,7
  bne a1,a2,fail
  lb a1,6(a5)
  li a2,4
  li TESTNUM,8
  bne a1,a2,fail
  lb a1,7(a5)
  li a2,5
  li TESTNUM,9
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vlh vv2,va2
  vlb vv3,va3
  vclipb vv5,vv2,vv3
  vsb vv5,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .hword 0x0100
  .hword 0x0180
  .hword 0x0200
  .hword 0x0280
  .hword 0x0300
  .hword 0x0380
  .hword 0x0400
  .hword 0x0480
  .hword 0x0500
src2:
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
  .byte 0x8
dest:
  .byte 0xde
  .byte 0xad
  .byte 0xbe
  .byte 0xef
  .byte 0xde
  .byte 0xad
  .byte 0xbe
  .byte 0xef
  .byte 0xde

RVTEST_DATA_END
