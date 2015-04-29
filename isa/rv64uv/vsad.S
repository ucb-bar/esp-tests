# See LICENSE for license details.

#*****************************************************************************
# vsad.S
#-----------------------------------------------------------------------------
#
# Test vsad instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VST_OP( 2, vsad, va1, 0x00aa00aa00aa00aa );
  TEST_VST_OP( 3, vsad, va1, 0xaa00aa00aa00aa00 );
  TEST_VST_OP( 4, vsad, va1, 0x0aa00aa00aa00aa0 );
  TEST_VST_OP( 5, vsad, va1, 0xa00aa00aa00aa00a );

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
