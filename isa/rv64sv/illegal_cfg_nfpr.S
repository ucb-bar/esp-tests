# See LICENSE for license details.

#*****************************************************************************
# illegal_tvec_cmd.S
#-----------------------------------------------------------------------------
#
# Test illegal tvec command trap.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64SV
RVTEST_CODE_BEGIN

  la a3,handler
  csrw stvec,a3 # set exception handler

  li a0,33
  slli a0,a0,6
  vsetcfg a0

vtcode2:
  vld vx2,va2
  vld vx3,va3
  vadd 1,1,1, vx2,vx2,vx3
  vsd vx2, va1
  vstop

handler:
  vxcptkill

  li TESTNUM,2

  # check cause
  csrr a3, scause
  li a4,HWACHA_CAUSE_ILLEGAL_CFG
  bne a3,a4,fail

  # check vec irq aux
  csrr a3, sbadaddr
  li a4, 1
  bne a3,a4,fail

  # make sure vector unit has cleared out
  vsetcfg 32,0
  li a3,4
  vsetvl a3,a3

  la a3,src1
  vmsa va2,a3
  la a4,src2
  vmsa va3,a4
  la a5,dest
  vmsa va1,a5
  lui a0,%hi(vtcode2)
  vf %lo(vtcode2)(a0)
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
