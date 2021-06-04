# See LICENSE for license details.

#*****************************************************************************
# vvadd_branch.S
#-----------------------------------------------------------------------------
#
# Test vvadd branch.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 32,0
  li a3,4
  vsetvl a3,a3

  la a3,src1
  la a4,src2
  vld vv2,a3
  vld vv3,a4
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  la a5,dest
  vsd vv2,a5
  fence

  ld a1,0(a5)
  li a2,8
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a5)
  li a2, 6        
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a5)
  li a2, 4        
  li TESTNUM,4
  bne a1,a2,fail
  li a2, 2
  ld a1,24(a5)
  li TESTNUM,5
  bne a1,a2,fail

  la a3,src1
  vld vv4,a3
  li a4, 3
  vmsv vv5,a4
1:auipc a0,%pcrel_hi(vtcode2)
  vf %pcrel_lo(1b)(a0)
  la a5,dest
  vsd vv4,a5
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
  li a2,0
  li TESTNUM,8
  bne a1,a2,fail
  ld a1,24(a5)
  li a2,0
  li TESTNUM,9
  bne a1,a2,fail

  la a3,src2
  vld vv5,a3
1:auipc a0,%pcrel_hi(vtcode3)
  vf %pcrel_lo(1b)(a0)
  la a5,dest
  vsd vv5,a5
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
  beq x2, x2, end
  add x2,x2,x3
end:    add x2, x3, x3
  stop

.align 3
vtcode2:
  blt x4, x5, end2
  add x4, x0, x0
end2:   add x4, x4, x0
  stop

.align 3
vtcode3:
  bge x5, x0, end3
  add x5, x0, x0
end3:   add x5, x5,x0
  stop

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
