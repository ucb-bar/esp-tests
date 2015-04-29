# See LICENSE for license details.

#*****************************************************************************
# vssb.S
#-----------------------------------------------------------------------------
#
# Test vssb instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VST_OP( 2, vssb, vs1, 0x00000000000000aa );
  TEST_VST_OP( 3, vssb, vs1, 0x0000000000000000 );
  TEST_VST_OP( 4, vssb, vs1, 0x000000000000000a );
  TEST_VST_OP( 5, vssb, vs1, 0x00000000000000a0 );

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
