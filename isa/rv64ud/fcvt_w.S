# See LICENSE for license details.

#*****************************************************************************
# fcvt_w.S
#-----------------------------------------------------------------------------
#
# Test fcvt{wu|w|lu|l}.d instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_INT_OP_D( 2,  fcvt.w.d, 0x01,         -1, -1.1, rtz);
  TEST_FP_INT_OP_D( 3,  fcvt.w.d, 0x00,         -1, -1.0, rtz);
  TEST_FP_INT_OP_D( 4,  fcvt.w.d, 0x01,          0, -0.9, rtz);
  TEST_FP_INT_OP_D( 5,  fcvt.w.d, 0x01,          0,  0.9, rtz);
  TEST_FP_INT_OP_D( 6,  fcvt.w.d, 0x00,          1,  1.0, rtz);
  TEST_FP_INT_OP_D( 7,  fcvt.w.d, 0x01,          1,  1.1, rtz);
  TEST_FP_INT_OP_D( 8,  fcvt.w.d, 0x10,     -1<<31, -3e9, rtz);
  TEST_FP_INT_OP_D( 9,  fcvt.w.d, 0x10,  (1<<31)-1,  3e9, rtz);

  TEST_FP_INT_OP_D(12, fcvt.wu.d, 0x10,          0, -3.0, rtz);
  TEST_FP_INT_OP_D(13, fcvt.wu.d, 0x10,          0, -1.0, rtz);
  TEST_FP_INT_OP_D(14, fcvt.wu.d, 0x01,          0, -0.9, rtz);
  TEST_FP_INT_OP_D(15, fcvt.wu.d, 0x01,          0,  0.9, rtz);
  TEST_FP_INT_OP_D(16, fcvt.wu.d, 0x00,          1,  1.0, rtz);
  TEST_FP_INT_OP_D(17, fcvt.wu.d, 0x01,          1,  1.1, rtz);
  TEST_FP_INT_OP_D(18, fcvt.wu.d, 0x10,          0, -3e9, rtz);
  TEST_FP_INT_OP_D(19, fcvt.wu.d, 0x00, 0xffffffffb2d05e00, 3e9, rtz);

#if __riscv_xlen >= 64
  TEST_FP_INT_OP_D(22,  fcvt.l.d, 0x01,         -1, -1.1, rtz);
  TEST_FP_INT_OP_D(23,  fcvt.l.d, 0x00,         -1, -1.0, rtz);
  TEST_FP_INT_OP_D(24,  fcvt.l.d, 0x01,          0, -0.9, rtz);
  TEST_FP_INT_OP_D(25,  fcvt.l.d, 0x01,          0,  0.9, rtz);
  TEST_FP_INT_OP_D(26,  fcvt.l.d, 0x00,          1,  1.0, rtz);
  TEST_FP_INT_OP_D(27,  fcvt.l.d, 0x01,          1,  1.1, rtz);
  TEST_FP_INT_OP_D(28,  fcvt.l.d, 0x00,-3000000000, -3e9, rtz);
  TEST_FP_INT_OP_D(29,  fcvt.l.d, 0x00, 3000000000,  3e9, rtz);
  TEST_FP_INT_OP_D(20,  fcvt.l.d, 0x10,     -1<<63,-3e19, rtz);
  TEST_FP_INT_OP_D(21,  fcvt.l.d, 0x10,  (1<<63)-1, 3e19, rtz);

  TEST_FP_INT_OP_D(32, fcvt.lu.d, 0x10,          0, -3.0, rtz);
  TEST_FP_INT_OP_D(33, fcvt.lu.d, 0x10,          0, -1.0, rtz);
  TEST_FP_INT_OP_D(34, fcvt.lu.d, 0x01,          0, -0.9, rtz);
  TEST_FP_INT_OP_D(35, fcvt.lu.d, 0x01,          0,  0.9, rtz);
  TEST_FP_INT_OP_D(36, fcvt.lu.d, 0x00,          1,  1.0, rtz);
  TEST_FP_INT_OP_D(37, fcvt.lu.d, 0x01,          1,  1.1, rtz);
  TEST_FP_INT_OP_D(38, fcvt.lu.d, 0x10,          0, -3e9, rtz);
  TEST_FP_INT_OP_D(39, fcvt.lu.d, 0x00, 3000000000,  3e9, rtz);
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

# -NaN, NaN, -inf, +inf
tdat:
.word 0xffffffff
.word 0x7fffffff
.word 0xff800000
.word 0x7f800000

tdat_d:
.dword 0xffffffffffffffff
.dword 0x7fffffffffffffff
.dword 0xfff0000000000000
.dword 0x7ff0000000000000

RVTEST_DATA_END
