# See LICENSE for license details.

#*****************************************************************************
# cmp.S
#-----------------------------------------------------------------------------
#
# Test integer vcmp* instructions in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  vsetcfg 2,3
  li a2,33
  vsetvl a2,a2

  la a4,dest
  vmca va1, a4
1:auipc a0,%pcrel_hi(vtcode)
  vf %pcrel_lo(1b)(a0)
  fence

  li a1,1
loop:
  ld a0,0(a4)
  addi TESTNUM,a1,1
  bne a0,a1,fail
  addi a4,a4,8
  addi a1,a1,1
  bne a1,a2,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vpclear vp1
  vpclear vp2
  veidx vv1
  vaddi vs1,vs0,-1
  vcmpeq vp1,vv1,vv1            # Equivalent to vpset vp1
  vcmplt vp2,vs1,vv1            # Equivalent to vpset vp2
  vxor vv1,vv1,vs0              # Force io.resp.cmp pipeline register to zero in ALUs
@!vp1 vcmpltu vp2,vs1,vv1       # Reproduce predication bug (vp2 should not be cleared)

  vaddi vs1,vs0,1
  vaddi vs2,vs0,-0x10000
@vp1  vadd vv1,vv1,vs1
@!vp2 vor vv1,vv1,vs2           # Poison result if vp2 was incorrectly overwritten
  vsd vv1,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

dest:
  .skip 1024

RVTEST_DATA_END
