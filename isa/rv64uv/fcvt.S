# See LICENSE for license details.

#*****************************************************************************
# fcvt.S
#-----------------------------------------------------------------------------
#
# Test fcvt instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 32,1
  li a3,4
  vsetvl a3,a3

  la a3,src
  vmca va2,a3
  la a4,dest
  vmca va1,a4
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  la a5,result
  ld a1,0(a4)
  ld a2,0(a5)
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a4)
  ld a2,8(a5)
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a4)
  ld a2,16(a5)
  li TESTNUM,4
  bne a1,a2,fail
  ld a1,24(a4)
  ld a2,24(a5)
  li TESTNUM,5
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vld vv2,va2
  vfcvt.d.l.v vv1,vv2
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src:
  .dword 1
  .dword 2
  .dword 3
  .dword 4
dest:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
result:
  .double 1.0
  .double 2.0
  .double 3.0
  .double 4.0

RVTEST_DATA_END
