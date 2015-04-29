# See LICENSE for license details.

#*****************************************************************************
# vlswu.S
#-----------------------------------------------------------------------------
#
# Test vlswu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLDU_OP( 2, vlswu, vssd, vs2, vs1, 0x0000000000aa00aa );
  TEST_VLDU_OP( 3, vlswu, vssd, vs2, vs1, 0x00000000aa00aa00 );
  TEST_VLDU_OP( 4, vlswu, vssd, vs2, vs1, 0x000000000aa00aa0 );
  TEST_VLDU_OP( 5, vlswu, vssd, vs2, vs1, 0x00000000a00aa00a );

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
