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

  vsetcfg 32,1
  li a3,16
  vsetvl a3,a3

  la a3,srcC
  vmca va0,a3
  la a4,srcA
  vmca va1,a4
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
  la a6,dest
  vmca va2,a6
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  la a5,dest
  la a6,result
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
  j pass

.align 3
vtcode:
  vpset vp0
  vld vv0,va0 #c0
  vld vv1,va1 #a
  vld vv2,va3 #b0
  vld vv3,va4 #b1
  vld vv4,va5 #b2
  vld vv5,va6 #b3
  vld vv6,va7 #b4
  vld vv7,va8 #b5
  vld vv8,va9 #b6
  vld vv9,va10 #b7
  vld vv10,va0 #c0
  vfvmmadd.d.vvv vv0, vv1, vv2, vv0, 8  #c0 =+ a*b
  vfvmmadd.d.vvv vv10, vv1, vv2, vv10, 8  #c0 =+ a*b
  vsd vv0,va2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

srcA:
  .double 1.0
  .double 2.0
  .double 3.0
  .double 4.0
  .double 5.0
  .double 6.0
  .double 7.0
  .double 8.0
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
  .double 65.0
  .double 66.0
  .double 67.0
  .double 68.0
  .double 69.0
  .double 70.0
  .double 71.0
  .double 72.0
  .double 73.0
  .double 74.0
  .double 75.0
  .double 76.0
  .double 77.0
  .double 78.0
  .double 79.0
  .double 80.0
  .double 81.0
  .double 82.0
  .double 83.0
  .double 84.0
  .double 85.0
  .double 86.0
  .double 87.0
  .double 88.0
  .double 89.0
  .double 90.0
  .double 91.0
  .double 92.0
  .double 93.0
  .double 94.0
  .double 95.0
  .double 96.0
  .double 97.0
  .double 98.0
  .double 99.0
  .double 100.0
  .double 101.0
  .double 102.0
  .double 103.0
  .double 104.0
  .double 105.0
  .double 106.0
  .double 107.0
  .double 108.0
  .double 109.0
  .double 110.0
  .double 111.0
  .double 112.0
  .double 113.0
  .double 114.0
  .double 115.0
  .double 116.0
  .double 117.0
  .double 118.0
  .double 119.0
  .double 120.0
  .double 121.0
  .double 122.0
  .double 123.0
  .double 124.0
  .double 125.0
  .double 126.0
  .double 127.0
  .double 128.0
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
dest:
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
result:
  .double 2724.0
  .double 2760.0
  .double 2796.0
  .double 2832.0
  .double 2868.0
  .double 2904.0
  .double 2940.0
  .double 2976.0
  .double 3012.0
  .double 3048.0
  .double 3084.0
  .double 3120.0
  .double 3156.0
  .double 3192.0
  .double 3228.0
  .double 3264.0

RVTEST_DATA_END
