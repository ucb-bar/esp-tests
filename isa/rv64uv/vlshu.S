# See LICENSE for license details.

#*****************************************************************************
# vlshu.S
#-----------------------------------------------------------------------------
#
# Test vlshu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLDU_OP( 2, vlshu, vssd, vs2, vs1, 0x00000000000000aa );
  TEST_VLDU_OP( 3, vlshu, vssd, vs2, vs1, 0x000000000000aa00 );
  TEST_VLDU_OP( 4, vlshu, vssd, vs2, vs1, 0x0000000000000aa0 );
  TEST_VLDU_OP( 5, vlshu, vssd, vs2, vs1, 0x000000000000a00a );

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
