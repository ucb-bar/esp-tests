// See LICENSE for license details.

//**************************************************************************
// Vector DAXPY benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_daxpy.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Print the input array
  printDoubleArray("inputX", DATA_SIZE, input_data_X);
  printDoubleArray("inputY", DATA_SIZE, input_data_Y);
  printDoubleArray("verify", DATA_SIZE, verify_data);

  // Do the daxpy
  setStats(1);
  vec_daxpy_asm(DATA_SIZE, input_data_a, input_data_X, input_data_Y);
  setStats(0);

  // Print out the result
  printDoubleArray("results", DATA_SIZE, input_data_Y);

  // Check the results
  return verifyDouble(DATA_SIZE, input_data_Y, verify_data);
}
