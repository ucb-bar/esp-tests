# See LICENSE for license details.

#*****************************************************************************
# vsaw.S
#-----------------------------------------------------------------------------
#
# Test vsaw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VST_OP( 2, vsaw, va1, 0x0000000000aa00aa );
  TEST_VST_OP( 3, vsaw, va1, 0x00000000aa00aa00 );
  TEST_VST_OP( 4, vsaw, va1, 0x000000000aa00aa0 );
  TEST_VST_OP( 5, vsaw, va1, 0x00000000a00aa00a );

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
