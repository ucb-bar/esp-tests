# See LICENSE for license details.

#*****************************************************************************
# vlaw.S
#-----------------------------------------------------------------------------
#
# Test vlaw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLD_OP( 2, vlaw, vsad, va2, va1, 0x0000000000aa00aa, 0x0000000000aa00aa );
  TEST_VLD_OP( 3, vlaw, vsad, va2, va1, 0x00000000aa00aa00, 0xffffffffaa00aa00 );
  TEST_VLD_OP( 4, vlaw, vsad, va2, va1, 0x000000000aa00aa0, 0x000000000aa00aa0 );
  TEST_VLD_OP( 5, vlaw, vsad, va2, va1, 0x00000000a00aa00a, 0xffffffffa00aa00a );

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
