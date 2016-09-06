# See LICENSE for license details.

#*****************************************************************************
# wakeup.S
#-----------------------------------------------------------------------------
#
# Test wakeup.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  # make sure these don't choke at the beginning
  fence
  fence rw,io
  fence io,rw

  # this shouldn't go through since app vl is zero
  la a3,src1
  la a4,src2
  vmca va2, a3
  vmca va3, a4
  la a5,dest
  vmca va1, a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,0xdeadbeefcafebabe
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

  # check default hw vector length, which is 32
  li a3, 8
  vsetvl a3, a3
  li a0, 8
  li TESTNUM, 6
  bne a3, a0, fail

  # this is check is dependent on HW size
  #li a3, 9
  #vsetvl a3, a3
  #li a0, 8
  #li TESTNUM, 7
  #bne a3, a0, fail

  li a3, 7
  vsetvl a3, a3
  li a0, 7
  li TESTNUM, 8
  bne a3, a0, fail

  # now do some vector stuff without vsetcfg
  vsetvl x0, x0

  li a3, 4
  la a4,src1
  la a5,src2
  vsetvl a3, a3
  vmca va2,a4
  vmca va3,a5
  la a5,dest
  vmca va1, a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,5
  li TESTNUM,9
  bne a1,a2,fail
  ld a1,8(a5)
  li TESTNUM,10
  bne a1,a2,fail
  ld a1,16(a5)
  li TESTNUM,11
  bne a1,a2,fail
  ld a1,24(a5)
  li TESTNUM,12
  bne a1,a2,fail

  # initialize dest memory
  li a3, 0xdeadbeefcafebabe
  sd a3, 0(a5)
  sd a3, 8(a5)
  sd a3, 16(a5)
  sd a3, 24(a5)

  # test app vl zero again
  li a3, 0
  vsetvl a3, a3

  la a3,src1
  la a4,src2
  vmca va2,a3
  vmca va3,a4
  la a5,dest
  vmca va1, a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,0xdeadbeefcafebabe
  li TESTNUM,13
  bne a1,a2,fail
  ld a1,8(a5)
  li TESTNUM,14
  bne a1,a2,fail
  ld a1,16(a5)
  li TESTNUM,15
  bne a1,a2,fail
  ld a1,24(a5)
  li TESTNUM,16
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
