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
  // Do the daxpy
  setStats(1);
  vec_daxpy_asm(DATA_SIZE, input_data_a, input_data_X, input_data_Y);
  setStats(0);

  // Check the results
  return verifyDouble(DATA_SIZE, input_data_Y, verify_data);
}
