// See LICENSE for license details.

//**************************************************************************
// Large vector-vector add benchmark
//--------------------------------------------------------------------------
//
// This benchmark demonstrates the use of pointer indirection to access
// static data that lie beyond the 2 GiB address range permitted by the
// medium code models, as a workaround for the current lack of a large
// code model.
//
#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1-ptr.h"

//--------------------------------------------------------------------------
// vvadd function

void vvadd( int n, int a[], int b[], int c[] )
{
  int i;
  for ( i = 0; i < n; i++ )
    c[i] = a[i] + b[i];
}

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Do the vvadd
  setStats(1);
  vvadd( DATA_SIZE, input1_data_ptr, input2_data_ptr, results_data_ptr );
  setStats(0);

  // Check the results
  return verify( DATA_SIZE, results_data_ptr, verify_data_ptr );
}
