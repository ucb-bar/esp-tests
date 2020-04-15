# See LICENSE for license details.

#*****************************************************************************
# vvmadd_fd.S
#-----------------------------------------------------------------------------
#
# Test vvmadd fd.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 8,1
  li a3,64
  vsetvl a3,a3

  la a3,srcC
  vmca va0,a3
  la a4,srcA0
  vmca va1,a4
  la a4,srcA1
  vmca va11,a4
  la a5,srcB
  vmca va3,a5
  addi a5, a5, 128
  vmca va4,a5
  addi a5, a5, 128
  vmca va5,a5
  addi a5, a5, 128
  vmca va6,a5
  addi a5, a5, 128
  vmca va7,a5
  addi a5, a5, 128
  vmca va8,a5
  addi a5, a5, 128
  vmca va9,a5
  addi a5, a5, 128
  vmca va10,a5
  la a6,dest0
  vmca va2,a6
  la a6,dest1
  vmca va12,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  la a5,dest0
  la a6,result0
  ld a1,0(a5)
  ld a2,0(a6)
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a5)
  ld a2,8(a6)
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a5)
  ld a2,16(a6)
  li TESTNUM,4
  bne a1,a2,fail
  ld a1,24(a5)
  ld a2,24(a6)
  li TESTNUM,5
  bne a1,a2,fail
  ld a1,32(a5)
  ld a2,32(a6)
  li TESTNUM,6
  bne a1,a2,fail
  ld a1,40(a5)
  ld a2,40(a6)
  li TESTNUM,7
  bne a1,a2,fail
  ld a1,48(a5)
  ld a2,48(a6)
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,56(a5)
  ld a2,56(a6)
  li TESTNUM,9
  bne a1,a2,fail
  ld a1,64(a5)
  ld a2,64(a6)
  li TESTNUM,10
  bne a1,a2,fail
  ld a1,72(a5)
  ld a2,72(a6)
  li TESTNUM,11
  bne a1,a2,fail
  ld a1,80(a5)
  ld a2,80(a6)
  li TESTNUM,12
  bne a1,a2,fail
  ld a1,88(a5)
  ld a2,88(a6)
  li TESTNUM,13
  bne a1,a2,fail
  ld a1,96(a5)
  ld a2,96(a6)
  li TESTNUM,14
  bne a1,a2,fail
  ld a1,104(a5)
  ld a2,104(a6)
  li TESTNUM,15
  bne a1,a2,fail
  ld a1,112(a5)
  ld a2,112(a6)
  li TESTNUM,16
  bne a1,a2,fail
  ld a1,120(a5)
  ld a2,120(a6)
  li TESTNUM,17
  bne a1,a2,fail
  la a5,dest1
  la a6,result1
  ld a1,0(a5)
  ld a2,0(a6)
  li TESTNUM,22
  bne a1,a2,fail
  ld a1,8(a5)
  ld a2,8(a6)
  li TESTNUM,23
  bne a1,a2,fail
  ld a1,16(a5)
  ld a2,16(a6)
  li TESTNUM,24
  bne a1,a2,fail
  ld a1,24(a5)
  ld a2,24(a6)
  li TESTNUM,25
  bne a1,a2,fail
  ld a1,32(a5)
  ld a2,32(a6)
  li TESTNUM,26
  bne a1,a2,fail
  ld a1,40(a5)
  ld a2,40(a6)
  li TESTNUM,27
  bne a1,a2,fail
  ld a1,48(a5)
  ld a2,48(a6)
  li TESTNUM,28
  bne a1,a2,fail
  ld a1,56(a5)
  ld a2,56(a6)
  li TESTNUM,29
  bne a1,a2,fail
  ld a1,64(a5)
  ld a2,64(a6)
  li TESTNUM,30
  bne a1,a2,fail
  ld a1,72(a5)
  ld a2,72(a6)
  li TESTNUM,31
  bne a1,a2,fail
  ld a1,80(a5)
  ld a2,80(a6)
  li TESTNUM,32
  bne a1,a2,fail
  ld a1,88(a5)
  ld a2,88(a6)
  li TESTNUM,33
  bne a1,a2,fail
  ld a1,96(a5)
  ld a2,96(a6)
  li TESTNUM,34
  bne a1,a2,fail
  ld a1,104(a5)
  ld a2,104(a6)
  li TESTNUM,35
  bne a1,a2,fail
  ld a1,112(a5)
  ld a2,112(a6)
  li TESTNUM,36
  bne a1,a2,fail
  ld a1,120(a5)
  ld a2,120(a6)
  li TESTNUM,37
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vld vv0,va0 #c0
  vld vv6,va0 #c1
  vld vv1,va1  #a0
  vld vv2,va3 #b0
  vld vv3,va4 #b1
  vld vv4,va5 #b2
  vld vv5,va6 #b3
  vfvmmadd.d.vvv vv0, vv1, vv2, vv0, 4  #c0 =+ a0*b
  vld vv7,va11 #a1
  vfvmmadd.d.vvv vv6, vv7, vv2, vv6, 4  #c1 =+ a1*b
  vsd vv0,va2
  vsd vv6,va12
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

srcA0:
  .double 1.0
  .double 2.0
  .double 3.0
  .double 4.0
  .double 5.0
  .double 6.0
  .double 7.0
  .double 8.0
srcA1:
  .double 5.0
  .double 6.0
  .double 7.0
  .double 8.0
  .double 9.0
  .double 10.0
  .double 11.0
  .double 12.0
srcB:
  .double 1.0
  .double 2.0
  .double 3.0
  .double 4.0
  .double 5.0
  .double 6.0
  .double 7.0
  .double 8.0
  .double 9.0
  .double 10.0
  .double 11.0
  .double 12.0
  .double 13.0
  .double 14.0
  .double 15.0
  .double 16.0
  .double 17.0
  .double 18.0
  .double 19.0
  .double 20.0
  .double 21.0
  .double 22.0
  .double 23.0
  .double 24.0
  .double 25.0
  .double 26.0
  .double 27.0
  .double 28.0
  .double 29.0
  .double 30.0
  .double 31.0
  .double 32.0
  .double 33.0
  .double 34.0
  .double 35.0
  .double 36.0
  .double 37.0
  .double 38.0
  .double 39.0
  .double 40.0
  .double 41.0
  .double 42.0
  .double 43.0
  .double 44.0
  .double 45.0
  .double 46.0
  .double 47.0
  .double 48.0
  .double 49.0
  .double 50.0
  .double 51.0
  .double 52.0
  .double 53.0
  .double 54.0
  .double 55.0
  .double 56.0
  .double 57.0
  .double 58.0
  .double 59.0
  .double 60.0
  .double 61.0
  .double 62.0
  .double 63.0
  .double 64.0
srcC:
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
dest0:
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
dest1:
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
  .double 0.0
result0:
  .double 330.0
  .double 340.0
  .double 350.0
  .double 360.0
  .double 370.0
  .double 380.0
  .double 390.0
  .double 400.0
  .double 410.0
  .double 420.0
  .double 430.0
  .double 440.0
  .double 450.0
  .double 460.0
  .double 470.0
  .double 480.0
result1:
  .double 730.0
  .double 756.0
  .double 782.0
  .double 808.0
  .double 834.0
  .double 860.0
  .double 886.0
  .double 912.0
  .double 938.0
  .double 964.0
  .double 990.0
  .double 1016.0
  .double 1042.0
  .double 1068.0
  .double 1094.0
  .double 1120.0

RVTEST_DATA_END
