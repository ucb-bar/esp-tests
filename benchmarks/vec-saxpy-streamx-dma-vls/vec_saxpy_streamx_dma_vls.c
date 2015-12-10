// See LICENSE for license details.

//**************************************************************************
// Repeated saxpy (c version)
//--------------------------------------------------------------------------

#include "vec_saxpy_streamx.h"
#include "dma-ext.h"
#include "vec-util.h"

#define min(a, b) (((a) < (b)) ? (a) : (b))

#define PREFETCH_LOOKAHEAD 16

extern char saxpy_streamx_v[];

static inline int vsetvl(int n)
{
  int vl;
  asm volatile ("vsetvl %[vl], %[n]" : [vl] "=r" (vl) : [n] "r" (n));
  return vl;
}

static inline void saxpy_setup(float a, int n)
{
  int vl;
  unsigned long cfg = VCFG(0, 2, 0, 1);

  asm volatile ("vsetcfg %[cfg]" :: [cfg] "r" (cfg));
  asm volatile ("vmcs vs1, %[a]" :: [a] "r" (a));

  vl = vsetvl(n);
  dma_set_cr(NSEGMENTS, 1);
  dma_set_cr(DST_STRIDE, 0);
  dma_set_cr(SRC_STRIDE, 0);
  dma_set_cr(SEGMENT_SIZE, vl * sizeof(float));
}

static inline void do_saxpy_block(float *x, float *y, int n, int vl)
{
  if (vl < n) {
    dma_read_prefetch(x + vl);
  }
  asm volatile ("vmca va0, %[x]" :: [x] "r" (x));
  asm volatile ("vmca va1, %[y]" :: [y] "r" (y));
  asm volatile ("vf 0(%[start])" :: [start] "r" (saxpy_streamx_v));
}

void vec_saxpy_streamx_c( int n, float a, float *input_X, float *inout_Y )
{
  int vl;

  saxpy_setup(a, n);

  while (n > 0) {
    vl = vsetvl(n);
    do_saxpy_block(input_X, inout_Y, n, vl);
    input_X += vl;
    inout_Y += vl;
    n -= vl;
  }
  asm volatile ("fence");
}
