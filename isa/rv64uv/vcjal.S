# See LICENSE for license details.

#*****************************************************************************
# vcjal.S
#-----------------------------------------------------------------------------
#
# Test vcjal & vcjalr.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,4
  li a3,33
  vsetvl a3,a3

  la a3, vcjump
  vmcs vs1, a3
  la a3, dest
  vmcs vs2, a3
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a3)
  li a2,1
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a3)
  la a2,vcjalr_ret
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a3)
  li a2,3
  li TESTNUM,4
  bne a1,a2,fail

  j pass

.align 3
vtcode1:
      vpset vp0
      vaddi vs3,vs0,1
@vp0  vcjalr 0, vs4, vs1, 0
vcjalr_ret:
      vaddi vs4,vs0,10
vcjump:
      vssd vs2, vs3
      vaddi vs2,vs2,8
      vssd vs2, vs4

      vpclear vp1
      vaddi vs4,vs0,1
@vp1  vcjal 0, vs4, 2
      vaddi vs5,vs4,1
      vadd vs5,vs5,vs4
      vaddi vs2,vs2,8
      vssd vs2, vs5
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
