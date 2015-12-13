// See LICENSE for license details.

//**************************************************************************
// Vector Matrix Multiply Naive benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec-hgemm-opt.h"
#include<stdint.h>

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
   
  // Print the input array
//  printFloatArray("inputX", MAT_WIDTH*MAT_WIDTH, input_data_X);
//  printFloatArray("inputY", MAT_WIDTH*MAT_WIDTH, input_data_Y);
//  printFloatArray("verify", MAT_WIDTH*MAT_WIDTH, verify_data);

  // Do the saxpy
  setStats(1);
  vec_hgemm_opt_c(MAT_WIDTH, result_holder, input_data_X, input_data_Y);
  setStats(0);

  // Print out the result
//  printFloatArray("results", MAT_WIDTH*MAT_WIDTH, result_holder);

  // Check the results
  return verifyuint16_t(MAT_WIDTH*MAT_WIDTH, result_holder, verify_data);
}
