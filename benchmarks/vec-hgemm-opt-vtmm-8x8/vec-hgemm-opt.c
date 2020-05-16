// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7

#include <stdint.h>
#include "vec-util.h"

void vec_hgemm_opt_c(int n, uint16_t * result, uint16_t * A, uint16_t * B)
{
    asm volatile ("vsetcfg %0" : : "r" (VCFG(0, 0, 32, 16)));

    int vlen_result;
    asm volatile ("vsetvl %0, %1" : "=r" (vlen_result) : "r" (n));

    void * vpset_vfblockaddr;
    asm volatile ("la %0, hgemm_opt_v_8_8_vpset" : "=r" (vpset_vfblockaddr));
    asm volatile ("vf 0(%0)" : : "r" (vpset_vfblockaddr));

    void * first_vfblockaddr;
    void * last_vfblockaddr;
    void * pre_vfblockaddr;
    void * even_vfblockaddr;
    void * odd_vfblockaddr;
    void * post_vfblockaddr;
    asm volatile ("la %0, hgemm_opt_v_8_8_first"  : "=r" (first_vfblockaddr));
    asm volatile ("la %0, hgemm_opt_v_8_8_last"  : "=r" (last_vfblockaddr));
    asm volatile ("la %0, hgemm_opt_v_8_8_pre"  : "=r" (pre_vfblockaddr));
    asm volatile ("la %0, hgemm_opt_v_8_8_even" : "=r" (even_vfblockaddr));
    asm volatile ("la %0, hgemm_opt_v_8_8_odd"  : "=r" (odd_vfblockaddr));
    asm volatile ("la %0, hgemm_opt_v_8_8_post" : "=r" (post_vfblockaddr));

    asm volatile ("vmca va10, %0" : : "r" (n*sizeof(uint16_t)));
    asm volatile ("vmca va11, %0" : : "r" (n*sizeof(uint16_t)));
    asm volatile ("vmca va18, %0" : : "r" (n*sizeof(uint16_t)));
    for (int i = 0; i < n; i+=8) {
        for (int k = 0; k < n; ) {
            int consumed;
#ifdef ARTIFICAL_LIMIT
            int artificial = n-k < ARTIFICAL_LIMIT ? n-k : ARTIFICAL_LIMIT;
#else
            int artificial = n;
#endif
            asm volatile ("vsetvl %0, %1" : "=r" (consumed) : "r" (artificial));
            // C rows 1, 2, 3, 4, 5, 6, 7, 8
            asm volatile ("vmca va0, %0" : : "r" (&result[i*n+k]));
            asm volatile ("vmca va1, %0" : : "r" (&result[(i+4)*n+k]));
            // B row 1, 2, 3, 4, 5, 6, 7, 8
            asm volatile ("vmca va8,  %0" : : "r" (&B[0*n+k]));
            asm volatile ("vmca va9, %0" : : "r" (&B[(0+4)*n+k]));

            if (i == 0) {
              asm volatile ("vf 0(%0)" : : "r" (first_vfblockaddr));
            } else {
              asm volatile ("vf 0(%0)" : : "r" (pre_vfblockaddr));
            }

            for (int j = 0; j < n; j+=8) {
                // B row 1, 2, 3, 4, 5, 6, 7, 8
                if (j >= n-8) { 
                  asm volatile ("vmca va8,  %0" : : "r" (&B[(0)*n+k]));
                  asm volatile ("vmca va9, %0" : : "r" (&B[(0+4)*n+k]));
                } else {
                  asm volatile ("vmca va8,  %0" : : "r" (&B[(j+8)*n+k]));
                  asm volatile ("vmca va9, %0" : : "r" (&B[(j+12)*n+k]));
                }
                // A row 1, 2, 3, 4, 5, 6, 7, 8
                asm volatile ("vmca va16, %0" : : "r" (&A[j+i*n]));
                asm volatile ("vmca va17, %0" : : "r" (&A[j+(i+4)*n]));
                if (j/8 % 2 == 0) { 
                  asm volatile ("vf 0(%0)" : : "r" (even_vfblockaddr));
                } else {
                  if ( j >= n-8 && i >= n-8 ) {
                    asm volatile ("vf 0(%0)" : : "r" (last_vfblockaddr));
                  } else {
                    asm volatile ("vf 0(%0)" : : "r" (odd_vfblockaddr));
                  }
                }
            }
            asm volatile ("vf 0(%0)" : : "r" (post_vfblockaddr));
            k += consumed;
        }
    }
    asm volatile ("fence");
}
