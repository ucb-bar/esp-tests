# See LICENSE for license details.

#*****************************************************************************
# vlsd.S
#-----------------------------------------------------------------------------
#
# Test vlsd instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLDU_OP( 2, vlsd, vssd, vs2, vs1, 0x00aa00aa00aa00aa );
  TEST_VLDU_OP( 3, vlsd, vssd, vs2, vs1, 0xaa00aa00aa00aa00 );
  TEST_VLDU_OP( 4, vlsd, vssd, vs2, vs1, 0x0aa00aa00aa00aa0 );
  TEST_VLDU_OP( 5, vlsd, vssd, vs2, vs1, 0xa00aa00aa00aa00a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
src1:
  .dword 1

.align 3
dst:
  .skip 32

RVTEST_DATA_END
