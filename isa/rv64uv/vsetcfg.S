# See LICENSE for license details.

#*****************************************************************************
# vsetcfg.S
#-----------------------------------------------------------------------------
#
# Test vsetcfg instruction without immediates.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_VVCFG( 5, 1, 1, 2048, 2048 );
  TEST_VVCFG( 6, 1, 1, 2049, 2048 );
  TEST_VVCFG( 7, 1, 1, 2047, 2047 );

  TEST_VVCFG( 11, 1, 1, 2048, 2048 );
  TEST_VVCFG( 12, 1, 1, 2049, 2048 );
  TEST_VVCFG( 13, 1, 1, 2047, 2047 );

  TEST_VVCFG( 17, 2, 1, 1024, 1024 );
  TEST_VVCFG( 18, 2, 1, 1025, 1024 );
  TEST_VVCFG( 19, 2, 1, 1023, 1023 );

  TEST_VVCFG( 23, 3, 1, 680, 680 );
  TEST_VVCFG( 24, 3, 1, 681, 680 );
  TEST_VVCFG( 25, 3, 1, 679, 679 );

  TEST_VVCFG( 29, 4, 1, 512, 512 );
  TEST_VVCFG( 30, 4, 1, 513, 512 );
  TEST_VVCFG( 31, 4, 1, 511, 511 );

  TEST_VVCFG( 35, 5, 1, 408, 408 );
  TEST_VVCFG( 36, 5, 1, 409, 408 );
  TEST_VVCFG( 37, 5, 1, 407, 407 );

  TEST_VVCFG( 41, 6, 1, 336, 336 );
  TEST_VVCFG( 42, 6, 1, 337, 336 );
  TEST_VVCFG( 43, 6, 1, 335, 335 );

  TEST_VVCFG( 47, 7, 1, 288, 288 );
  TEST_VVCFG( 48, 7, 1, 289, 288 );
  TEST_VVCFG( 49, 7, 1, 287, 287 );

  TEST_VVCFG( 53, 8, 1, 256, 256 );
  TEST_VVCFG( 54, 8, 1, 257, 256 );
  TEST_VVCFG( 55, 8, 1, 255, 255 );

  TEST_VVCFG( 59, 9, 1, 224, 224 );
  TEST_VVCFG( 60, 9, 1, 225, 224 );
  TEST_VVCFG( 61, 9, 1, 223, 223 );

  TEST_VVCFG( 65, 10, 1, 200, 200 );
  TEST_VVCFG( 66, 10, 1, 201, 200 );
  TEST_VVCFG( 67, 10, 1, 199, 199 );

  TEST_VVCFG( 71, 11, 1, 184, 184 );
  TEST_VVCFG( 72, 11, 1, 185, 184 );
  TEST_VVCFG( 73, 11, 1, 183, 183 );

  TEST_VVCFG( 77, 12, 1, 168, 168 );
  TEST_VVCFG( 78, 12, 1, 169, 168 );
  TEST_VVCFG( 79, 12, 1, 167, 167 );

  TEST_VVCFG( 83, 13, 1, 152, 152 );
  TEST_VVCFG( 84, 13, 1, 153, 152 );
  TEST_VVCFG( 85, 13, 1, 151, 151 );

  TEST_VVCFG( 89, 14, 1,  144, 144 );
  TEST_VVCFG( 90, 14, 1,  145, 144 );
  TEST_VVCFG( 91, 14, 1,  143, 143 );

  TEST_VVCFG( 95, 15, 1,  136, 136 );
  TEST_VVCFG( 96, 15, 1,  137, 136 );
  TEST_VVCFG( 97, 15, 1,  135, 135 );

  TEST_VVCFG( 101, 16, 1, 128, 128 );
  TEST_VVCFG( 102, 16, 1, 129, 128 );
  TEST_VVCFG( 103, 16, 1, 127, 127 );

  TEST_VVCFG( 107, 17, 1, 120, 120 );
  TEST_VVCFG( 108, 17, 1, 121, 120 );
  TEST_VVCFG( 109, 17, 1, 119, 119 );

  TEST_VVCFG( 113, 18, 1, 112, 112 );
  TEST_VVCFG( 114, 18, 1, 113, 112 );
  TEST_VVCFG( 115, 18, 1, 111, 111 );

  TEST_VVCFG( 119, 19, 1, 104, 104 );
  TEST_VVCFG( 120, 19, 1, 105, 104 );
  TEST_VVCFG( 121, 19, 1, 103, 103 );

  TEST_VVCFG( 125, 20, 1, 96, 96  );
  TEST_VVCFG( 126, 20, 1, 97, 96  );
  TEST_VVCFG( 127, 20, 1, 95, 95  );

  TEST_VVCFG( 131, 21, 1, 96, 96 );
  TEST_VVCFG( 132, 21, 1, 97, 96 );
  TEST_VVCFG( 133, 21, 1, 95, 95 );

  TEST_VVCFG( 137, 22, 1, 88, 88 );
  TEST_VVCFG( 138, 22, 1, 89, 88 );
  TEST_VVCFG( 139, 22, 1, 87, 87 );

  TEST_VVCFG( 143, 23, 1, 88, 88 );
  TEST_VVCFG( 144, 23, 1, 89, 88 );
  TEST_VVCFG( 145, 23, 1, 87, 87 );

  TEST_VVCFG( 149, 24, 1, 80, 80 );
  TEST_VVCFG( 150, 24, 1, 81, 80 );
  TEST_VVCFG( 151, 24, 1, 79, 79 );

  TEST_VVCFG( 155, 25, 1, 80, 80 );
  TEST_VVCFG( 156, 25, 1, 81, 80 );
  TEST_VVCFG( 157, 25, 1, 79, 79 );

  TEST_VVCFG( 161, 26, 1, 72, 72 );
  TEST_VVCFG( 162, 26, 1, 73, 72 );
  TEST_VVCFG( 163, 26, 1, 71, 71 );

  TEST_VVCFG( 167, 27, 1, 72, 72 );
  TEST_VVCFG( 168, 27, 1, 73, 72 );
  TEST_VVCFG( 169, 27, 1, 71, 71 );

  TEST_VVCFG( 173, 28, 1, 72, 72 );
  TEST_VVCFG( 174, 28, 1, 73, 72 );
  TEST_VVCFG( 175, 28, 1, 71, 71 );

  TEST_VVCFG( 179, 29, 1, 64, 64 );
  TEST_VVCFG( 180, 29, 1, 65, 64 );
  TEST_VVCFG( 181, 29, 1, 63, 63 );

  TEST_VVCFG( 185, 30, 1, 64, 64 );
  TEST_VVCFG( 186, 30, 1, 65, 64 );
  TEST_VVCFG( 187, 30, 1, 63, 63 );

  TEST_VVCFG( 191, 31, 1, 64, 64 );
  TEST_VVCFG( 192, 31, 1, 65, 64 );
  TEST_VVCFG( 193, 31, 1, 63, 63 );

  TEST_VVCFG( 197, 32, 1, 64, 64 );
  TEST_VVCFG( 198, 32, 1, 65, 64 );
  TEST_VVCFG( 199, 32, 1, 63, 63 );

  TEST_VVCFG( 209, 32, 1, 64, 64 );
  TEST_VVCFG( 210, 32, 1, 65, 64 );
  TEST_VVCFG( 211, 32, 1, 63, 63 );

  TEST_VVCFG( 215, 32, 2, 64, 64 );
  TEST_VVCFG( 216, 32, 2, 65, 64 );
  TEST_VVCFG( 217, 32, 2, 63, 63 );

  TEST_VVCFG( 221, 32, 3, 64, 64 );
  TEST_VVCFG( 222, 32, 3, 65, 64 );
  TEST_VVCFG( 223, 32, 3, 63, 63 );

  TEST_VVCFG( 227, 32, 4, 64, 64 );
  TEST_VVCFG( 228, 32, 4, 65, 64 );
  TEST_VVCFG( 229, 32, 4, 63, 63 );

  TEST_VVCFG( 233, 32, 5, 64, 64 );
  TEST_VVCFG( 234, 32, 5, 65, 64 );
  TEST_VVCFG( 235, 32, 5, 63, 63 );

  TEST_VVCFG( 239, 32, 6, 64, 64 );
  TEST_VVCFG( 240, 32, 6, 65, 64 );
  TEST_VVCFG( 241, 32, 6, 63, 63 );

  TEST_VVCFG( 245, 32, 7, 64, 64 );
  TEST_VVCFG( 246, 32, 7, 65, 64 );
  TEST_VVCFG( 247, 32, 7, 63, 63 );

  TEST_VVCFG( 251, 32, 8, 64, 64 );
  TEST_VVCFG( 252, 32, 8, 65, 64 );
  TEST_VVCFG( 253, 32, 8, 63, 63 );

  TEST_VVCFG( 257, 32, 9, 64, 64  );
  TEST_VVCFG( 258, 32, 9, 65, 64  );
  TEST_VVCFG( 259, 32, 9, 63, 63  );

  TEST_VVCFG( 263, 32, 10, 64, 64  );
  TEST_VVCFG( 264, 32, 10, 65, 64  );
  TEST_VVCFG( 265, 32, 10, 63, 63  );

  TEST_VVCFG( 269, 32, 11, 64, 64  );
  TEST_VVCFG( 270, 32, 11, 65, 64  );
  TEST_VVCFG( 271, 32, 11, 63, 63  );

  TEST_VVCFG( 275, 32, 12, 64, 64  );
  TEST_VVCFG( 276, 32, 12, 65, 64  );
  TEST_VVCFG( 277, 32, 12, 63, 63  );

  TEST_VVCFG( 281, 32, 13, 64, 64  );
  TEST_VVCFG( 282, 32, 13, 65, 64  );
  TEST_VVCFG( 283, 32, 13, 63, 63  );

  TEST_VVCFG( 287, 32, 14, 64, 64  );
  TEST_VVCFG( 288, 32, 14, 65, 64  );
  TEST_VVCFG( 289, 32, 14, 63, 63  );

  TEST_VVCFG( 293, 32, 15, 64, 64  );
  TEST_VVCFG( 294, 32, 15, 65, 64  );
  TEST_VVCFG( 295, 32, 15, 63, 63  );

  TEST_VVCFG( 299, 32, 16, 64, 64  );
  TEST_VVCFG( 300, 32, 16, 65, 64  );
  TEST_VVCFG( 301, 32, 16, 63, 63  );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
