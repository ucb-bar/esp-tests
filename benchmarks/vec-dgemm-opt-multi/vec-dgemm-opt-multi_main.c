// See LICENSE for license details.

//**************************************************************************
// Vector Matrix Multiply Naive benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec-dgemm-opt-multi.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

extern void __attribute__((noinline)) vec_dgemm_opt_multi_c(int n, double * result, double * A, double * B, int cid, int nc);

//--------------------------------------------------------------------------
// Main

//int main( int argc, char* argv[] )
void thread_entry(int cid, int nc)
{
  // Do the saxpy
  setStats(1);
  vec_dgemm_opt_multi_c(MAT_WIDTH, result_holder, input_data_X, input_data_Y, cid, nc);
  
  barrier(nc);
  setStats(0);
  // Check the results
  if (cid == 0)
  {
    exit(verifyDouble(MAT_WIDTH*MAT_WIDTH, result_holder, verify_data));
  }
  exit(0);
}
