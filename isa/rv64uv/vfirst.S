# See LICENSE for license details.

#*****************************************************************************
# vfirst.S
#-----------------------------------------------------------------------------
#
# Test vfirst.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 4,4
  li a3,33
  vsetvl a3,a3

  la a3, dest
  vmcs vs1, a3
1:auipc a0,%pcrel_hi(vtcode1)
  vf %pcrel_lo(1b)(a0)
  fence

  ld a1,0(a3)
  li a2,24
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a3)
  li a2,0
  li TESTNUM,3
  bne a1,a2,fail

  j pass

.align 3
vtcode1:
      vpset vp0
      veidx vv0
      vaddi vs2,vs0,23
      vcmplt vp1,vs2,vv0
@vp1  vfirst vs3,vv0
      vssd vs1,vs3

      vpclear vp1
      vaddi vs4,vs0,1024
      vadd vv0,vv0,vs4
@vp1  vfirst vs3,vv0
      vaddi vs1,vs1,8
      vssd vs1,vs3
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
