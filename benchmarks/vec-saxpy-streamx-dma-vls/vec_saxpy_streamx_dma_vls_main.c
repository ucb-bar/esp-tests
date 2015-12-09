// See LICENSE for license details.

//**************************************************************************
// Vector SAXPY benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_saxpy_streamx_dma_vls.h"
#include "vls-segments.h"
#include "dma-ext.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main

void fill_vls(void *data, int size)
{
  dma_set_cr(NSEGMENTS, 1);
  dma_set_cr(DST_STRIDE, 0);
  dma_set_cr(SRC_STRIDE, 0);
  dma_set_cr(SEGMENT_SIZE, size);

  dma_write_prefetch(data);
}

int main( int argc, char* argv[] )
{
  // Print the input array
  //printFloatArray("inputX", DATA_SIZE, input_data_X);
  //printFloatArray("inputY", DATA_SIZE, input_data_Y);
  //printFloatArray("verify", DATA_SIZE, verify_data);

  // Do the saxpy_streamx
  setStats(1);
  vlspin(input_data_Y, DATA_SIZE * sizeof(float));
  fill_vls(input_data_Y, DATA_SIZE * sizeof(float));
  for (int i = 0; i < NUM_STREAMS; i++) {
      vec_saxpy_streamx_c(DATA_SIZE, input_data_a, input_data_X_streams[i], input_data_Y);
  }
  setStats(0);

  // Print out the result
  printFloatArray("results", DATA_SIZE, input_data_Y);

  // Check the results
  return verifyFloat(DATA_SIZE, input_data_Y, verify_data);
}
