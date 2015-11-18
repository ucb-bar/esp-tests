// See LICENSE for license details.

//**************************************************************************
// Vector Matrix Multiply Naive benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec-mm-naive.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
   
  float result[MAT_WIDTH*MAT_WIDTH] = {0, 0, 0, 0};

  // Print the input array
  printFloatArray("inputX", MAT_WIDTH*MAT_WIDTH, input_data_X);
  printFloatArray("inputY", MAT_WIDTH*MAT_WIDTH, input_data_Y);
  printFloatArray("verify", MAT_WIDTH*MAT_WIDTH, verify_data);

  // Do the saxpy
  setStats(1);
//  vec_mm_naive_asm(MAT_WIDTH, result, input_data_X, input_data_Y);
  vec_mm_naive_c(MAT_WIDTH, result, input_data_X, input_data_Y);
  setStats(0);

  // Print out the result
  printFloatArray("results", MAT_WIDTH, result);

  // Check the results
  return verifyFloat(MAT_WIDTH, result, verify_data);
}
