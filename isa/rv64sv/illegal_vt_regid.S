# See LICENSE for license details.

#*****************************************************************************
# xcpt_illegal_vt_regid.S
#-----------------------------------------------------------------------------
#
# Test illegal vt regid trap.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64SV
RVTEST_CODE_BEGIN

  TEST_ILLEGAL_VT_REGID(2, 5, 5, add, v7, v1, v2)
  TEST_ILLEGAL_VT_REGID(3, 5, 5, add, v1, v7, v2)
  TEST_ILLEGAL_VT_REGID(4, 5, 5, add, v1, v2, v7)

  TEST_ILLEGAL_VT_REGID(5, 5, 5, fadd.d, v7, v1, v2)
  TEST_ILLEGAL_VT_REGID(6, 5, 5, fadd.d, v1, v7, v2)
  TEST_ILLEGAL_VT_REGID(7, 5, 5, fadd.d, v1, v2, v7)

  TEST_PASSFAIL

# the handler gets rewritten for every test, but need this for the framework
stvec_handler:
  j fail

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
