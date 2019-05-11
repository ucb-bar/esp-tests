# See LICENSE for license details.

#*****************************************************************************
# vredsum.S
#-----------------------------------------------------------------------------
#
# Test vredsum
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a3, VCFG(0,32,0,2)
  vsetcfg a3
  li a3,9
  vsetvl a3,a3
  li a2, 2
  mul a2, a2, a3
  addi a2, a2, 1

  la a3,src1
  vmca va2,a3
  la a4,src2
  vmca va3,a4
  li a4, 1
  vmcs vs1, a4
  la a5,dest
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence
  lw a1,0(a5)
  li TESTNUM,2
  bne a1,a2,fail
  j pass

.align 3
vtcode:
  vpset vp0
  vlw vv1, va3
  vredsum vs2, vv1, vs1
  vsaw va1,vs2
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .word 1
  .word 1
  .word 1
  .word 1
  .word 1
  .word 1
  .word 1
  .word 1
  .word 1
src2:
  .word 2
  .word 2
  .word 2
  .word 2
  .word 2
  .word 2
  .word 2
  .word 2
  .word 2
dest:
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef
  .word 0xdeadbeef

RVTEST_DATA_END
