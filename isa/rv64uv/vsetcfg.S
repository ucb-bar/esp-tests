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
                          
  TEST_VVCFG( 200, 33, 1, 56, 56 );
  TEST_VVCFG( 201, 33, 1, 57, 56 );
  TEST_VVCFG( 202, 33, 1, 55, 55 );
                          
  TEST_VVCFG( 203, 34, 1, 56, 56 );
  TEST_VVCFG( 204, 34, 1, 57, 56 );
  TEST_VVCFG( 205, 34, 1, 55, 55 );
                          
  TEST_VVCFG( 206, 35, 1, 56, 56 );
  TEST_VVCFG( 207, 35, 1, 57, 56 );
  TEST_VVCFG( 208, 35, 1, 55, 55 );
                          
  TEST_VVCFG( 209, 36, 1, 56, 56 );
  TEST_VVCFG( 210, 36, 1, 57, 56 );
  TEST_VVCFG( 211, 36, 1, 55, 55 );
                          
  TEST_VVCFG( 212, 37, 1, 48, 48 );
  TEST_VVCFG( 213, 37, 1, 49, 48 );
  TEST_VVCFG( 214, 37, 1, 47, 47 );
                          
  TEST_VVCFG( 215, 38, 1, 48, 48 );
  TEST_VVCFG( 216, 38, 1, 49, 48 );
  TEST_VVCFG( 217, 38, 1, 47, 47 );
                          
  TEST_VVCFG( 218, 39, 1, 48, 48 );
  TEST_VVCFG( 219, 39, 1, 49, 48 );
  TEST_VVCFG( 220, 39, 1, 47, 47 );
                          
  TEST_VVCFG( 221, 40, 1, 48, 48 );
  TEST_VVCFG( 222, 40, 1, 49, 48 );
  TEST_VVCFG( 223, 40, 1, 47, 47 );
                          
  TEST_VVCFG( 224, 41, 1, 48, 48 );
  TEST_VVCFG( 225, 41, 1, 49, 48 );
  TEST_VVCFG( 226, 41, 1, 47, 47 );
                          
  TEST_VVCFG( 227, 42, 1, 48, 48 );
  TEST_VVCFG( 228, 42, 1, 49, 48 );
  TEST_VVCFG( 229, 42, 1, 47, 47 );
                          
  TEST_VVCFG( 230, 43, 1, 40, 40 );
  TEST_VVCFG( 231, 43, 1, 41, 40 );
  TEST_VVCFG( 232, 43, 1, 39, 39 );
                          
  TEST_VVCFG( 233, 44, 1, 40, 40 );
  TEST_VVCFG( 234, 44, 1, 41, 40 );
  TEST_VVCFG( 235, 44, 1, 39, 39 );
                          
  TEST_VVCFG( 236, 45, 1, 40, 40 );
  TEST_VVCFG( 237, 45, 1, 41, 40 );
  TEST_VVCFG( 238, 45, 1, 39, 39 );
                          
  TEST_VVCFG( 239, 46, 1, 40, 40 );
  TEST_VVCFG( 240, 46, 1, 41, 40 );
  TEST_VVCFG( 241, 46, 1, 39, 39 );
                          
  TEST_VVCFG( 242, 47, 1, 40, 40 );
  TEST_VVCFG( 243, 47, 1, 41, 40 );
  TEST_VVCFG( 244, 47, 1, 39, 39 );
                          
  TEST_VVCFG( 245, 48, 1, 40, 40 );
  TEST_VVCFG( 246, 48, 1, 41, 40 );
  TEST_VVCFG( 247, 48, 1, 39, 39 );
                          
  TEST_VVCFG( 248, 49, 1, 40, 40 );
  TEST_VVCFG( 249, 49, 1, 41, 40 );
  TEST_VVCFG( 250, 49, 1, 39, 39 );
                          
  TEST_VVCFG( 251, 50, 1, 40, 40 );
  TEST_VVCFG( 252, 50, 1, 41, 40 );
  TEST_VVCFG( 253, 50, 1, 39, 39 );
                          
  TEST_VVCFG( 254, 51, 1, 40, 40 );
  TEST_VVCFG( 255, 51, 1, 41, 40 );
  TEST_VVCFG( 256, 51, 1, 39, 39 );
                          
  TEST_VVCFG( 257, 52, 1, 32, 32 );
  TEST_VVCFG( 258, 52, 1, 33, 32 );
  TEST_VVCFG( 259, 52, 1, 31, 31 );
                          
  TEST_VVCFG( 260, 53, 1, 32, 32 );
  TEST_VVCFG( 261, 53, 1, 33, 32 );
  TEST_VVCFG( 262, 53, 1, 31, 31 );
                          
  TEST_VVCFG( 263, 54, 1, 32, 32 );
  TEST_VVCFG( 264, 54, 1, 33, 32 );
  TEST_VVCFG( 265, 54, 1, 31, 31 );
                          
  TEST_VVCFG( 266, 55, 1, 32, 32 );
  TEST_VVCFG( 267, 55, 1, 33, 32 );
  TEST_VVCFG( 268, 55, 1, 31, 31 );
                          
  TEST_VVCFG( 269, 56, 1, 32, 32 );
  TEST_VVCFG( 270, 56, 1, 33, 32 );
  TEST_VVCFG( 271, 56, 1, 31, 31 );
                          
  TEST_VVCFG( 272, 57, 1, 32, 32 );
  TEST_VVCFG( 273, 57, 1, 33, 32 );
  TEST_VVCFG( 274, 57, 1, 31, 31 );
                          
  TEST_VVCFG( 275, 58, 1, 32, 32 );
  TEST_VVCFG( 276, 58, 1, 33, 32 );
  TEST_VVCFG( 277, 58, 1, 31, 31 );
                          
  TEST_VVCFG( 278, 59, 1, 32, 32 );
  TEST_VVCFG( 279, 59, 1, 33, 32 );
  TEST_VVCFG( 280, 59, 1, 31, 31 );
                          
  TEST_VVCFG( 281, 60, 1, 32, 32 );
  TEST_VVCFG( 282, 60, 1, 33, 32 );
  TEST_VVCFG( 283, 60, 1, 31, 31 );
                          
  TEST_VVCFG( 284, 61, 1, 32, 32 );
  TEST_VVCFG( 285, 61, 1, 33, 32 );
  TEST_VVCFG( 286, 61, 1, 31, 31 );
                          
  TEST_VVCFG( 287, 62, 1, 32, 32 );
  TEST_VVCFG( 288, 62, 1, 33, 32 );
  TEST_VVCFG( 289, 62, 1, 31, 31 );
                          
  TEST_VVCFG( 290, 63, 1, 32, 32 );
  TEST_VVCFG( 291, 63, 1, 33, 32 );
  TEST_VVCFG( 292, 63, 1, 31, 31 );
                          
  TEST_VVCFG( 293, 64, 1, 32, 32 );
  TEST_VVCFG( 294, 64, 1, 33, 32 );
  TEST_VVCFG( 295, 64, 1, 31, 31 );
                          
  TEST_VVCFG( 296, 65, 1, 24, 24 );
  TEST_VVCFG( 297, 65, 1, 25, 24 );
  TEST_VVCFG( 298, 65, 1, 23, 23 );
                          
  TEST_VVCFG( 299, 66, 1, 24, 24 );
  TEST_VVCFG( 300, 66, 1, 25, 24 );
  TEST_VVCFG( 301, 66, 1, 23, 23 );
                          
  TEST_VVCFG( 302, 67, 1, 24, 24 );
  TEST_VVCFG( 303, 67, 1, 25, 24 );
  TEST_VVCFG( 304, 67, 1, 23, 23 );
                          
  TEST_VVCFG( 305, 68, 1, 24, 24 );
  TEST_VVCFG( 306, 68, 1, 25, 24 );
  TEST_VVCFG( 307, 68, 1, 23, 23 );
                          
  TEST_VVCFG( 308, 69, 1, 24, 24 );
  TEST_VVCFG( 309, 69, 1, 25, 24 );
  TEST_VVCFG( 310, 69, 1, 23, 23 );
                          
  TEST_VVCFG( 311, 70, 1, 24, 24 );
  TEST_VVCFG( 312, 70, 1, 25, 24 );
  TEST_VVCFG( 313, 70, 1, 23, 23 );
                          
  TEST_VVCFG( 314, 71, 1, 24, 24 );
  TEST_VVCFG( 315, 71, 1, 25, 24 );
  TEST_VVCFG( 316, 71, 1, 23, 23 );
                          
  TEST_VVCFG( 317, 72, 1, 24, 24 );
  TEST_VVCFG( 318, 72, 1, 25, 24 );
  TEST_VVCFG( 319, 72, 1, 23, 23 );
                          
  TEST_VVCFG( 320, 73, 1, 24, 24 );
  TEST_VVCFG( 321, 73, 1, 25, 24 );
  TEST_VVCFG( 322, 73, 1, 23, 23 );
                          
  TEST_VVCFG( 323, 74, 1, 24, 24 );
  TEST_VVCFG( 324, 74, 1, 25, 24 );
  TEST_VVCFG( 325, 74, 1, 23, 23 );
                          
  TEST_VVCFG( 326, 75, 1, 24, 24 );
  TEST_VVCFG( 327, 75, 1, 25, 24 );
  TEST_VVCFG( 328, 75, 1, 23, 23 );
                          
  TEST_VVCFG( 329, 76, 1, 24, 24 );
  TEST_VVCFG( 330, 76, 1, 25, 24 );
  TEST_VVCFG( 331, 76, 1, 23, 23 );
                          
  TEST_VVCFG( 332, 77, 1, 24, 24 );
  TEST_VVCFG( 333, 77, 1, 25, 24 );
  TEST_VVCFG( 334, 77, 1, 23, 23 );
                          
  TEST_VVCFG( 335, 78, 1, 24, 24 );
  TEST_VVCFG( 336, 78, 1, 25, 24 );
  TEST_VVCFG( 337, 78, 1, 23, 23 );
                          
  TEST_VVCFG( 338, 79, 1, 24, 24 );
  TEST_VVCFG( 339, 79, 1, 25, 24 );
  TEST_VVCFG( 340, 79, 1, 23, 23 );
                          
  TEST_VVCFG( 341, 80, 1, 24, 24 );
  TEST_VVCFG( 342, 80, 1, 25, 24 );
  TEST_VVCFG( 343, 80, 1, 23, 23 );
                          
  TEST_VVCFG( 344, 81, 1, 24, 24 );
  TEST_VVCFG( 345, 81, 1, 25, 24 );
  TEST_VVCFG( 346, 81, 1, 23, 23 );
                          
  TEST_VVCFG( 347, 82, 1, 24, 24 );
  TEST_VVCFG( 348, 82, 1, 25, 24 );
  TEST_VVCFG( 349, 82, 1, 23, 23 );
                          
  TEST_VVCFG( 350, 83, 1, 24, 24 );
  TEST_VVCFG( 351, 83, 1, 25, 24 );
  TEST_VVCFG( 352, 83, 1, 23, 23 );
                          
  TEST_VVCFG( 353, 84, 1, 24, 24 );
  TEST_VVCFG( 354, 84, 1, 25, 24 );
  TEST_VVCFG( 355, 84, 1, 23, 23 );
                          
  TEST_VVCFG( 356, 85, 1, 24, 24 );
  TEST_VVCFG( 357, 85, 1, 25, 24 );
  TEST_VVCFG( 358, 85, 1, 23, 23 );
                          
  TEST_VVCFG( 359, 86, 1, 16, 16 );
  TEST_VVCFG( 360, 86, 1, 17, 16 );
  TEST_VVCFG( 361, 86, 1, 15, 15 );
                          
  TEST_VVCFG( 362, 87, 1, 16, 16 );
  TEST_VVCFG( 363, 87, 1, 17, 16 );
  TEST_VVCFG( 364, 87, 1, 15, 15 );
                          
  TEST_VVCFG( 365, 88, 1, 16, 16 );
  TEST_VVCFG( 366, 88, 1, 17, 16 );
  TEST_VVCFG( 367, 88, 1, 15, 15 );
                          
  TEST_VVCFG( 368, 89, 1, 16, 16 );
  TEST_VVCFG( 369, 89, 1, 17, 16 );
  TEST_VVCFG( 370, 89, 1, 15, 15 );
                          
  TEST_VVCFG( 371, 90, 1, 16, 16 );
  TEST_VVCFG( 372, 90, 1, 17, 16 );
  TEST_VVCFG( 373, 90, 1, 15, 15 );
                          
  TEST_VVCFG( 374, 91, 1, 16, 16 );
  TEST_VVCFG( 375, 91, 1, 17, 16 );
  TEST_VVCFG( 376, 91, 1, 15, 15 );
                          
  TEST_VVCFG( 377, 92, 1, 16, 16 );
  TEST_VVCFG( 378, 92, 1, 17, 16 );
  TEST_VVCFG( 379, 92, 1, 15, 15 );
                          
  TEST_VVCFG( 380, 93, 1, 16, 16 );
  TEST_VVCFG( 381, 93, 1, 17, 16 );
  TEST_VVCFG( 382, 93, 1, 15, 15 );
                          
  TEST_VVCFG( 383, 94, 1, 16, 16 );
  TEST_VVCFG( 384, 94, 1, 17, 16 );
  TEST_VVCFG( 385, 94, 1, 15, 15 );
                          
  TEST_VVCFG( 386, 95, 1, 16, 16 );
  TEST_VVCFG( 387, 95, 1, 17, 16 );
  TEST_VVCFG( 388, 95, 1, 15, 15 );
                          
  TEST_VVCFG( 389, 96, 1, 16, 16 );
  TEST_VVCFG( 390, 96, 1, 17, 16 );
  TEST_VVCFG( 391, 96, 1, 15, 15 );
                          
  TEST_VVCFG( 392, 97, 1, 16, 16 );
  TEST_VVCFG( 393, 97, 1, 17, 16 );
  TEST_VVCFG( 394, 97, 1, 15, 15 );
                          
  TEST_VVCFG( 395, 98, 1, 16, 16 );
  TEST_VVCFG( 396, 98, 1, 17, 16 );
  TEST_VVCFG( 397, 98, 1, 15, 15 );
                          
  TEST_VVCFG( 398, 99, 1, 16, 16 );
  TEST_VVCFG( 399, 99, 1, 17, 16 );
  TEST_VVCFG( 400, 99, 1, 15, 15 );
                          
  TEST_VVCFG( 401, 100, 1,16, 16 );
  TEST_VVCFG( 402, 100, 1,17, 16 );
  TEST_VVCFG( 403, 100, 1,15, 15 );
                          
  TEST_VVCFG( 404, 101, 1,16, 16 );
  TEST_VVCFG( 405, 101, 1,17, 16 );
  TEST_VVCFG( 406, 101, 1,15, 15 );
                          
  TEST_VVCFG( 407, 102, 1,16, 16 );
  TEST_VVCFG( 408, 102, 1,17, 16 );
  TEST_VVCFG( 409, 102, 1,15, 15 );
                          
  TEST_VVCFG( 410, 103, 1,16, 16 );
  TEST_VVCFG( 411, 103, 1,17, 16 );
  TEST_VVCFG( 412, 103, 1,15, 15 );
                          
  TEST_VVCFG( 413, 104, 1,16, 16 );
  TEST_VVCFG( 414, 104, 1,17, 16 );
  TEST_VVCFG( 415, 104, 1,15, 15 );
                          
  TEST_VVCFG( 416, 105, 1,16, 16 );
  TEST_VVCFG( 417, 105, 1,17, 16 );
  TEST_VVCFG( 418, 105, 1,15, 15 );
                          
  TEST_VVCFG( 419, 106, 1,16, 16 );
  TEST_VVCFG( 420, 106, 1,17, 16 );
  TEST_VVCFG( 421, 106, 1,15, 15 );
                          
  TEST_VVCFG( 422, 107, 1,16, 16 );
  TEST_VVCFG( 423, 107, 1,17, 16 );
  TEST_VVCFG( 424, 107, 1,15, 15 );
                          
  TEST_VVCFG( 425, 108, 1,16, 16 );
  TEST_VVCFG( 426, 108, 1,17, 16 );
  TEST_VVCFG( 427, 108, 1,15, 15 );
                          
  TEST_VVCFG( 428, 109, 1,16, 16 );
  TEST_VVCFG( 429, 109, 1,17, 16 );
  TEST_VVCFG( 430, 109, 1,15, 15 );
                          
  TEST_VVCFG( 431, 110, 1,16, 16 );
  TEST_VVCFG( 432, 110, 1,17, 16 );
  TEST_VVCFG( 433, 110, 1,15, 15 );
                          
  TEST_VVCFG( 434, 111, 1,16, 16 );
  TEST_VVCFG( 435, 111, 1,17, 16 );
  TEST_VVCFG( 436, 111, 1,15, 15 );
                          
  TEST_VVCFG( 437, 112, 1,16, 16 );
  TEST_VVCFG( 438, 112, 1,17, 16 );
  TEST_VVCFG( 439, 112, 1,15, 15 );
                          
  TEST_VVCFG( 440, 113, 1,16, 16 );
  TEST_VVCFG( 441, 113, 1,17, 16 );
  TEST_VVCFG( 442, 113, 1,15, 15 );
                          
  TEST_VVCFG( 443, 114, 1,16, 16 );
  TEST_VVCFG( 444, 114, 1,17, 16 );
  TEST_VVCFG( 445, 114, 1,15, 15 );
                          
  TEST_VVCFG( 446, 115, 1,16, 16 );
  TEST_VVCFG( 447, 115, 1,17, 16 );
  TEST_VVCFG( 448, 115, 1,15, 15 );
                          
  TEST_VVCFG( 449, 116, 1,16, 16 );
  TEST_VVCFG( 450, 116, 1,17, 16 );
  TEST_VVCFG( 451, 116, 1,15, 15 );
                          
  TEST_VVCFG( 452, 117, 1,16, 16 );
  TEST_VVCFG( 453, 117, 1,17, 16 );
  TEST_VVCFG( 454, 117, 1,15, 15 );
                          
  TEST_VVCFG( 455, 118, 1,16, 16 );
  TEST_VVCFG( 456, 118, 1,17, 16 );
  TEST_VVCFG( 457, 118, 1,15, 15 );
                          
  TEST_VVCFG( 458, 119, 1,16, 16 );
  TEST_VVCFG( 459, 119, 1,17, 16 );
  TEST_VVCFG( 460, 119, 1,15, 15 );
                          
  TEST_VVCFG( 461, 120, 1,16, 16 );
  TEST_VVCFG( 462, 120, 1,17, 16 );
  TEST_VVCFG( 463, 120, 1,15, 15 );
                          
  TEST_VVCFG( 464, 121, 1,16, 16 );
  TEST_VVCFG( 465, 121, 1,17, 16 );
  TEST_VVCFG( 466, 121, 1,15, 15 );
                          
  TEST_VVCFG( 467, 122, 1,16, 16 );
  TEST_VVCFG( 468, 122, 1,17, 16 );
  TEST_VVCFG( 469, 122, 1,15, 15 );
                          
  TEST_VVCFG( 470, 123, 1,16, 16 );
  TEST_VVCFG( 471, 123, 1,17, 16 );
  TEST_VVCFG( 472, 123, 1,15, 15 );
                          
  TEST_VVCFG( 473, 124, 1,16, 16 );
  TEST_VVCFG( 474, 124, 1,17, 16 );
  TEST_VVCFG( 475, 124, 1,15, 15 );
                          
  TEST_VVCFG( 476, 125, 1,16, 16 );
  TEST_VVCFG( 477, 125, 1,17, 16 );
  TEST_VVCFG( 478, 125, 1,15, 15 );
                          
  TEST_VVCFG( 479, 126, 1,16, 16 );
  TEST_VVCFG( 480, 126, 1,17, 16 );
  TEST_VVCFG( 481, 126, 1,15, 15 );
                          
  TEST_VVCFG( 482, 127, 1,16, 16 );
  TEST_VVCFG( 483, 127, 1,17, 16 );
  TEST_VVCFG( 484, 127, 1,15, 15 );
                          
  TEST_VVCFG( 485, 128, 1,16, 16 );
  TEST_VVCFG( 486, 128, 1,17, 16 );
  TEST_VVCFG( 487, 128, 1,15, 15 );
                          
  TEST_VVCFG( 488, 129, 1, 8,  8 );
  TEST_VVCFG( 489, 129, 1, 9,  8 );
  TEST_VVCFG( 490, 129, 1, 7,  7 );
                          
  TEST_VVCFG( 491, 130, 1, 8,  8 );
  TEST_VVCFG( 492, 130, 1, 9,  8 );
  TEST_VVCFG( 493, 130, 1, 7,  7 );
                          
  TEST_VVCFG( 494, 131, 1, 8,  8 );
  TEST_VVCFG( 495, 131, 1, 9,  8 );
  TEST_VVCFG( 496, 131, 1, 7,  7 );
                          
  TEST_VVCFG( 497, 132, 1, 8,  8 );
  TEST_VVCFG( 498, 132, 1, 9,  8 );
  TEST_VVCFG( 499, 132, 1, 7,  7 );
                          
  TEST_VVCFG( 500, 133, 1, 8,  8 );
  TEST_VVCFG( 501, 133, 1, 9,  8 );
  TEST_VVCFG( 502, 133, 1, 7,  7 );
                          
  TEST_VVCFG( 503, 134, 1, 8,  8 );
  TEST_VVCFG( 504, 134, 1, 9,  8 );
  TEST_VVCFG( 505, 134, 1, 7,  7 );
                          
  TEST_VVCFG( 506, 135, 1, 8,  8 );
  TEST_VVCFG( 507, 135, 1, 9,  8 );
  TEST_VVCFG( 508, 135, 1, 7,  7 );
                          
  TEST_VVCFG( 509, 136, 1, 8,  8 );
  TEST_VVCFG( 510, 136, 1, 9,  8 );
  TEST_VVCFG( 511, 136, 1, 7,  7 );
                          
  TEST_VVCFG( 512, 137, 1, 8,  8 );
  TEST_VVCFG( 513, 137, 1, 9,  8 );
  TEST_VVCFG( 514, 137, 1, 7,  7 );
                          
  TEST_VVCFG( 515, 138, 1, 8,  8 );
  TEST_VVCFG( 516, 138, 1, 9,  8 );
  TEST_VVCFG( 517, 138, 1, 7,  7 );
                          
  TEST_VVCFG( 518, 139, 1, 8,  8 );
  TEST_VVCFG( 519, 139, 1, 9,  8 );
  TEST_VVCFG( 520, 139, 1, 7,  7 );
                          
  TEST_VVCFG( 521, 140, 1, 8,  8 );
  TEST_VVCFG( 522, 140, 1, 9,  8 );
  TEST_VVCFG( 523, 140, 1, 7,  7 );
                          
  TEST_VVCFG( 524, 141, 1, 8,  8 );
  TEST_VVCFG( 525, 141, 1, 9,  8 );
  TEST_VVCFG( 526, 141, 1, 7,  7 );
                          
  TEST_VVCFG( 527, 142, 1, 8,  8 );
  TEST_VVCFG( 528, 142, 1, 9,  8 );
  TEST_VVCFG( 529, 142, 1, 7,  7 );
                          
  TEST_VVCFG( 530, 143, 1, 8,  8 );
  TEST_VVCFG( 531, 143, 1, 9,  8 );
  TEST_VVCFG( 532, 143, 1, 7,  7 );
                          
  TEST_VVCFG( 533, 144, 1, 8,  8 );
  TEST_VVCFG( 534, 144, 1, 9,  8 );
  TEST_VVCFG( 535, 144, 1, 7,  7 );
                          
  TEST_VVCFG( 536, 145, 1, 8,  8 );
  TEST_VVCFG( 537, 145, 1, 9,  8 );
  TEST_VVCFG( 538, 145, 1, 7,  7 );
                          
  TEST_VVCFG( 539, 146, 1, 8,  8 );
  TEST_VVCFG( 540, 146, 1, 9,  8 );
  TEST_VVCFG( 541, 146, 1, 7,  7 );
                          
  TEST_VVCFG( 542, 147, 1, 8,  8 );
  TEST_VVCFG( 543, 147, 1, 9,  8 );
  TEST_VVCFG( 544, 147, 1, 7,  7 );
                          
  TEST_VVCFG( 545, 148, 1, 8,  8 );
  TEST_VVCFG( 546, 148, 1, 9,  8 );
  TEST_VVCFG( 547, 148, 1, 7,  7 );
                          
  TEST_VVCFG( 548, 149, 1, 8,  8 );
  TEST_VVCFG( 549, 149, 1, 9,  8 );
  TEST_VVCFG( 550, 149, 1, 7,  7 );
                          
  TEST_VVCFG( 551, 150, 1, 8,  8 );
  TEST_VVCFG( 552, 150, 1, 9,  8 );
  TEST_VVCFG( 553, 150, 1, 7,  7 );
                          
  TEST_VVCFG( 554, 151, 1, 8,  8 );
  TEST_VVCFG( 555, 151, 1, 9,  8 );
  TEST_VVCFG( 556, 151, 1, 7,  7 );
                          
  TEST_VVCFG( 557, 152, 1, 8,  8 );
  TEST_VVCFG( 558, 152, 1, 9,  8 );
  TEST_VVCFG( 559, 152, 1, 7,  7 );
                          
  TEST_VVCFG( 560, 153, 1, 8,  8 );
  TEST_VVCFG( 561, 153, 1, 9,  8 );
  TEST_VVCFG( 562, 153, 1, 7,  7 );
                          
  TEST_VVCFG( 563, 154, 1, 8,  8 );
  TEST_VVCFG( 564, 154, 1, 9,  8 );
  TEST_VVCFG( 565, 154, 1, 7,  7 );
                          
  TEST_VVCFG( 566, 155, 1, 8,  8 );
  TEST_VVCFG( 567, 155, 1, 9,  8 );
  TEST_VVCFG( 568, 155, 1, 7,  7 );
                          
  TEST_VVCFG( 569, 156, 1, 8,  8 );
  TEST_VVCFG( 570, 156, 1, 9,  8 );
  TEST_VVCFG( 571, 156, 1, 7,  7 );
                          
  TEST_VVCFG( 572, 157, 1, 8,  8 );
  TEST_VVCFG( 573, 157, 1, 9,  8 );
  TEST_VVCFG( 574, 157, 1, 7,  7 );
                          
  TEST_VVCFG( 575, 158, 1, 8,  8 );
  TEST_VVCFG( 576, 158, 1, 9,  8 );
  TEST_VVCFG( 577, 158, 1, 7,  7 );
                          
  TEST_VVCFG( 578, 159, 1, 8,  8 );
  TEST_VVCFG( 579, 159, 1, 9,  8 );
  TEST_VVCFG( 580, 159, 1, 7,  7 );
                          
  TEST_VVCFG( 581, 160, 1, 8,  8 );
  TEST_VVCFG( 582, 160, 1, 9,  8 );
  TEST_VVCFG( 583, 160, 1, 7,  7 );
                          
  TEST_VVCFG( 584, 161, 1, 8,  8 );
  TEST_VVCFG( 585, 161, 1, 9,  8 );
  TEST_VVCFG( 586, 161, 1, 7,  7 );
                          
  TEST_VVCFG( 587, 162, 1, 8,  8 );
  TEST_VVCFG( 588, 162, 1, 9,  8 );
  TEST_VVCFG( 589, 162, 1, 7,  7 );
                          
  TEST_VVCFG( 590, 163, 1, 8,  8 );
  TEST_VVCFG( 591, 163, 1, 9,  8 );
  TEST_VVCFG( 592, 163, 1, 7,  7 );
                          
  TEST_VVCFG( 593, 164, 1, 8,  8 );
  TEST_VVCFG( 594, 164, 1, 9,  8 );
  TEST_VVCFG( 595, 164, 1, 7,  7 );
                          
  TEST_VVCFG( 596, 165, 1, 8,  8 );
  TEST_VVCFG( 597, 165, 1, 9,  8 );
  TEST_VVCFG( 598, 165, 1, 7,  7 );
                          
  TEST_VVCFG( 599, 166, 1, 8,  8 );
  TEST_VVCFG( 600, 166, 1, 9,  8 );
  TEST_VVCFG( 601, 166, 1, 7,  7 );
                          
  TEST_VVCFG( 602, 167, 1, 8,  8 );
  TEST_VVCFG( 603, 167, 1, 9,  8 );
  TEST_VVCFG( 604, 167, 1, 7,  7 );
                          
  TEST_VVCFG( 605, 168, 1, 8,  8 );
  TEST_VVCFG( 606, 168, 1, 9,  8 );
  TEST_VVCFG( 607, 168, 1, 7,  7 );
                          
  TEST_VVCFG( 608, 169, 1, 8,  8 );
  TEST_VVCFG( 609, 169, 1, 9,  8 );
  TEST_VVCFG( 610, 169, 1, 7,  7 );
                          
  TEST_VVCFG( 611, 170, 1, 8,  8 );
  TEST_VVCFG( 612, 170, 1, 9,  8 );
  TEST_VVCFG( 613, 170, 1, 7,  7 );
                          
  TEST_VVCFG( 614, 171, 1, 8,  8 );
  TEST_VVCFG( 615, 171, 1, 9,  8 );
  TEST_VVCFG( 616, 171, 1, 7,  7 );
                          
  TEST_VVCFG( 617, 172, 1, 8,  8 );
  TEST_VVCFG( 618, 172, 1, 9,  8 );
  TEST_VVCFG( 619, 172, 1, 7,  7 );
                          
  TEST_VVCFG( 620, 173, 1, 8,  8 );
  TEST_VVCFG( 621, 173, 1, 9,  8 );
  TEST_VVCFG( 622, 173, 1, 7,  7 );
                          
  TEST_VVCFG( 623, 174, 1, 8,  8 );
  TEST_VVCFG( 624, 174, 1, 9,  8 );
  TEST_VVCFG( 625, 174, 1, 7,  7 );
                          
  TEST_VVCFG( 626, 175, 1, 8,  8 );
  TEST_VVCFG( 627, 175, 1, 9,  8 );
  TEST_VVCFG( 628, 175, 1, 7,  7 );
                          
  TEST_VVCFG( 629, 176, 1, 8,  8 );
  TEST_VVCFG( 630, 176, 1, 9,  8 );
  TEST_VVCFG( 631, 176, 1, 7,  7 );
                          
  TEST_VVCFG( 632, 177, 1, 8,  8 );
  TEST_VVCFG( 633, 177, 1, 9,  8 );
  TEST_VVCFG( 634, 177, 1, 7,  7 );
                          
  TEST_VVCFG( 635, 178, 1, 8,  8 );
  TEST_VVCFG( 636, 178, 1, 9,  8 );
  TEST_VVCFG( 637, 178, 1, 7,  7 );
                          
  TEST_VVCFG( 638, 179, 1, 8,  8 );
  TEST_VVCFG( 639, 179, 1, 9,  8 );
  TEST_VVCFG( 640, 179, 1, 7,  7 );
                          
  TEST_VVCFG( 641, 180, 1, 8,  8 );
  TEST_VVCFG( 642, 180, 1, 9,  8 );
  TEST_VVCFG( 643, 180, 1, 7,  7 );
                          
  TEST_VVCFG( 644, 181, 1, 8,  8 );
  TEST_VVCFG( 645, 181, 1, 9,  8 );
  TEST_VVCFG( 646, 181, 1, 7,  7 );
                          
  TEST_VVCFG( 647, 182, 1, 8,  8 );
  TEST_VVCFG( 648, 182, 1, 9,  8 );
  TEST_VVCFG( 649, 182, 1, 7,  7 );
                          
  TEST_VVCFG( 650, 183, 1, 8,  8 );
  TEST_VVCFG( 651, 183, 1, 9,  8 );
  TEST_VVCFG( 652, 183, 1, 7,  7 );
                          
  TEST_VVCFG( 653, 184, 1, 8,  8 );
  TEST_VVCFG( 654, 184, 1, 9,  8 );
  TEST_VVCFG( 655, 184, 1, 7,  7 );
                          
  TEST_VVCFG( 656, 185, 1, 8,  8 );
  TEST_VVCFG( 657, 185, 1, 9,  8 );
  TEST_VVCFG( 658, 185, 1, 7,  7 );
                          
  TEST_VVCFG( 659, 186, 1, 8,  8 );
  TEST_VVCFG( 660, 186, 1, 9,  8 );
  TEST_VVCFG( 661, 186, 1, 7,  7 );
                          
  TEST_VVCFG( 662, 187, 1, 8,  8 );
  TEST_VVCFG( 663, 187, 1, 9,  8 );
  TEST_VVCFG( 664, 187, 1, 7,  7 );
                          
  TEST_VVCFG( 665, 188, 1, 8,  8 );
  TEST_VVCFG( 666, 188, 1, 9,  8 );
  TEST_VVCFG( 667, 188, 1, 7,  7 );
                          
  TEST_VVCFG( 668, 189, 1, 8,  8 );
  TEST_VVCFG( 669, 189, 1, 9,  8 );
  TEST_VVCFG( 670, 189, 1, 7,  7 );
                          
  TEST_VVCFG( 671, 190, 1, 8,  8 );
  TEST_VVCFG( 672, 190, 1, 9,  8 );
  TEST_VVCFG( 673, 190, 1, 7,  7 );
                          
  TEST_VVCFG( 674, 191, 1, 8,  8 );
  TEST_VVCFG( 675, 191, 1, 9,  8 );
  TEST_VVCFG( 676, 191, 1, 7,  7 );
                          
  TEST_VVCFG( 677, 192, 1, 8,  8 );
  TEST_VVCFG( 678, 192, 1, 9,  8 );
  TEST_VVCFG( 679, 192, 1, 7,  7 );
                          
  TEST_VVCFG( 680, 193, 1, 8,  8 );
  TEST_VVCFG( 681, 193, 1, 9,  8 );
  TEST_VVCFG( 682, 193, 1, 7,  7 );
                          
  TEST_VVCFG( 683, 194, 1, 8,  8 );
  TEST_VVCFG( 684, 194, 1, 9,  8 );
  TEST_VVCFG( 685, 194, 1, 7,  7 );
                          
  TEST_VVCFG( 686, 195, 1, 8,  8 );
  TEST_VVCFG( 687, 195, 1, 9,  8 );
  TEST_VVCFG( 688, 195, 1, 7,  7 );
                          
  TEST_VVCFG( 689, 196, 1, 8,  8 );
  TEST_VVCFG( 690, 196, 1, 9,  8 );
  TEST_VVCFG( 691, 196, 1, 7,  7 );
                          
  TEST_VVCFG( 692, 197, 1, 8,  8 );
  TEST_VVCFG( 693, 197, 1, 9,  8 );
  TEST_VVCFG( 694, 197, 1, 7,  7 );
                          
  TEST_VVCFG( 695, 198, 1, 8,  8 );
  TEST_VVCFG( 696, 198, 1, 9,  8 );
  TEST_VVCFG( 697, 198, 1, 7,  7 );
                          
  TEST_VVCFG( 698, 199, 1, 8,  8 );
  TEST_VVCFG( 699, 199, 1, 9,  8 );
  TEST_VVCFG( 700, 199, 1, 7,  7 );
                          
  TEST_VVCFG( 701, 200, 1, 8,  8 );
  TEST_VVCFG( 702, 200, 1, 9,  8 );
  TEST_VVCFG( 703, 200, 1, 7,  7 );
                          
  TEST_VVCFG( 704, 201, 1, 8,  8 );
  TEST_VVCFG( 705, 201, 1, 9,  8 );
  TEST_VVCFG( 706, 201, 1, 7,  7 );
                          
  TEST_VVCFG( 707, 202, 1, 8,  8 );
  TEST_VVCFG( 708, 202, 1, 9,  8 );
  TEST_VVCFG( 709, 202, 1, 7,  7 );
                          
  TEST_VVCFG( 710, 203, 1, 8,  8 );
  TEST_VVCFG( 711, 203, 1, 9,  8 );
  TEST_VVCFG( 712, 203, 1, 7,  7 );
                          
  TEST_VVCFG( 713, 204, 1, 8,  8 );
  TEST_VVCFG( 714, 204, 1, 9,  8 );
  TEST_VVCFG( 715, 204, 1, 7,  7 );
                          
  TEST_VVCFG( 716, 205, 1, 8,  8 );
  TEST_VVCFG( 717, 205, 1, 9,  8 );
  TEST_VVCFG( 718, 205, 1, 7,  7 );
                          
  TEST_VVCFG( 719, 206, 1, 8,  8 );
  TEST_VVCFG( 720, 206, 1, 9,  8 );
  TEST_VVCFG( 721, 206, 1, 7,  7 );
                          
  TEST_VVCFG( 722, 207, 1, 8,  8 );
  TEST_VVCFG( 723, 207, 1, 9,  8 );
  TEST_VVCFG( 724, 207, 1, 7,  7 );
                          
  TEST_VVCFG( 725, 208, 1, 8,  8 );
  TEST_VVCFG( 726, 208, 1, 9,  8 );
  TEST_VVCFG( 727, 208, 1, 7,  7 );
                          
  TEST_VVCFG( 728, 209, 1, 8,  8 );
  TEST_VVCFG( 729, 209, 1, 9,  8 );
  TEST_VVCFG( 730, 209, 1, 7,  7 );
                          
  TEST_VVCFG( 731, 210, 1, 8,  8 );
  TEST_VVCFG( 732, 210, 1, 9,  8 );
  TEST_VVCFG( 733, 210, 1, 7,  7 );
                          
  TEST_VVCFG( 734, 211, 1, 8,  8 );
  TEST_VVCFG( 735, 211, 1, 9,  8 );
  TEST_VVCFG( 736, 211, 1, 7,  7 );
                          
  TEST_VVCFG( 737, 212, 1, 8,  8 );
  TEST_VVCFG( 738, 212, 1, 9,  8 );
  TEST_VVCFG( 739, 212, 1, 7,  7 );
                          
  TEST_VVCFG( 740, 213, 1, 8,  8 );
  TEST_VVCFG( 741, 213, 1, 9,  8 );
  TEST_VVCFG( 742, 213, 1, 7,  7 );
                          
  TEST_VVCFG( 743, 214, 1, 8,  8 );
  TEST_VVCFG( 744, 214, 1, 9,  8 );
  TEST_VVCFG( 745, 214, 1, 7,  7 );
                          
  TEST_VVCFG( 746, 215, 1, 8,  8 );
  TEST_VVCFG( 747, 215, 1, 9,  8 );
  TEST_VVCFG( 748, 215, 1, 7,  7 );
                          
  TEST_VVCFG( 749, 216, 1, 8,  8 );
  TEST_VVCFG( 750, 216, 1, 9,  8 );
  TEST_VVCFG( 751, 216, 1, 7,  7 );
                          
  TEST_VVCFG( 752, 217, 1, 8,  8 );
  TEST_VVCFG( 753, 217, 1, 9,  8 );
  TEST_VVCFG( 754, 217, 1, 7,  7 );
                          
  TEST_VVCFG( 755, 218, 1, 8,  8 );
  TEST_VVCFG( 756, 218, 1, 9,  8 );
  TEST_VVCFG( 757, 218, 1, 7,  7 );
                          
  TEST_VVCFG( 758, 219, 1, 8,  8 );
  TEST_VVCFG( 759, 219, 1, 9,  8 );
  TEST_VVCFG( 760, 219, 1, 7,  7 );
                          
  TEST_VVCFG( 761, 220, 1, 8,  8 );
  TEST_VVCFG( 762, 220, 1, 9,  8 );
  TEST_VVCFG( 763, 220, 1, 7,  7 );
                          
  TEST_VVCFG( 764, 221, 1, 8,  8 );
  TEST_VVCFG( 765, 221, 1, 9,  8 );
  TEST_VVCFG( 766, 221, 1, 7,  7 );
                          
  TEST_VVCFG( 767, 222, 1, 8,  8 );
  TEST_VVCFG( 768, 222, 1, 9,  8 );
  TEST_VVCFG( 769, 222, 1, 7,  7 );
                          
  TEST_VVCFG( 770, 223, 1, 8,  8 );
  TEST_VVCFG( 771, 223, 1, 9,  8 );
  TEST_VVCFG( 772, 223, 1, 7,  7 );
                          
  TEST_VVCFG( 773, 224, 1, 8,  8 );
  TEST_VVCFG( 774, 224, 1, 9,  8 );
  TEST_VVCFG( 775, 224, 1, 7,  7 );
                          
  TEST_VVCFG( 776, 225, 1, 8,  8 );
  TEST_VVCFG( 777, 225, 1, 9,  8 );
  TEST_VVCFG( 778, 225, 1, 7,  7 );
                          
  TEST_VVCFG( 779, 226, 1, 8,  8 );
  TEST_VVCFG( 780, 226, 1, 9,  8 );
  TEST_VVCFG( 781, 226, 1, 7,  7 );
                          
  TEST_VVCFG( 782, 227, 1, 8,  8 );
  TEST_VVCFG( 783, 227, 1, 9,  8 );
  TEST_VVCFG( 784, 227, 1, 7,  7 );
                          
  TEST_VVCFG( 785, 228, 1, 8,  8 );
  TEST_VVCFG( 786, 228, 1, 9,  8 );
  TEST_VVCFG( 787, 228, 1, 7,  7 );
                          
  TEST_VVCFG( 788, 229, 1, 8,  8 );
  TEST_VVCFG( 789, 229, 1, 9,  8 );
  TEST_VVCFG( 790, 229, 1, 7,  7 );
                          
  TEST_VVCFG( 791, 230, 1, 8,  8 );
  TEST_VVCFG( 792, 230, 1, 9,  8 );
  TEST_VVCFG( 793, 230, 1, 7,  7 );
                          
  TEST_VVCFG( 794, 231, 1, 8,  8 );
  TEST_VVCFG( 795, 231, 1, 9,  8 );
  TEST_VVCFG( 796, 231, 1, 7,  7 );
                          
  TEST_VVCFG( 797, 232, 1, 8,  8 );
  TEST_VVCFG( 798, 232, 1, 9,  8 );
  TEST_VVCFG( 799, 232, 1, 7,  7 );
                          
  TEST_VVCFG( 800, 233, 1, 8,  8 );
  TEST_VVCFG( 801, 233, 1, 9,  8 );
  TEST_VVCFG( 802, 233, 1, 7,  7 );
                          
  TEST_VVCFG( 803, 234, 1, 8,  8 );
  TEST_VVCFG( 804, 234, 1, 9,  8 );
  TEST_VVCFG( 805, 234, 1, 7,  7 );
                          
  TEST_VVCFG( 806, 235, 1, 8,  8 );
  TEST_VVCFG( 807, 235, 1, 9,  8 );
  TEST_VVCFG( 808, 235, 1, 7,  7 );
                          
  TEST_VVCFG( 809, 236, 1, 8,  8 );
  TEST_VVCFG( 810, 236, 1, 9,  8 );
  TEST_VVCFG( 811, 236, 1, 7,  7 );
                          
  TEST_VVCFG( 812, 237, 1, 8,  8 );
  TEST_VVCFG( 813, 237, 1, 9,  8 );
  TEST_VVCFG( 814, 237, 1, 7,  7 );
                          
  TEST_VVCFG( 815, 238, 1, 8,  8 );
  TEST_VVCFG( 816, 238, 1, 9,  8 );
  TEST_VVCFG( 817, 238, 1, 7,  7 );
                          
  TEST_VVCFG( 818, 239, 1, 8,  8 );
  TEST_VVCFG( 819, 239, 1, 9,  8 );
  TEST_VVCFG( 820, 239, 1, 7,  7 );
                          
  TEST_VVCFG( 821, 240, 1, 8,  8 );
  TEST_VVCFG( 822, 240, 1, 9,  8 );
  TEST_VVCFG( 823, 240, 1, 7,  7 );
                          
  TEST_VVCFG( 824, 241, 1, 8,  8 );
  TEST_VVCFG( 825, 241, 1, 9,  8 );
  TEST_VVCFG( 826, 241, 1, 7,  7 );
                          
  TEST_VVCFG( 827, 242, 1, 8,  8 );
  TEST_VVCFG( 828, 242, 1, 9,  8 );
  TEST_VVCFG( 829, 242, 1, 7,  7 );
                          
  TEST_VVCFG( 830, 243, 1, 8,  8 );
  TEST_VVCFG( 831, 243, 1, 9,  8 );
  TEST_VVCFG( 832, 243, 1, 7,  7 );
                          
  TEST_VVCFG( 833, 244, 1, 8,  8 );
  TEST_VVCFG( 834, 244, 1, 9,  8 );
  TEST_VVCFG( 835, 244, 1, 7,  7 );
                          
  TEST_VVCFG( 836, 245, 1, 8,  8 );
  TEST_VVCFG( 837, 245, 1, 9,  8 );
  TEST_VVCFG( 838, 245, 1, 7,  7 );
                          
  TEST_VVCFG( 839, 246, 1, 8,  8 );
  TEST_VVCFG( 840, 246, 1, 9,  8 );
  TEST_VVCFG( 841, 246, 1, 7,  7 );
                          
  TEST_VVCFG( 842, 247, 1, 8,  8 );
  TEST_VVCFG( 843, 247, 1, 9,  8 );
  TEST_VVCFG( 844, 247, 1, 7,  7 );
                          
  TEST_VVCFG( 845, 248, 1, 8,  8 );
  TEST_VVCFG( 846, 248, 1, 9,  8 );
  TEST_VVCFG( 847, 248, 1, 7,  7 );
                          
  TEST_VVCFG( 848, 249, 1, 8,  8 );
  TEST_VVCFG( 849, 249, 1, 9,  8 );
  TEST_VVCFG( 850, 249, 1, 7,  7 );
                          
  TEST_VVCFG( 851, 250, 1, 8,  8 );
  TEST_VVCFG( 852, 250, 1, 9,  8 );
  TEST_VVCFG( 853, 250, 1, 7,  7 );
                          
  TEST_VVCFG( 854, 251, 1, 8,  8 );
  TEST_VVCFG( 855, 251, 1, 9,  8 );
  TEST_VVCFG( 856, 251, 1, 7,  7 );
                          
  TEST_VVCFG( 857, 252, 1, 8,  8 );
  TEST_VVCFG( 858, 252, 1, 9,  8 );
  TEST_VVCFG( 859, 252, 1, 7,  7 );
                          
  TEST_VVCFG( 860, 253, 1, 8,  8 );
  TEST_VVCFG( 861, 253, 1, 9,  8 );
  TEST_VVCFG( 862, 253, 1, 7,  7 );
                          
  TEST_VVCFG( 863, 254, 1, 8,  8 );
  TEST_VVCFG( 864, 254, 1, 9,  8 );
  TEST_VVCFG( 865, 254, 1, 7,  7 );
                          
  TEST_VVCFG( 866, 255, 1, 8,  8 );
  TEST_VVCFG( 867, 255, 1, 9,  8 );
  TEST_VVCFG( 868, 255, 1, 7,  7 );

  TEST_VVCFG( 869, 32, 2, 64, 64 );
  TEST_VVCFG( 870, 32, 2, 65, 64 );
  TEST_VVCFG( 871, 32, 2, 63, 63 );

  TEST_VVCFG( 875, 32, 3, 64, 64 );
  TEST_VVCFG( 876, 32, 3, 65, 64 );
  TEST_VVCFG( 877, 32, 3, 63, 63 );

  TEST_VVCFG( 881, 32, 4, 64, 64 );
  TEST_VVCFG( 882, 32, 4, 65, 64 );
  TEST_VVCFG( 883, 32, 4, 63, 63 );

  TEST_VVCFG( 887, 32, 5, 64, 64 );
  TEST_VVCFG( 888, 32, 5, 65, 64 );
  TEST_VVCFG( 889, 32, 5, 63, 63 );

  TEST_VVCFG( 893, 32, 6, 64, 64 );
  TEST_VVCFG( 894, 32, 6, 65, 64 );
  TEST_VVCFG( 895, 32, 6, 63, 63 );

  TEST_VVCFG( 899, 32, 7, 64, 64 );
  TEST_VVCFG( 900, 32, 7, 65, 64 );
  TEST_VVCFG( 901, 32, 7, 63, 63 );

  TEST_VVCFG( 905, 32, 8, 64, 64 );
  TEST_VVCFG( 906, 32, 8, 65, 64 );
  TEST_VVCFG( 907, 32, 8, 63, 63 );

  TEST_VVCFG( 911, 32, 9, 64, 64  );
  TEST_VVCFG( 912, 32, 9, 65, 64  );
  TEST_VVCFG( 913, 32, 9, 63, 63  );

  TEST_VVCFG( 917, 32, 10, 64, 64  );
  TEST_VVCFG( 918, 32, 10, 65, 64  );
  TEST_VVCFG( 919, 32, 10, 63, 63  );

  TEST_VVCFG( 923, 32, 11, 64, 64  );
  TEST_VVCFG( 924, 32, 11, 65, 64  );
  TEST_VVCFG( 925, 32, 11, 63, 63  );

  TEST_VVCFG( 929, 32, 12, 64, 64  );
  TEST_VVCFG( 930, 32, 12, 65, 64  );
  TEST_VVCFG( 931, 32, 12, 63, 63  );

  TEST_VVCFG( 935, 32, 13, 64, 64  );
  TEST_VVCFG( 936, 32, 13, 65, 64  );
  TEST_VVCFG( 937, 32, 13, 63, 63  );

  TEST_VVCFG( 941, 32, 14, 64, 64  );
  TEST_VVCFG( 942, 32, 14, 65, 64  );
  TEST_VVCFG( 943, 32, 14, 63, 63  );

  TEST_VVCFG( 947, 32, 15, 64, 64  );
  TEST_VVCFG( 948, 32, 15, 65, 64  );
  TEST_VVCFG( 949, 32, 15, 63, 63  );

  TEST_VVCFG( 953, 32, 16, 64, 64  );
  TEST_VVCFG( 954, 32, 16, 65, 64  );
  TEST_VVCFG( 955, 32, 16, 63, 63  );

  TEST_VVCFG( 956, 256, 2, 8,  8 );
  TEST_VVCFG( 957, 256, 2, 9,  8 );
  TEST_VVCFG( 958, 256, 2, 7,  7 );

  TEST_VVCFG( 962, 256, 3, 8,  8  );
  TEST_VVCFG( 963, 256, 3, 9,  8  );
  TEST_VVCFG( 964, 256, 3, 7,  7  );

  TEST_VVCFG( 968, 256, 4, 8,  8 );
  TEST_VVCFG( 969, 256, 4, 9,  8 );
  TEST_VVCFG( 970, 256, 4, 7,  7 );

  TEST_VVCFG( 974, 256, 5, 8,  8 );
  TEST_VVCFG( 975, 256, 5, 9,  8 );
  TEST_VVCFG( 976, 256, 5, 7,  7 );
                                
  TEST_VVCFG( 980, 256, 6, 8,  8 );
  TEST_VVCFG( 981, 256, 6, 9,  8 );
  TEST_VVCFG( 982, 256, 6, 7,  7 );
                                
  TEST_VVCFG( 986, 256, 7, 8,  8 );
  TEST_VVCFG( 987, 256, 7, 9,  8 );
  TEST_VVCFG( 988, 256, 7, 7,  7 );

  TEST_VVCFG( 992, 256, 8, 8,  8);
  TEST_VVCFG( 993, 256, 8, 9,  8);
  TEST_VVCFG( 994, 256, 8, 7,  7);
                                
  TEST_VVCFG( 998, 256, 9, 8,  8 );
  TEST_VVCFG( 999, 256, 9, 9,  8 );
  TEST_VVCFG( 1000, 256, 9, 7,  7 );
                                
  TEST_VVCFG( 1004, 256, 10, 8,  8  );
  TEST_VVCFG( 1005, 256, 10, 9,  8  );
  TEST_VVCFG( 1006, 256, 10, 7,  7  );
                                 
  TEST_VVCFG( 1010, 256, 11, 8,  8  );
  TEST_VVCFG( 1011, 256, 11, 9,  8  );
  TEST_VVCFG( 1012, 256, 11, 7,  7  );
                                 
  TEST_VVCFG( 1016, 256, 12, 8,  8  );
  TEST_VVCFG( 1017, 256, 12, 9,  8  );
  TEST_VVCFG( 1018, 256, 12, 7,  7  );
                                 
  TEST_VVCFG( 1022, 256, 13, 8,  8  );
  TEST_VVCFG( 1023, 256, 13, 9,  8  );
  TEST_VVCFG( 1024, 256, 13, 7,  7  );

  TEST_VVCFG( 1028, 256, 14, 8,  8  );
  TEST_VVCFG( 1029, 256, 14, 9,  8  );
  TEST_VVCFG( 1030, 256, 14, 7,  7  );
                                 
  TEST_VVCFG( 1034, 256, 15, 8,  8  );
  TEST_VVCFG( 1035, 256, 15, 9,  8  );
  TEST_VVCFG( 1036, 256, 15, 7,  7  );
                                 
  TEST_VVCFG( 1040, 256, 16, 8,  8  );
  TEST_VVCFG( 1041, 256, 16, 9,  8  );
  TEST_VVCFG( 1042, 256, 16, 7,  7  );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
