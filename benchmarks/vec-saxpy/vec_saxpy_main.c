// See LICENSE for license details.

//**************************************************************************
// Vector SAXPY benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_saxpy.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Do the saxpy
  setStats(1);
  vec_saxpy_asm(DATA_SIZE, input_data_a, input_data_X, input_data_Y);
  setStats(0);

  // Check the results
  return verifyFloat(DATA_SIZE, input_data_Y, verify_data);
}
