# See LICENSE for license details.

#*****************************************************************************
# vlab.S
#-----------------------------------------------------------------------------
#
# Test vlab instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  TEST_VLD_OP( 2, vlab, vsad, va2, va1, 0x00000000000000aa, 0xffffffffffffffaa );
  TEST_VLD_OP( 3, vlab, vsad, va2, va1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VLD_OP( 4, vlab, vsad, va2, va1, 0x000000000000000a, 0x000000000000000a );
  TEST_VLD_OP( 5, vlab, vsad, va2, va1, 0x00000000000000a0, 0xffffffffffffffa0 );

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
