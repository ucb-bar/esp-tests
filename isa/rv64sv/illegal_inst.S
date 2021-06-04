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

  .word 0xff00002b

  vsetcfg 32,1
  li a3,4
  vsetvl a3,a3

.align 3
vtcode1:
  vlxw vv2, vs0, vv1
  vstop

vtcode2:
  vld vv2,va2
  vld vv3,va3
  vadd.vv vv2,vv2,vv3
  vsd vv2, va1
  vstop

stvec_handler:
  vxcptkill

  li TESTNUM,2

  # check cause
  csrr a3, scause
  li a4,HWACHA_CAUSE_ILLEGAL_INSTRUCTION
  bne a3,a4,fail

  # check vec irq aux
  csrr a3, sbadaddr
  li a4, 0xff00002b
  bne a3,a4,fail

  # make sure vector unit has cleared out
  vsetcfg 32,1
  li a3,4
  vsetvl a3,a3

  la a3,src1
  vmca va2,a3
  la a4,src2
  vmca va3,a4
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode2)
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
