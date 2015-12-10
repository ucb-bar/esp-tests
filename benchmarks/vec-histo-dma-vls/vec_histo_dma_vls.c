#include "vec-util.h"
#include "vec_histo_dma_vls.h"
#include "dma-ext.h"
#include "vls-segments.h"

extern char histo_v[];

static inline void vec_setup(int scale, void *output_bins)
{
  unsigned long cfg = VCFG(0, 2, 0, 1);
  asm volatile ("vsetcfg %[cfg]" :: [cfg] "r" (cfg));
  asm volatile ("vmcs vs1, %[scale]" :: [scale] "r" (scale));
  asm volatile ("vmcs vs2, %[shift]" :: [shift] "r" (2));
  asm volatile ("vmcs vs3, %[base]" :: [base] "r" (output_bins));
  asm volatile ("vmcs vs4, %[inc]" :: [inc] "r" (1));
}

static inline void dma_setup(void)
{
  dma_set_cr(NSEGMENTS, 1);
  dma_set_cr(DST_STRIDE, 0);
  dma_set_cr(SRC_STRIDE, 0);
}

static inline void dma_set_length(int len)
{
  dma_set_cr(SEGMENT_SIZE, len * sizeof(int));
}

void vec_histo_dma_vls(int n, int nbins, int scale, int *input_data, int *output_bins)
{
  int vl;

  vec_setup(scale, output_bins);
  dma_setup();

  vlspin(output_bins, nbins);
  dma_set_length(nbins);
  dma_write_prefetch(output_bins);

  while (n > 0) {
    asm volatile ("vsetvl %[vl], %[n]" : [vl] "=r" (vl) : [n] "r" (n));
    dma_set_length(vl);
    dma_read_prefetch(input_data);
    asm volatile ("vmca va0, %[input]" :: [input] "r" (input_data));
    asm volatile ("vf 0(%[addr])" :: [addr] "r" (histo_v));
    input_data += vl;
    n -= vl;
  }

  asm volatile ("fence");
}
