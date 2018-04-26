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

//int main( int argc, char* argv[] )
void thread_entry(int cid, int nc)
{
  // Do the saxpy
  setStats(1);
  vec_dgemm_opt_multi_c(MAT_WIDTH, result_holder, input_data_X, input_data_Y, cid);
  
  barrier(nc);
  setStats(0);
  // Check the results
  if (cid == 0)
  {
    exit(verifyDouble(MAT_WIDTH*MAT_WIDTH, result_holder, verify_data));
  }
  exit(0);
}
