# See LICENSE for license details.

#*****************************************************************************
# vsetcfgi.S
#-----------------------------------------------------------------------------
#
# Test vsetcfg instruction with immediates.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_VSETCFGIVL( 11, 1, 1, 2048, 2048 );
  TEST_VSETCFGIVL( 12, 1, 1, 2049, 2048 );
  TEST_VSETCFGIVL( 13, 1, 1, 2047, 2047 );

  TEST_VSETCFGIVL( 17, 2, 1, 1024, 1024 );
  TEST_VSETCFGIVL( 18, 2, 1, 1025, 1024 );
  TEST_VSETCFGIVL( 19, 2, 1, 1023, 1023 );

  TEST_VSETCFGIVL( 23, 3, 1, 680, 680 );
  TEST_VSETCFGIVL( 24, 3, 1, 681, 680 );
  TEST_VSETCFGIVL( 25, 3, 1, 679, 679 );

  TEST_VSETCFGIVL( 29, 4, 1, 512, 512 );
  TEST_VSETCFGIVL( 30, 4, 1, 513, 512 );
  TEST_VSETCFGIVL( 31, 4, 1, 511, 511 );

  TEST_VSETCFGIVL( 35, 5, 1, 408, 408 );
  TEST_VSETCFGIVL( 36, 5, 1, 409, 408 );
  TEST_VSETCFGIVL( 37, 5, 1, 407, 407 );

  TEST_VSETCFGIVL( 41, 6, 1, 336, 336 );
  TEST_VSETCFGIVL( 42, 6, 1, 337, 336 );
  TEST_VSETCFGIVL( 43, 6, 1, 335, 335 );

  TEST_VSETCFGIVL( 47, 7, 1, 288, 288 );
  TEST_VSETCFGIVL( 48, 7, 1, 289, 288 );
  TEST_VSETCFGIVL( 49, 7, 1, 287, 287 );

  TEST_VSETCFGIVL( 53, 8, 1, 256, 256 );
  TEST_VSETCFGIVL( 54, 8, 1, 257, 256 );
  TEST_VSETCFGIVL( 55, 8, 1, 255, 255 );

  TEST_VSETCFGIVL( 59, 9, 1, 224, 224 );
  TEST_VSETCFGIVL( 60, 9, 1, 225, 224 );
  TEST_VSETCFGIVL( 61, 9, 1, 223, 223 );

  TEST_VSETCFGIVL( 65, 10, 1, 200, 200 );
  TEST_VSETCFGIVL( 66, 10, 1, 201, 200 );
  TEST_VSETCFGIVL( 67, 10, 1, 199, 199 );

  TEST_VSETCFGIVL( 71, 11, 1, 184, 184 );
  TEST_VSETCFGIVL( 72, 11, 1, 185, 184 );
  TEST_VSETCFGIVL( 73, 11, 1, 183, 183 );

  TEST_VSETCFGIVL( 77, 12, 1, 168, 168 );
  TEST_VSETCFGIVL( 78, 12, 1, 169, 168 );
  TEST_VSETCFGIVL( 79, 12, 1, 167, 167 );

  TEST_VSETCFGIVL( 83, 13, 1, 152, 152 );
  TEST_VSETCFGIVL( 84, 13, 1, 153, 152 );
  TEST_VSETCFGIVL( 85, 13, 1, 151, 151 );

  TEST_VSETCFGIVL( 89, 14, 1,  144, 144 );
  TEST_VSETCFGIVL( 90, 14, 1,  145, 144 );
  TEST_VSETCFGIVL( 91, 14, 1,  143, 143 );

  TEST_VSETCFGIVL( 95, 15, 1,  136, 136 );
  TEST_VSETCFGIVL( 96, 15, 1,  137, 136 );
  TEST_VSETCFGIVL( 97, 15, 1,  135, 135 );

  TEST_VSETCFGIVL( 101, 16, 1, 128, 128 );
  TEST_VSETCFGIVL( 102, 16, 1, 129, 128 );
  TEST_VSETCFGIVL( 103, 16, 1, 127, 127 );

  TEST_VSETCFGIVL( 107, 17, 1, 120, 120 );
  TEST_VSETCFGIVL( 108, 17, 1, 121, 120 );
  TEST_VSETCFGIVL( 109, 17, 1, 119, 119 );

  TEST_VSETCFGIVL( 113, 18, 1, 112, 112 );
  TEST_VSETCFGIVL( 114, 18, 1, 113, 112 );
  TEST_VSETCFGIVL( 115, 18, 1, 111, 111 );

  TEST_VSETCFGIVL( 119, 19, 1, 104, 104 );
  TEST_VSETCFGIVL( 120, 19, 1, 105, 104 );
  TEST_VSETCFGIVL( 121, 19, 1, 103, 103 );

  TEST_VSETCFGIVL( 125, 20, 1, 96, 96  );
  TEST_VSETCFGIVL( 126, 20, 1, 97, 96  );
  TEST_VSETCFGIVL( 127, 20, 1, 95, 95  );

  TEST_VSETCFGIVL( 131, 21, 1, 96, 96 );
  TEST_VSETCFGIVL( 132, 21, 1, 97, 96 );
  TEST_VSETCFGIVL( 133, 21, 1, 95, 95 );

  TEST_VSETCFGIVL( 137, 22, 1, 88, 88 );
  TEST_VSETCFGIVL( 138, 22, 1, 89, 88 );
  TEST_VSETCFGIVL( 139, 22, 1, 87, 87 );

  TEST_VSETCFGIVL( 143, 23, 1, 88, 88 );
  TEST_VSETCFGIVL( 144, 23, 1, 89, 88 );
  TEST_VSETCFGIVL( 145, 23, 1, 87, 87 );

  TEST_VSETCFGIVL( 149, 24, 1, 80, 80 );
  TEST_VSETCFGIVL( 150, 24, 1, 81, 80 );
  TEST_VSETCFGIVL( 151, 24, 1, 79, 79 );

  TEST_VSETCFGIVL( 155, 25, 1, 80, 80 );
  TEST_VSETCFGIVL( 156, 25, 1, 81, 80 );
  TEST_VSETCFGIVL( 157, 25, 1, 79, 79 );

  TEST_VSETCFGIVL( 161, 26, 1, 72, 72 );
  TEST_VSETCFGIVL( 162, 26, 1, 73, 72 );
  TEST_VSETCFGIVL( 163, 26, 1, 71, 71 );

  TEST_VSETCFGIVL( 167, 27, 1, 72, 72 );
  TEST_VSETCFGIVL( 168, 27, 1, 73, 72 );
  TEST_VSETCFGIVL( 169, 27, 1, 71, 71 );

  TEST_VSETCFGIVL( 173, 28, 1, 72, 72 );
  TEST_VSETCFGIVL( 174, 28, 1, 73, 72 );
  TEST_VSETCFGIVL( 175, 28, 1, 71, 71 );

  TEST_VSETCFGIVL( 179, 29, 1, 64, 64 );
  TEST_VSETCFGIVL( 180, 29, 1, 65, 64 );
  TEST_VSETCFGIVL( 181, 29, 1, 63, 63 );

  TEST_VSETCFGIVL( 185, 30, 1, 64, 64 );
  TEST_VSETCFGIVL( 186, 30, 1, 65, 64 );
  TEST_VSETCFGIVL( 187, 30, 1, 63, 63 );

  TEST_VSETCFGIVL( 191, 31, 1, 64, 64 );
  TEST_VSETCFGIVL( 192, 31, 1, 65, 64 );
  TEST_VSETCFGIVL( 193, 31, 1, 63, 63 );

  TEST_VSETCFGIVL( 197, 32, 1, 64, 64 );
  TEST_VSETCFGIVL( 198, 32, 1, 65, 64 );
  TEST_VSETCFGIVL( 199, 32, 1, 63, 63 );
                          
  TEST_VSETCFGIVL( 200, 33, 1, 56, 56 );
  TEST_VSETCFGIVL( 201, 33, 1, 57, 56 );
  TEST_VSETCFGIVL( 202, 33, 1, 55, 55 );
                          
  TEST_VSETCFGIVL( 203, 34, 1, 56, 56 );
  TEST_VSETCFGIVL( 204, 34, 1, 57, 56 );
  TEST_VSETCFGIVL( 205, 34, 1, 55, 55 );
                          
  TEST_VSETCFGIVL( 206, 35, 1, 56, 56 );
  TEST_VSETCFGIVL( 207, 35, 1, 57, 56 );
  TEST_VSETCFGIVL( 208, 35, 1, 55, 55 );
                          
  TEST_VSETCFGIVL( 209, 36, 1, 56, 56 );
  TEST_VSETCFGIVL( 210, 36, 1, 57, 56 );
  TEST_VSETCFGIVL( 211, 36, 1, 55, 55 );
                          
  TEST_VSETCFGIVL( 212, 37, 1, 48, 48 );
  TEST_VSETCFGIVL( 213, 37, 1, 49, 48 );
  TEST_VSETCFGIVL( 214, 37, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 215, 38, 1, 48, 48 );
  TEST_VSETCFGIVL( 216, 38, 1, 49, 48 );
  TEST_VSETCFGIVL( 217, 38, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 218, 39, 1, 48, 48 );
  TEST_VSETCFGIVL( 219, 39, 1, 49, 48 );
  TEST_VSETCFGIVL( 220, 39, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 221, 40, 1, 48, 48 );
  TEST_VSETCFGIVL( 222, 40, 1, 49, 48 );
  TEST_VSETCFGIVL( 223, 40, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 224, 41, 1, 48, 48 );
  TEST_VSETCFGIVL( 225, 41, 1, 49, 48 );
  TEST_VSETCFGIVL( 226, 41, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 227, 42, 1, 48, 48 );
  TEST_VSETCFGIVL( 228, 42, 1, 49, 48 );
  TEST_VSETCFGIVL( 229, 42, 1, 47, 47 );
                          
  TEST_VSETCFGIVL( 230, 43, 1, 40, 40 );
  TEST_VSETCFGIVL( 231, 43, 1, 41, 40 );
  TEST_VSETCFGIVL( 232, 43, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 233, 44, 1, 40, 40 );
  TEST_VSETCFGIVL( 234, 44, 1, 41, 40 );
  TEST_VSETCFGIVL( 235, 44, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 236, 45, 1, 40, 40 );
  TEST_VSETCFGIVL( 237, 45, 1, 41, 40 );
  TEST_VSETCFGIVL( 238, 45, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 239, 46, 1, 40, 40 );
  TEST_VSETCFGIVL( 240, 46, 1, 41, 40 );
  TEST_VSETCFGIVL( 241, 46, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 242, 47, 1, 40, 40 );
  TEST_VSETCFGIVL( 243, 47, 1, 41, 40 );
  TEST_VSETCFGIVL( 244, 47, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 245, 48, 1, 40, 40 );
  TEST_VSETCFGIVL( 246, 48, 1, 41, 40 );
  TEST_VSETCFGIVL( 247, 48, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 248, 49, 1, 40, 40 );
  TEST_VSETCFGIVL( 249, 49, 1, 41, 40 );
  TEST_VSETCFGIVL( 250, 49, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 251, 50, 1, 40, 40 );
  TEST_VSETCFGIVL( 252, 50, 1, 41, 40 );
  TEST_VSETCFGIVL( 253, 50, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 254, 51, 1, 40, 40 );
  TEST_VSETCFGIVL( 255, 51, 1, 41, 40 );
  TEST_VSETCFGIVL( 256, 51, 1, 39, 39 );
                          
  TEST_VSETCFGIVL( 257, 52, 1, 32, 32 );
  TEST_VSETCFGIVL( 258, 52, 1, 33, 32 );
  TEST_VSETCFGIVL( 259, 52, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 260, 53, 1, 32, 32 );
  TEST_VSETCFGIVL( 261, 53, 1, 33, 32 );
  TEST_VSETCFGIVL( 262, 53, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 263, 54, 1, 32, 32 );
  TEST_VSETCFGIVL( 264, 54, 1, 33, 32 );
  TEST_VSETCFGIVL( 265, 54, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 266, 55, 1, 32, 32 );
  TEST_VSETCFGIVL( 267, 55, 1, 33, 32 );
  TEST_VSETCFGIVL( 268, 55, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 269, 56, 1, 32, 32 );
  TEST_VSETCFGIVL( 270, 56, 1, 33, 32 );
  TEST_VSETCFGIVL( 271, 56, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 272, 57, 1, 32, 32 );
  TEST_VSETCFGIVL( 273, 57, 1, 33, 32 );
  TEST_VSETCFGIVL( 274, 57, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 275, 58, 1, 32, 32 );
  TEST_VSETCFGIVL( 276, 58, 1, 33, 32 );
  TEST_VSETCFGIVL( 277, 58, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 278, 59, 1, 32, 32 );
  TEST_VSETCFGIVL( 279, 59, 1, 33, 32 );
  TEST_VSETCFGIVL( 280, 59, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 281, 60, 1, 32, 32 );
  TEST_VSETCFGIVL( 282, 60, 1, 33, 32 );
  TEST_VSETCFGIVL( 283, 60, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 284, 61, 1, 32, 32 );
  TEST_VSETCFGIVL( 285, 61, 1, 33, 32 );
  TEST_VSETCFGIVL( 286, 61, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 287, 62, 1, 32, 32 );
  TEST_VSETCFGIVL( 288, 62, 1, 33, 32 );
  TEST_VSETCFGIVL( 289, 62, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 290, 63, 1, 32, 32 );
  TEST_VSETCFGIVL( 291, 63, 1, 33, 32 );
  TEST_VSETCFGIVL( 292, 63, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 293, 64, 1, 32, 32 );
  TEST_VSETCFGIVL( 294, 64, 1, 33, 32 );
  TEST_VSETCFGIVL( 295, 64, 1, 31, 31 );
                          
  TEST_VSETCFGIVL( 296, 65, 1, 24, 24 );
  TEST_VSETCFGIVL( 297, 65, 1, 25, 24 );
  TEST_VSETCFGIVL( 298, 65, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 299, 66, 1, 24, 24 );
  TEST_VSETCFGIVL( 300, 66, 1, 25, 24 );
  TEST_VSETCFGIVL( 301, 66, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 302, 67, 1, 24, 24 );
  TEST_VSETCFGIVL( 303, 67, 1, 25, 24 );
  TEST_VSETCFGIVL( 304, 67, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 305, 68, 1, 24, 24 );
  TEST_VSETCFGIVL( 306, 68, 1, 25, 24 );
  TEST_VSETCFGIVL( 307, 68, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 308, 69, 1, 24, 24 );
  TEST_VSETCFGIVL( 309, 69, 1, 25, 24 );
  TEST_VSETCFGIVL( 310, 69, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 311, 70, 1, 24, 24 );
  TEST_VSETCFGIVL( 312, 70, 1, 25, 24 );
  TEST_VSETCFGIVL( 313, 70, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 314, 71, 1, 24, 24 );
  TEST_VSETCFGIVL( 315, 71, 1, 25, 24 );
  TEST_VSETCFGIVL( 316, 71, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 317, 72, 1, 24, 24 );
  TEST_VSETCFGIVL( 318, 72, 1, 25, 24 );
  TEST_VSETCFGIVL( 319, 72, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 320, 73, 1, 24, 24 );
  TEST_VSETCFGIVL( 321, 73, 1, 25, 24 );
  TEST_VSETCFGIVL( 322, 73, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 323, 74, 1, 24, 24 );
  TEST_VSETCFGIVL( 324, 74, 1, 25, 24 );
  TEST_VSETCFGIVL( 325, 74, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 326, 75, 1, 24, 24 );
  TEST_VSETCFGIVL( 327, 75, 1, 25, 24 );
  TEST_VSETCFGIVL( 328, 75, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 329, 76, 1, 24, 24 );
  TEST_VSETCFGIVL( 330, 76, 1, 25, 24 );
  TEST_VSETCFGIVL( 331, 76, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 332, 77, 1, 24, 24 );
  TEST_VSETCFGIVL( 333, 77, 1, 25, 24 );
  TEST_VSETCFGIVL( 334, 77, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 335, 78, 1, 24, 24 );
  TEST_VSETCFGIVL( 336, 78, 1, 25, 24 );
  TEST_VSETCFGIVL( 337, 78, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 338, 79, 1, 24, 24 );
  TEST_VSETCFGIVL( 339, 79, 1, 25, 24 );
  TEST_VSETCFGIVL( 340, 79, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 341, 80, 1, 24, 24 );
  TEST_VSETCFGIVL( 342, 80, 1, 25, 24 );
  TEST_VSETCFGIVL( 343, 80, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 344, 81, 1, 24, 24 );
  TEST_VSETCFGIVL( 345, 81, 1, 25, 24 );
  TEST_VSETCFGIVL( 346, 81, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 347, 82, 1, 24, 24 );
  TEST_VSETCFGIVL( 348, 82, 1, 25, 24 );
  TEST_VSETCFGIVL( 349, 82, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 350, 83, 1, 24, 24 );
  TEST_VSETCFGIVL( 351, 83, 1, 25, 24 );
  TEST_VSETCFGIVL( 352, 83, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 353, 84, 1, 24, 24 );
  TEST_VSETCFGIVL( 354, 84, 1, 25, 24 );
  TEST_VSETCFGIVL( 355, 84, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 356, 85, 1, 24, 24 );
  TEST_VSETCFGIVL( 357, 85, 1, 25, 24 );
  TEST_VSETCFGIVL( 358, 85, 1, 23, 23 );
                          
  TEST_VSETCFGIVL( 359, 86, 1, 16, 16 );
  TEST_VSETCFGIVL( 360, 86, 1, 17, 16 );
  TEST_VSETCFGIVL( 361, 86, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 362, 87, 1, 16, 16 );
  TEST_VSETCFGIVL( 363, 87, 1, 17, 16 );
  TEST_VSETCFGIVL( 364, 87, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 365, 88, 1, 16, 16 );
  TEST_VSETCFGIVL( 366, 88, 1, 17, 16 );
  TEST_VSETCFGIVL( 367, 88, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 368, 89, 1, 16, 16 );
  TEST_VSETCFGIVL( 369, 89, 1, 17, 16 );
  TEST_VSETCFGIVL( 370, 89, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 371, 90, 1, 16, 16 );
  TEST_VSETCFGIVL( 372, 90, 1, 17, 16 );
  TEST_VSETCFGIVL( 373, 90, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 374, 91, 1, 16, 16 );
  TEST_VSETCFGIVL( 375, 91, 1, 17, 16 );
  TEST_VSETCFGIVL( 376, 91, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 377, 92, 1, 16, 16 );
  TEST_VSETCFGIVL( 378, 92, 1, 17, 16 );
  TEST_VSETCFGIVL( 379, 92, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 380, 93, 1, 16, 16 );
  TEST_VSETCFGIVL( 381, 93, 1, 17, 16 );
  TEST_VSETCFGIVL( 382, 93, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 383, 94, 1, 16, 16 );
  TEST_VSETCFGIVL( 384, 94, 1, 17, 16 );
  TEST_VSETCFGIVL( 385, 94, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 386, 95, 1, 16, 16 );
  TEST_VSETCFGIVL( 387, 95, 1, 17, 16 );
  TEST_VSETCFGIVL( 388, 95, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 389, 96, 1, 16, 16 );
  TEST_VSETCFGIVL( 390, 96, 1, 17, 16 );
  TEST_VSETCFGIVL( 391, 96, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 392, 97, 1, 16, 16 );
  TEST_VSETCFGIVL( 393, 97, 1, 17, 16 );
  TEST_VSETCFGIVL( 394, 97, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 395, 98, 1, 16, 16 );
  TEST_VSETCFGIVL( 396, 98, 1, 17, 16 );
  TEST_VSETCFGIVL( 397, 98, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 398, 99, 1, 16, 16 );
  TEST_VSETCFGIVL( 399, 99, 1, 17, 16 );
  TEST_VSETCFGIVL( 400, 99, 1, 15, 15 );
                          
  TEST_VSETCFGIVL( 401, 100, 1,16, 16 );
  TEST_VSETCFGIVL( 402, 100, 1,17, 16 );
  TEST_VSETCFGIVL( 403, 100, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 404, 101, 1,16, 16 );
  TEST_VSETCFGIVL( 405, 101, 1,17, 16 );
  TEST_VSETCFGIVL( 406, 101, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 407, 102, 1,16, 16 );
  TEST_VSETCFGIVL( 408, 102, 1,17, 16 );
  TEST_VSETCFGIVL( 409, 102, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 410, 103, 1,16, 16 );
  TEST_VSETCFGIVL( 411, 103, 1,17, 16 );
  TEST_VSETCFGIVL( 412, 103, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 413, 104, 1,16, 16 );
  TEST_VSETCFGIVL( 414, 104, 1,17, 16 );
  TEST_VSETCFGIVL( 415, 104, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 416, 105, 1,16, 16 );
  TEST_VSETCFGIVL( 417, 105, 1,17, 16 );
  TEST_VSETCFGIVL( 418, 105, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 419, 106, 1,16, 16 );
  TEST_VSETCFGIVL( 420, 106, 1,17, 16 );
  TEST_VSETCFGIVL( 421, 106, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 422, 107, 1,16, 16 );
  TEST_VSETCFGIVL( 423, 107, 1,17, 16 );
  TEST_VSETCFGIVL( 424, 107, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 425, 108, 1,16, 16 );
  TEST_VSETCFGIVL( 426, 108, 1,17, 16 );
  TEST_VSETCFGIVL( 427, 108, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 428, 109, 1,16, 16 );
  TEST_VSETCFGIVL( 429, 109, 1,17, 16 );
  TEST_VSETCFGIVL( 430, 109, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 431, 110, 1,16, 16 );
  TEST_VSETCFGIVL( 432, 110, 1,17, 16 );
  TEST_VSETCFGIVL( 433, 110, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 434, 111, 1,16, 16 );
  TEST_VSETCFGIVL( 435, 111, 1,17, 16 );
  TEST_VSETCFGIVL( 436, 111, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 437, 112, 1,16, 16 );
  TEST_VSETCFGIVL( 438, 112, 1,17, 16 );
  TEST_VSETCFGIVL( 439, 112, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 440, 113, 1,16, 16 );
  TEST_VSETCFGIVL( 441, 113, 1,17, 16 );
  TEST_VSETCFGIVL( 442, 113, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 443, 114, 1,16, 16 );
  TEST_VSETCFGIVL( 444, 114, 1,17, 16 );
  TEST_VSETCFGIVL( 445, 114, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 446, 115, 1,16, 16 );
  TEST_VSETCFGIVL( 447, 115, 1,17, 16 );
  TEST_VSETCFGIVL( 448, 115, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 449, 116, 1,16, 16 );
  TEST_VSETCFGIVL( 450, 116, 1,17, 16 );
  TEST_VSETCFGIVL( 451, 116, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 452, 117, 1,16, 16 );
  TEST_VSETCFGIVL( 453, 117, 1,17, 16 );
  TEST_VSETCFGIVL( 454, 117, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 455, 118, 1,16, 16 );
  TEST_VSETCFGIVL( 456, 118, 1,17, 16 );
  TEST_VSETCFGIVL( 457, 118, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 458, 119, 1,16, 16 );
  TEST_VSETCFGIVL( 459, 119, 1,17, 16 );
  TEST_VSETCFGIVL( 460, 119, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 461, 120, 1,16, 16 );
  TEST_VSETCFGIVL( 462, 120, 1,17, 16 );
  TEST_VSETCFGIVL( 463, 120, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 464, 121, 1,16, 16 );
  TEST_VSETCFGIVL( 465, 121, 1,17, 16 );
  TEST_VSETCFGIVL( 466, 121, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 467, 122, 1,16, 16 );
  TEST_VSETCFGIVL( 468, 122, 1,17, 16 );
  TEST_VSETCFGIVL( 469, 122, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 470, 123, 1,16, 16 );
  TEST_VSETCFGIVL( 471, 123, 1,17, 16 );
  TEST_VSETCFGIVL( 472, 123, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 473, 124, 1,16, 16 );
  TEST_VSETCFGIVL( 474, 124, 1,17, 16 );
  TEST_VSETCFGIVL( 475, 124, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 476, 125, 1,16, 16 );
  TEST_VSETCFGIVL( 477, 125, 1,17, 16 );
  TEST_VSETCFGIVL( 478, 125, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 479, 126, 1,16, 16 );
  TEST_VSETCFGIVL( 480, 126, 1,17, 16 );
  TEST_VSETCFGIVL( 481, 126, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 482, 127, 1,16, 16 );
  TEST_VSETCFGIVL( 483, 127, 1,17, 16 );
  TEST_VSETCFGIVL( 484, 127, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 485, 128, 1,16, 16 );
  TEST_VSETCFGIVL( 486, 128, 1,17, 16 );
  TEST_VSETCFGIVL( 487, 128, 1,15, 15 );
                          
  TEST_VSETCFGIVL( 488, 129, 1, 8,  8 );
  TEST_VSETCFGIVL( 489, 129, 1, 9,  8 );
  TEST_VSETCFGIVL( 490, 129, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 491, 130, 1, 8,  8 );
  TEST_VSETCFGIVL( 492, 130, 1, 9,  8 );
  TEST_VSETCFGIVL( 493, 130, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 494, 131, 1, 8,  8 );
  TEST_VSETCFGIVL( 495, 131, 1, 9,  8 );
  TEST_VSETCFGIVL( 496, 131, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 497, 132, 1, 8,  8 );
  TEST_VSETCFGIVL( 498, 132, 1, 9,  8 );
  TEST_VSETCFGIVL( 499, 132, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 500, 133, 1, 8,  8 );
  TEST_VSETCFGIVL( 501, 133, 1, 9,  8 );
  TEST_VSETCFGIVL( 502, 133, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 503, 134, 1, 8,  8 );
  TEST_VSETCFGIVL( 504, 134, 1, 9,  8 );
  TEST_VSETCFGIVL( 505, 134, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 506, 135, 1, 8,  8 );
  TEST_VSETCFGIVL( 507, 135, 1, 9,  8 );
  TEST_VSETCFGIVL( 508, 135, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 509, 136, 1, 8,  8 );
  TEST_VSETCFGIVL( 510, 136, 1, 9,  8 );
  TEST_VSETCFGIVL( 511, 136, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 512, 137, 1, 8,  8 );
  TEST_VSETCFGIVL( 513, 137, 1, 9,  8 );
  TEST_VSETCFGIVL( 514, 137, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 515, 138, 1, 8,  8 );
  TEST_VSETCFGIVL( 516, 138, 1, 9,  8 );
  TEST_VSETCFGIVL( 517, 138, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 518, 139, 1, 8,  8 );
  TEST_VSETCFGIVL( 519, 139, 1, 9,  8 );
  TEST_VSETCFGIVL( 520, 139, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 521, 140, 1, 8,  8 );
  TEST_VSETCFGIVL( 522, 140, 1, 9,  8 );
  TEST_VSETCFGIVL( 523, 140, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 524, 141, 1, 8,  8 );
  TEST_VSETCFGIVL( 525, 141, 1, 9,  8 );
  TEST_VSETCFGIVL( 526, 141, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 527, 142, 1, 8,  8 );
  TEST_VSETCFGIVL( 528, 142, 1, 9,  8 );
  TEST_VSETCFGIVL( 529, 142, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 530, 143, 1, 8,  8 );
  TEST_VSETCFGIVL( 531, 143, 1, 9,  8 );
  TEST_VSETCFGIVL( 532, 143, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 533, 144, 1, 8,  8 );
  TEST_VSETCFGIVL( 534, 144, 1, 9,  8 );
  TEST_VSETCFGIVL( 535, 144, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 536, 145, 1, 8,  8 );
  TEST_VSETCFGIVL( 537, 145, 1, 9,  8 );
  TEST_VSETCFGIVL( 538, 145, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 539, 146, 1, 8,  8 );
  TEST_VSETCFGIVL( 540, 146, 1, 9,  8 );
  TEST_VSETCFGIVL( 541, 146, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 542, 147, 1, 8,  8 );
  TEST_VSETCFGIVL( 543, 147, 1, 9,  8 );
  TEST_VSETCFGIVL( 544, 147, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 545, 148, 1, 8,  8 );
  TEST_VSETCFGIVL( 546, 148, 1, 9,  8 );
  TEST_VSETCFGIVL( 547, 148, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 548, 149, 1, 8,  8 );
  TEST_VSETCFGIVL( 549, 149, 1, 9,  8 );
  TEST_VSETCFGIVL( 550, 149, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 551, 150, 1, 8,  8 );
  TEST_VSETCFGIVL( 552, 150, 1, 9,  8 );
  TEST_VSETCFGIVL( 553, 150, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 554, 151, 1, 8,  8 );
  TEST_VSETCFGIVL( 555, 151, 1, 9,  8 );
  TEST_VSETCFGIVL( 556, 151, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 557, 152, 1, 8,  8 );
  TEST_VSETCFGIVL( 558, 152, 1, 9,  8 );
  TEST_VSETCFGIVL( 559, 152, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 560, 153, 1, 8,  8 );
  TEST_VSETCFGIVL( 561, 153, 1, 9,  8 );
  TEST_VSETCFGIVL( 562, 153, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 563, 154, 1, 8,  8 );
  TEST_VSETCFGIVL( 564, 154, 1, 9,  8 );
  TEST_VSETCFGIVL( 565, 154, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 566, 155, 1, 8,  8 );
  TEST_VSETCFGIVL( 567, 155, 1, 9,  8 );
  TEST_VSETCFGIVL( 568, 155, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 569, 156, 1, 8,  8 );
  TEST_VSETCFGIVL( 570, 156, 1, 9,  8 );
  TEST_VSETCFGIVL( 571, 156, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 572, 157, 1, 8,  8 );
  TEST_VSETCFGIVL( 573, 157, 1, 9,  8 );
  TEST_VSETCFGIVL( 574, 157, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 575, 158, 1, 8,  8 );
  TEST_VSETCFGIVL( 576, 158, 1, 9,  8 );
  TEST_VSETCFGIVL( 577, 158, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 578, 159, 1, 8,  8 );
  TEST_VSETCFGIVL( 579, 159, 1, 9,  8 );
  TEST_VSETCFGIVL( 580, 159, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 581, 160, 1, 8,  8 );
  TEST_VSETCFGIVL( 582, 160, 1, 9,  8 );
  TEST_VSETCFGIVL( 583, 160, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 584, 161, 1, 8,  8 );
  TEST_VSETCFGIVL( 585, 161, 1, 9,  8 );
  TEST_VSETCFGIVL( 586, 161, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 587, 162, 1, 8,  8 );
  TEST_VSETCFGIVL( 588, 162, 1, 9,  8 );
  TEST_VSETCFGIVL( 589, 162, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 590, 163, 1, 8,  8 );
  TEST_VSETCFGIVL( 591, 163, 1, 9,  8 );
  TEST_VSETCFGIVL( 592, 163, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 593, 164, 1, 8,  8 );
  TEST_VSETCFGIVL( 594, 164, 1, 9,  8 );
  TEST_VSETCFGIVL( 595, 164, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 596, 165, 1, 8,  8 );
  TEST_VSETCFGIVL( 597, 165, 1, 9,  8 );
  TEST_VSETCFGIVL( 598, 165, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 599, 166, 1, 8,  8 );
  TEST_VSETCFGIVL( 600, 166, 1, 9,  8 );
  TEST_VSETCFGIVL( 601, 166, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 602, 167, 1, 8,  8 );
  TEST_VSETCFGIVL( 603, 167, 1, 9,  8 );
  TEST_VSETCFGIVL( 604, 167, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 605, 168, 1, 8,  8 );
  TEST_VSETCFGIVL( 606, 168, 1, 9,  8 );
  TEST_VSETCFGIVL( 607, 168, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 608, 169, 1, 8,  8 );
  TEST_VSETCFGIVL( 609, 169, 1, 9,  8 );
  TEST_VSETCFGIVL( 610, 169, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 611, 170, 1, 8,  8 );
  TEST_VSETCFGIVL( 612, 170, 1, 9,  8 );
  TEST_VSETCFGIVL( 613, 170, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 614, 171, 1, 8,  8 );
  TEST_VSETCFGIVL( 615, 171, 1, 9,  8 );
  TEST_VSETCFGIVL( 616, 171, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 617, 172, 1, 8,  8 );
  TEST_VSETCFGIVL( 618, 172, 1, 9,  8 );
  TEST_VSETCFGIVL( 619, 172, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 620, 173, 1, 8,  8 );
  TEST_VSETCFGIVL( 621, 173, 1, 9,  8 );
  TEST_VSETCFGIVL( 622, 173, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 623, 174, 1, 8,  8 );
  TEST_VSETCFGIVL( 624, 174, 1, 9,  8 );
  TEST_VSETCFGIVL( 625, 174, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 626, 175, 1, 8,  8 );
  TEST_VSETCFGIVL( 627, 175, 1, 9,  8 );
  TEST_VSETCFGIVL( 628, 175, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 629, 176, 1, 8,  8 );
  TEST_VSETCFGIVL( 630, 176, 1, 9,  8 );
  TEST_VSETCFGIVL( 631, 176, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 632, 177, 1, 8,  8 );
  TEST_VSETCFGIVL( 633, 177, 1, 9,  8 );
  TEST_VSETCFGIVL( 634, 177, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 635, 178, 1, 8,  8 );
  TEST_VSETCFGIVL( 636, 178, 1, 9,  8 );
  TEST_VSETCFGIVL( 637, 178, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 638, 179, 1, 8,  8 );
  TEST_VSETCFGIVL( 639, 179, 1, 9,  8 );
  TEST_VSETCFGIVL( 640, 179, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 641, 180, 1, 8,  8 );
  TEST_VSETCFGIVL( 642, 180, 1, 9,  8 );
  TEST_VSETCFGIVL( 643, 180, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 644, 181, 1, 8,  8 );
  TEST_VSETCFGIVL( 645, 181, 1, 9,  8 );
  TEST_VSETCFGIVL( 646, 181, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 647, 182, 1, 8,  8 );
  TEST_VSETCFGIVL( 648, 182, 1, 9,  8 );
  TEST_VSETCFGIVL( 649, 182, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 650, 183, 1, 8,  8 );
  TEST_VSETCFGIVL( 651, 183, 1, 9,  8 );
  TEST_VSETCFGIVL( 652, 183, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 653, 184, 1, 8,  8 );
  TEST_VSETCFGIVL( 654, 184, 1, 9,  8 );
  TEST_VSETCFGIVL( 655, 184, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 656, 185, 1, 8,  8 );
  TEST_VSETCFGIVL( 657, 185, 1, 9,  8 );
  TEST_VSETCFGIVL( 658, 185, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 659, 186, 1, 8,  8 );
  TEST_VSETCFGIVL( 660, 186, 1, 9,  8 );
  TEST_VSETCFGIVL( 661, 186, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 662, 187, 1, 8,  8 );
  TEST_VSETCFGIVL( 663, 187, 1, 9,  8 );
  TEST_VSETCFGIVL( 664, 187, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 665, 188, 1, 8,  8 );
  TEST_VSETCFGIVL( 666, 188, 1, 9,  8 );
  TEST_VSETCFGIVL( 667, 188, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 668, 189, 1, 8,  8 );
  TEST_VSETCFGIVL( 669, 189, 1, 9,  8 );
  TEST_VSETCFGIVL( 670, 189, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 671, 190, 1, 8,  8 );
  TEST_VSETCFGIVL( 672, 190, 1, 9,  8 );
  TEST_VSETCFGIVL( 673, 190, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 674, 191, 1, 8,  8 );
  TEST_VSETCFGIVL( 675, 191, 1, 9,  8 );
  TEST_VSETCFGIVL( 676, 191, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 677, 192, 1, 8,  8 );
  TEST_VSETCFGIVL( 678, 192, 1, 9,  8 );
  TEST_VSETCFGIVL( 679, 192, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 680, 193, 1, 8,  8 );
  TEST_VSETCFGIVL( 681, 193, 1, 9,  8 );
  TEST_VSETCFGIVL( 682, 193, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 683, 194, 1, 8,  8 );
  TEST_VSETCFGIVL( 684, 194, 1, 9,  8 );
  TEST_VSETCFGIVL( 685, 194, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 686, 195, 1, 8,  8 );
  TEST_VSETCFGIVL( 687, 195, 1, 9,  8 );
  TEST_VSETCFGIVL( 688, 195, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 689, 196, 1, 8,  8 );
  TEST_VSETCFGIVL( 690, 196, 1, 9,  8 );
  TEST_VSETCFGIVL( 691, 196, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 692, 197, 1, 8,  8 );
  TEST_VSETCFGIVL( 693, 197, 1, 9,  8 );
  TEST_VSETCFGIVL( 694, 197, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 695, 198, 1, 8,  8 );
  TEST_VSETCFGIVL( 696, 198, 1, 9,  8 );
  TEST_VSETCFGIVL( 697, 198, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 698, 199, 1, 8,  8 );
  TEST_VSETCFGIVL( 699, 199, 1, 9,  8 );
  TEST_VSETCFGIVL( 700, 199, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 701, 200, 1, 8,  8 );
  TEST_VSETCFGIVL( 702, 200, 1, 9,  8 );
  TEST_VSETCFGIVL( 703, 200, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 704, 201, 1, 8,  8 );
  TEST_VSETCFGIVL( 705, 201, 1, 9,  8 );
  TEST_VSETCFGIVL( 706, 201, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 707, 202, 1, 8,  8 );
  TEST_VSETCFGIVL( 708, 202, 1, 9,  8 );
  TEST_VSETCFGIVL( 709, 202, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 710, 203, 1, 8,  8 );
  TEST_VSETCFGIVL( 711, 203, 1, 9,  8 );
  TEST_VSETCFGIVL( 712, 203, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 713, 204, 1, 8,  8 );
  TEST_VSETCFGIVL( 714, 204, 1, 9,  8 );
  TEST_VSETCFGIVL( 715, 204, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 716, 205, 1, 8,  8 );
  TEST_VSETCFGIVL( 717, 205, 1, 9,  8 );
  TEST_VSETCFGIVL( 718, 205, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 719, 206, 1, 8,  8 );
  TEST_VSETCFGIVL( 720, 206, 1, 9,  8 );
  TEST_VSETCFGIVL( 721, 206, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 722, 207, 1, 8,  8 );
  TEST_VSETCFGIVL( 723, 207, 1, 9,  8 );
  TEST_VSETCFGIVL( 724, 207, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 725, 208, 1, 8,  8 );
  TEST_VSETCFGIVL( 726, 208, 1, 9,  8 );
  TEST_VSETCFGIVL( 727, 208, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 728, 209, 1, 8,  8 );
  TEST_VSETCFGIVL( 729, 209, 1, 9,  8 );
  TEST_VSETCFGIVL( 730, 209, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 731, 210, 1, 8,  8 );
  TEST_VSETCFGIVL( 732, 210, 1, 9,  8 );
  TEST_VSETCFGIVL( 733, 210, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 734, 211, 1, 8,  8 );
  TEST_VSETCFGIVL( 735, 211, 1, 9,  8 );
  TEST_VSETCFGIVL( 736, 211, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 737, 212, 1, 8,  8 );
  TEST_VSETCFGIVL( 738, 212, 1, 9,  8 );
  TEST_VSETCFGIVL( 739, 212, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 740, 213, 1, 8,  8 );
  TEST_VSETCFGIVL( 741, 213, 1, 9,  8 );
  TEST_VSETCFGIVL( 742, 213, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 743, 214, 1, 8,  8 );
  TEST_VSETCFGIVL( 744, 214, 1, 9,  8 );
  TEST_VSETCFGIVL( 745, 214, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 746, 215, 1, 8,  8 );
  TEST_VSETCFGIVL( 747, 215, 1, 9,  8 );
  TEST_VSETCFGIVL( 748, 215, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 749, 216, 1, 8,  8 );
  TEST_VSETCFGIVL( 750, 216, 1, 9,  8 );
  TEST_VSETCFGIVL( 751, 216, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 752, 217, 1, 8,  8 );
  TEST_VSETCFGIVL( 753, 217, 1, 9,  8 );
  TEST_VSETCFGIVL( 754, 217, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 755, 218, 1, 8,  8 );
  TEST_VSETCFGIVL( 756, 218, 1, 9,  8 );
  TEST_VSETCFGIVL( 757, 218, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 758, 219, 1, 8,  8 );
  TEST_VSETCFGIVL( 759, 219, 1, 9,  8 );
  TEST_VSETCFGIVL( 760, 219, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 761, 220, 1, 8,  8 );
  TEST_VSETCFGIVL( 762, 220, 1, 9,  8 );
  TEST_VSETCFGIVL( 763, 220, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 764, 221, 1, 8,  8 );
  TEST_VSETCFGIVL( 765, 221, 1, 9,  8 );
  TEST_VSETCFGIVL( 766, 221, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 767, 222, 1, 8,  8 );
  TEST_VSETCFGIVL( 768, 222, 1, 9,  8 );
  TEST_VSETCFGIVL( 769, 222, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 770, 223, 1, 8,  8 );
  TEST_VSETCFGIVL( 771, 223, 1, 9,  8 );
  TEST_VSETCFGIVL( 772, 223, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 773, 224, 1, 8,  8 );
  TEST_VSETCFGIVL( 774, 224, 1, 9,  8 );
  TEST_VSETCFGIVL( 775, 224, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 776, 225, 1, 8,  8 );
  TEST_VSETCFGIVL( 777, 225, 1, 9,  8 );
  TEST_VSETCFGIVL( 778, 225, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 779, 226, 1, 8,  8 );
  TEST_VSETCFGIVL( 780, 226, 1, 9,  8 );
  TEST_VSETCFGIVL( 781, 226, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 782, 227, 1, 8,  8 );
  TEST_VSETCFGIVL( 783, 227, 1, 9,  8 );
  TEST_VSETCFGIVL( 784, 227, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 785, 228, 1, 8,  8 );
  TEST_VSETCFGIVL( 786, 228, 1, 9,  8 );
  TEST_VSETCFGIVL( 787, 228, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 788, 229, 1, 8,  8 );
  TEST_VSETCFGIVL( 789, 229, 1, 9,  8 );
  TEST_VSETCFGIVL( 790, 229, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 791, 230, 1, 8,  8 );
  TEST_VSETCFGIVL( 792, 230, 1, 9,  8 );
  TEST_VSETCFGIVL( 793, 230, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 794, 231, 1, 8,  8 );
  TEST_VSETCFGIVL( 795, 231, 1, 9,  8 );
  TEST_VSETCFGIVL( 796, 231, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 797, 232, 1, 8,  8 );
  TEST_VSETCFGIVL( 798, 232, 1, 9,  8 );
  TEST_VSETCFGIVL( 799, 232, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 800, 233, 1, 8,  8 );
  TEST_VSETCFGIVL( 801, 233, 1, 9,  8 );
  TEST_VSETCFGIVL( 802, 233, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 803, 234, 1, 8,  8 );
  TEST_VSETCFGIVL( 804, 234, 1, 9,  8 );
  TEST_VSETCFGIVL( 805, 234, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 806, 235, 1, 8,  8 );
  TEST_VSETCFGIVL( 807, 235, 1, 9,  8 );
  TEST_VSETCFGIVL( 808, 235, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 809, 236, 1, 8,  8 );
  TEST_VSETCFGIVL( 810, 236, 1, 9,  8 );
  TEST_VSETCFGIVL( 811, 236, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 812, 237, 1, 8,  8 );
  TEST_VSETCFGIVL( 813, 237, 1, 9,  8 );
  TEST_VSETCFGIVL( 814, 237, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 815, 238, 1, 8,  8 );
  TEST_VSETCFGIVL( 816, 238, 1, 9,  8 );
  TEST_VSETCFGIVL( 817, 238, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 818, 239, 1, 8,  8 );
  TEST_VSETCFGIVL( 819, 239, 1, 9,  8 );
  TEST_VSETCFGIVL( 820, 239, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 821, 240, 1, 8,  8 );
  TEST_VSETCFGIVL( 822, 240, 1, 9,  8 );
  TEST_VSETCFGIVL( 823, 240, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 824, 241, 1, 8,  8 );
  TEST_VSETCFGIVL( 825, 241, 1, 9,  8 );
  TEST_VSETCFGIVL( 826, 241, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 827, 242, 1, 8,  8 );
  TEST_VSETCFGIVL( 828, 242, 1, 9,  8 );
  TEST_VSETCFGIVL( 829, 242, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 830, 243, 1, 8,  8 );
  TEST_VSETCFGIVL( 831, 243, 1, 9,  8 );
  TEST_VSETCFGIVL( 832, 243, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 833, 244, 1, 8,  8 );
  TEST_VSETCFGIVL( 834, 244, 1, 9,  8 );
  TEST_VSETCFGIVL( 835, 244, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 836, 245, 1, 8,  8 );
  TEST_VSETCFGIVL( 837, 245, 1, 9,  8 );
  TEST_VSETCFGIVL( 838, 245, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 839, 246, 1, 8,  8 );
  TEST_VSETCFGIVL( 840, 246, 1, 9,  8 );
  TEST_VSETCFGIVL( 841, 246, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 842, 247, 1, 8,  8 );
  TEST_VSETCFGIVL( 843, 247, 1, 9,  8 );
  TEST_VSETCFGIVL( 844, 247, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 845, 248, 1, 8,  8 );
  TEST_VSETCFGIVL( 846, 248, 1, 9,  8 );
  TEST_VSETCFGIVL( 847, 248, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 848, 249, 1, 8,  8 );
  TEST_VSETCFGIVL( 849, 249, 1, 9,  8 );
  TEST_VSETCFGIVL( 850, 249, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 851, 250, 1, 8,  8 );
  TEST_VSETCFGIVL( 852, 250, 1, 9,  8 );
  TEST_VSETCFGIVL( 853, 250, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 854, 251, 1, 8,  8 );
  TEST_VSETCFGIVL( 855, 251, 1, 9,  8 );
  TEST_VSETCFGIVL( 856, 251, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 857, 252, 1, 8,  8 );
  TEST_VSETCFGIVL( 858, 252, 1, 9,  8 );
  TEST_VSETCFGIVL( 859, 252, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 860, 253, 1, 8,  8 );
  TEST_VSETCFGIVL( 861, 253, 1, 9,  8 );
  TEST_VSETCFGIVL( 862, 253, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 863, 254, 1, 8,  8 );
  TEST_VSETCFGIVL( 864, 254, 1, 9,  8 );
  TEST_VSETCFGIVL( 865, 254, 1, 7,  7 );
                          
  TEST_VSETCFGIVL( 866, 255, 1, 8,  8 );
  TEST_VSETCFGIVL( 867, 255, 1, 9,  8 );
  TEST_VSETCFGIVL( 868, 255, 1, 7,  7 );

  TEST_VSETCFGIVL( 869, 32, 2, 64, 64 );
  TEST_VSETCFGIVL( 870, 32, 2, 65, 64 );
  TEST_VSETCFGIVL( 871, 32, 2, 63, 63 );

  TEST_VSETCFGIVL( 875, 32, 3, 64, 64 );
  TEST_VSETCFGIVL( 876, 32, 3, 65, 64 );
  TEST_VSETCFGIVL( 877, 32, 3, 63, 63 );

  TEST_VSETCFGIVL( 881, 32, 4, 64, 64 );
  TEST_VSETCFGIVL( 882, 32, 4, 65, 64 );
  TEST_VSETCFGIVL( 883, 32, 4, 63, 63 );

  TEST_VSETCFGIVL( 887, 32, 5, 64, 64 );
  TEST_VSETCFGIVL( 888, 32, 5, 65, 64 );
  TEST_VSETCFGIVL( 889, 32, 5, 63, 63 );

  TEST_VSETCFGIVL( 893, 32, 6, 64, 64 );
  TEST_VSETCFGIVL( 894, 32, 6, 65, 64 );
  TEST_VSETCFGIVL( 895, 32, 6, 63, 63 );

  TEST_VSETCFGIVL( 899, 32, 7, 64, 64 );
  TEST_VSETCFGIVL( 900, 32, 7, 65, 64 );
  TEST_VSETCFGIVL( 901, 32, 7, 63, 63 );

  TEST_VSETCFGIVL( 905, 32, 8, 64, 64 );
  TEST_VSETCFGIVL( 906, 32, 8, 65, 64 );
  TEST_VSETCFGIVL( 907, 32, 8, 63, 63 );

  TEST_VSETCFGIVL( 911, 32, 9, 64, 64  );
  TEST_VSETCFGIVL( 912, 32, 9, 65, 64  );
  TEST_VSETCFGIVL( 913, 32, 9, 63, 63  );

  TEST_VSETCFGIVL( 917, 32, 10, 64, 64  );
  TEST_VSETCFGIVL( 918, 32, 10, 65, 64  );
  TEST_VSETCFGIVL( 919, 32, 10, 63, 63  );

  TEST_VSETCFGIVL( 923, 32, 11, 64, 64  );
  TEST_VSETCFGIVL( 924, 32, 11, 65, 64  );
  TEST_VSETCFGIVL( 925, 32, 11, 63, 63  );

  TEST_VSETCFGIVL( 929, 32, 12, 64, 64  );
  TEST_VSETCFGIVL( 930, 32, 12, 65, 64  );
  TEST_VSETCFGIVL( 931, 32, 12, 63, 63  );

  TEST_VSETCFGIVL( 935, 32, 13, 64, 64  );
  TEST_VSETCFGIVL( 936, 32, 13, 65, 64  );
  TEST_VSETCFGIVL( 937, 32, 13, 63, 63  );

  TEST_VSETCFGIVL( 941, 32, 14, 64, 64  );
  TEST_VSETCFGIVL( 942, 32, 14, 65, 64  );
  TEST_VSETCFGIVL( 943, 32, 14, 63, 63  );

  TEST_VSETCFGIVL( 947, 32, 15, 64, 64  );
  TEST_VSETCFGIVL( 948, 32, 15, 65, 64  );
  TEST_VSETCFGIVL( 949, 32, 15, 63, 63  );

  TEST_VSETCFGIVL( 953, 32, 16, 64, 64  );
  TEST_VSETCFGIVL( 954, 32, 16, 65, 64  );
  TEST_VSETCFGIVL( 955, 32, 16, 63, 63  );

  TEST_VSETCFGIVL( 956, 256, 2, 8,  8 );
  TEST_VSETCFGIVL( 957, 256, 2, 9,  8 );
  TEST_VSETCFGIVL( 958, 256, 2, 7,  7 );

  TEST_VSETCFGIVL( 962, 256, 3, 8,  8  );
  TEST_VSETCFGIVL( 963, 256, 3, 9,  8  );
  TEST_VSETCFGIVL( 964, 256, 3, 7,  7  );

  TEST_VSETCFGIVL( 968, 256, 4, 8,  8 );
  TEST_VSETCFGIVL( 969, 256, 4, 9,  8 );
  TEST_VSETCFGIVL( 970, 256, 4, 7,  7 );

  TEST_VSETCFGIVL( 974, 256, 5, 8,  8 );
  TEST_VSETCFGIVL( 975, 256, 5, 9,  8 );
  TEST_VSETCFGIVL( 976, 256, 5, 7,  7 );
                                
  TEST_VSETCFGIVL( 980, 256, 6, 8,  8 );
  TEST_VSETCFGIVL( 981, 256, 6, 9,  8 );
  TEST_VSETCFGIVL( 982, 256, 6, 7,  7 );
                                
  TEST_VSETCFGIVL( 986, 256, 7, 8,  8 );
  TEST_VSETCFGIVL( 987, 256, 7, 9,  8 );
  TEST_VSETCFGIVL( 988, 256, 7, 7,  7 );

  TEST_VSETCFGIVL( 992, 256, 8, 8,  8);
  TEST_VSETCFGIVL( 993, 256, 8, 9,  8);
  TEST_VSETCFGIVL( 994, 256, 8, 7,  7);
                                
  TEST_VSETCFGIVL( 998, 256, 9, 8,  8 );
  TEST_VSETCFGIVL( 999, 256, 9, 9,  8 );
  TEST_VSETCFGIVL( 1000, 256, 9, 7,  7 );
                                
  TEST_VSETCFGIVL( 1004, 256, 10, 8,  8  );
  TEST_VSETCFGIVL( 1005, 256, 10, 9,  8  );
  TEST_VSETCFGIVL( 1006, 256, 10, 7,  7  );
                                 
  TEST_VSETCFGIVL( 1010, 256, 11, 8,  8  );
  TEST_VSETCFGIVL( 1011, 256, 11, 9,  8  );
  TEST_VSETCFGIVL( 1012, 256, 11, 7,  7  );
                                 
  TEST_VSETCFGIVL( 1016, 256, 12, 8,  8  );
  TEST_VSETCFGIVL( 1017, 256, 12, 9,  8  );
  TEST_VSETCFGIVL( 1018, 256, 12, 7,  7  );
                                 
  TEST_VSETCFGIVL( 1022, 256, 13, 8,  8  );
  TEST_VSETCFGIVL( 1023, 256, 13, 9,  8  );
  TEST_VSETCFGIVL( 1024, 256, 13, 7,  7  );

  TEST_VSETCFGIVL( 1028, 256, 14, 8,  8  );
  TEST_VSETCFGIVL( 1029, 256, 14, 9,  8  );
  TEST_VSETCFGIVL( 1030, 256, 14, 7,  7  );
                                 
  TEST_VSETCFGIVL( 1034, 256, 15, 8,  8  );
  TEST_VSETCFGIVL( 1035, 256, 15, 9,  8  );
  TEST_VSETCFGIVL( 1036, 256, 15, 7,  7  );
                                 
  TEST_VSETCFGIVL( 1040, 256, 16, 8,  8  );
  TEST_VSETCFGIVL( 1041, 256, 16, 9,  8  );
  TEST_VSETCFGIVL( 1042, 256, 16, 7,  7  );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
