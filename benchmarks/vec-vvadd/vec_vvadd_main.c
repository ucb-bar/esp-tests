// See LICENSE for license details.

//**************************************************************************
// Vector VVADD benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_vvadd.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{

  float result[DATA_SIZE];

  // Print the input array
  printFloatArray("inputX", DATA_SIZE, input_data_X);
  printFloatArray("inputY", DATA_SIZE, input_data_Y);
  printFloatArray("verify", DATA_SIZE, verify_data);

  // Do the saxpy
  setStats(1);
  vec_vvadd_asm(DATA_SIZE, result, input_data_X, input_data_Y);
  setStats(0);

  // Print out the result
  printFloatArray("results", DATA_SIZE, result);

  // Check the results
  return verifyFloat(DATA_SIZE, result, verify_data);
}
