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
  ld a3, 0(a3)
  vmcs vs2,a3
  la a4,src2
  ld a4, 0(a4)
  vmcs vs3,a4
  la a5,dest1
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)

  la a5,dest1
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode1_save)
  vf %pcrel_lo(1b)(a0)
  fence

  la a5,dest1
  ld a1,0(a5)
  li a2,5
  li TESTNUM,2
  bne a1,a2,fail

  vmcs vs2,a3
  vmcs vs3,a4
  la a5,dest2
  vmca va1,a5
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)

  li a6,1337
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
  vmcs vs6,a6
1:auipc a0,%pcrel_hi(vtcode1_save)
  vf %pcrel_lo(1b)(a0)
  fence

  la a5,dest2
  ld a1,0(a5)
  li a2,5
  li TESTNUM,3
  bne a1,a2,fail

  la a5,dest3
  vmca va1,a5
  vmcs vs3,a4
1:auipc a0,%pcrel_hi(vtcode3)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a5)
  li a2,4
  li TESTNUM,4
  bne a1,a2,fail

  j pass

.align 3
vtcode1:
  vpset vp0
  vadd vs4,vs2,vs3
  vadd vs5,vs2,vs3
  vadd vs6,vs2,vs3
  vadd vs7,vs2,vs3
  vadd vs8,vs2,vs3
  vadd vs9,vs2,vs3
  vadd vs2,vs2,vs3
  vstop
vtcode1_save:
  vpset vp0
  vsad va1,vs2
  vstop

.align 3
vtcode3:
  vpset vp0
  vadd vs1,vs3,vs0
  vsad va1,vs1
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
dest1:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
dest2:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
dest3:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe

RVTEST_DATA_END
