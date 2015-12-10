// See LICENSE for license details.

//**************************************************************************
// Vector SAXPY benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_histo_dma.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Do the histo
  setStats(1);
  vec_histo_dma(DATA_SIZE, NUM_BINS, DATA_MAX / NUM_BINS, input_data, output_bins);
  setStats(0);

  // Print out the result
  printArray("results", NUM_BINS, output_bins);

  // Check the results
  return verify(NUM_BINS, output_bins, verify_data);
}
