// See LICENSE for license details.

//**************************************************************************
// Vector Matrix Multiply Naive benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec-dgemm-opt.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Do the saxpy
  setStats(1);
  vec_dgemm_opt_c(MAT_WIDTH, result_holder, input_data_X, input_data_Y);
  setStats(0);

  // Check the results
  return verifyDouble(MAT_WIDTH*MAT_WIDTH, result_holder, verify_data);
}
