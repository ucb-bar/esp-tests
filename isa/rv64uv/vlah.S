# See LICENSE for license details.

#*****************************************************************************
# vlah.S
#-----------------------------------------------------------------------------
#
# Test vlah instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLD_OP( 2, vlah, vsad, va2, va1, 0x00000000000000aa, 0x00000000000000aa );
  TEST_VLD_OP( 3, vlah, vsad, va2, va1, 0x000000000000aa00, 0xffffffffffffaa00 );
  TEST_VLD_OP( 4, vlah, vsad, va2, va1, 0x0000000000000aa0, 0x0000000000000aa0 );
  TEST_VLD_OP( 5, vlah, vsad, va2, va1, 0x000000000000a00a, 0xffffffffffffa00a );

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
