# See LICENSE for license details.

#*****************************************************************************
# fcvt_hs.S
#-----------------------------------------------------------------------------
#
# Test fcvt instruction in a vf block.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  li a3, VCFG(0, 2, 1, 1)
  vsetcfg a3
  li a3,16
  vsetvl a3,a3

  la a4,src
  vmsa va2,a4
  la a4,dest
  vmsa va1,a4
  lui a0,%hi(vtcode)
  vf %lo(vtcode)(a0)
  fence

  li a6,0
  la a5,result
loop:
  lh a1,0(a4)
  lh a2,0(a5)
  addi TESTNUM,a6,2
  bne a1,a2,fail
  addi a4,a4,2
  addi a5,a5,2
  addi a6,a6,1
  bne a6,a3,loop
  j pass

.align 3
vtcode:
  vpset vp0
  vlw vv1,va2
  vfcvt.h.s.v vv2,vv1
  vsh vv2,va1
  vstop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src:
  .single 1.0
  .single 2.0
  .single 3.0
  .single 4.0
  .single 5.0
  .single 6.0
  .single 7.0
  .single 8.0
  .single 9.0
  .single 10.0
  .single 11.0
  .single 12.0
  .single 13.0
  .single 14.0
  .single 15.0
  .single 16.0
dest:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
result:
  .hword 0x3c00
  .hword 0x4000
  .hword 0x4200
  .hword 0x4400
  .hword 0x4500
  .hword 0x4600
  .hword 0x4700
  .hword 0x4800
  .hword 0x4880
  .hword 0x4900
  .hword 0x4980
  .hword 0x4a00
  .hword 0x4a80
  .hword 0x4b00
  .hword 0x4b80
  .hword 0x4c00

RVTEST_DATA_END
