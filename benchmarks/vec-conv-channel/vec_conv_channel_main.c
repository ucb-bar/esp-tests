// See LICENSE for license details.

//**************************************************************************
// Vector multichannel convolution benchmark for Hwacha v4
//--------------------------------------------------------------------------
//

#include "util.h"
#include "vec_conv_channel.h"


//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

//--------------------------------------------------------------------------
// Main


int main( int argc, char* argv[] )
{

  setStats(1);
  channel_conv(input_src, input_kern, input_dest, SRCWIDTH, SRCHEIGHT, CHANNELS);
  setStats(0);


  return verifyFloat(DATA_SIZE, input_dest, verify_data);
}
