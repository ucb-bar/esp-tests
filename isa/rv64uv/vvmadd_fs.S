# See LICENSE for license details.

#*****************************************************************************
# vvmadd_fs.S
#-----------------------------------------------------------------------------
#
# Test vvmadd fs.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a3, VCFG(0,32,0,1)
  li a3,8
  vsetvl a3,a3

  la a3,srcC
  vmca va0,a3
  la a4,srcA
  vmca va1,a4
  la a5,srcB
  vmca va3,a5
  addi a5, a5, 32
  vmca va4,a5
  addi a5, a5, 32
  vmca va5,a5
  addi a5, a5, 32
  vmca va6,a5
  addi a5, a5, 32
  vmca va7,a5
  addi a5, a5, 32
  vmca va8,a5
  addi a5, a5, 32
  vmca va9,a5
  addi a5, a5, 32
  vmca va10,a5
  la a6,dest
  vmca va2,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  la a5,dest
  la a6,result
  lw a1,0(a5)
  lw a2,0(a6)
  li TESTNUM,2
  bne a1,a2,fail
  lw a1,4(a5)
  lw a2,4(a6)
  li TESTNUM,3
  bne a1,a2,fail
  lw a1,8(a5)
  lw a2,8(a6)
  li TESTNUM,4
  bne a1,a2,fail
  lw a1,12(a5)
  lw a2,12(a6)
  li TESTNUM,5
  bne a1,a2,fail
  lw a1,16(a5)
  lw a2,16(a6)
  li TESTNUM,6
  bne a1,a2,fail
  lw a1,20(a5)
  lw a2,20(a6)
  li TESTNUM,7
  bne a1,a2,fail
  lw a1,24(a5)
  lw a2,24(a6)
  li TESTNUM,8
  bne a1,a2,fail
  lw a1,28(a5)
  lw a2,28(a6)
  li TESTNUM,9
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vlw vv0,va0 #c0
  vlw vv1,va1 #a
  vlw vv2,va3 #b0
  vlw vv3,va4 #b1
  vlw vv4,va5 #b2
  vlw vv5,va6 #b3
  vlw vv6,va7 #b4
  vlw vv7,va8 #b5
  vlw vv8,va9 #b6
  vlw vv9,va10 #b7
  vfvmmadd.s.vvv vv0, vv1, vv2, vv0, 8  #c0 =+ a*b
  vsw vv0,va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

srcA:
  .single 1.0
  .single 2.0
  .single 3.0
  .single 4.0
  .single 5.0
  .single 6.0
  .single 7.0
  .single 8.0
srcB:
  .single 1.0
  .single 2.0
  .single 3.0
  .single 4.0
  .single 5.0
  .single 6.0
  .single 7.0
  .single 8.0
  .single 9.0
  .single 10.0
  .single 11.0
  .single 12.0
  .single 13.0
  .single 14.0
  .single 15.0
  .single 16.0
  .single 17.0
  .single 18.0
  .single 19.0
  .single 20.0
  .single 21.0
  .single 22.0
  .single 23.0
  .single 24.0
  .single 25.0
  .single 26.0
  .single 27.0
  .single 28.0
  .single 29.0
  .single 30.0
  .single 31.0
  .single 32.0
  .single 33.0
  .single 34.0
  .single 35.0
  .single 36.0
  .single 37.0
  .single 38.0
  .single 39.0
  .single 40.0
  .single 41.0
  .single 42.0
  .single 43.0
  .single 44.0
  .single 45.0
  .single 46.0
  .single 47.0
  .single 48.0
  .single 49.0
  .single 50.0
  .single 51.0
  .single 52.0
  .single 53.0
  .single 54.0
  .single 55.0
  .single 56.0
  .single 57.0
  .single 58.0
  .single 59.0
  .single 60.0
  .single 61.0
  .single 62.0
  .single 63.0
  .single 64.0
srcC:
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
dest:
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
  .single 0.0
result:
  .single 1380.0
  .single 1416.0
  .single 1452.0
  .single 1488.0
  .single 1524.0
  .single 1560.0
  .single 1596.0
  .single 1632.0

RVTEST_DATA_END
