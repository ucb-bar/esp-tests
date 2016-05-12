# See LICENSE for license details.

#*****************************************************************************
# vvadd_d.S
#-----------------------------------------------------------------------------
#
# Test vvadd d.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 32,1
  li a3,4
  vsetvl a3,a3

  la a3,src1
  vmca va2,a3
  la a4,src2
  vmca va3,a4
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,5
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a5)
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a5)
  li TESTNUM,4
  bne a1,a2,fail
  ld a1,24(a5)
  li TESTNUM,5
  bne a1,a2,fail

  la a3,src1
  vmca va2,a3
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode2)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,1
  li TESTNUM,6
  bne a1,a2,fail
  ld a1,8(a5)
  li a2,2
  li TESTNUM,7
  bne a1,a2,fail
  ld a1,16(a5)
  li a2,3
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,24(a5)
  li a2,4
  li TESTNUM,9
  bne a1,a2,fail

  la a3,src2
  vmca va2,a3
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode3)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,4
  li TESTNUM,6
  bne a1,a2,fail
  ld a1,8(a5)
  li a2,3
  li TESTNUM,7
  bne a1,a2,fail
  ld a1,16(a5)
  li a2,2
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,24(a5)
  li a2,1
  li TESTNUM,9
  bne a1,a2,fail

  j pass

.align 3
vtcode1:
  vpset vp0
  vld vv2,va2
  vld vv3,va3
  vadd.vv vv2,vv2,vv3
  vsd vv2,va1
  vstop

.align 3
vtcode2:
  vpset vp0
  vld vv2,va2
  vadd.sv vv1,vs0,vv2
  vsd vv1,va1
  vstop

.align 3
vtcode3:
  vpset vp0
  vld vv2,va2
  vadd.vs vv1,vv2,vs0
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .dword 1
  .dword 2
  .dword 3
  .dword 4
src2:
  .dword 4
  .dword 3
  .dword 2
  .dword 1
dest:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe

RVTEST_DATA_END
