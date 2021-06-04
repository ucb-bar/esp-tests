// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7

#include "vec-util.h"

#include<stdint.h>

void vec_hsgemm_opt_c(int n, uint16_t * result, uint16_t * A, uint16_t * B) {

    asm volatile ("vsetcfg %0"
                    :
                    : "r" (VCFG(0, 20, 1, 1)));


    for (int i = 0; i < n; i+=4) {
        for (int k = 0; k < n; ) {
            int consumed;
#ifdef ARTIFICAL_LIMIT
            int artificial = n-k < ARTIFICAL_LIMIT ? n-k : ARTIFICAL_LIMIT;
#else
            int artificial = n;
#endif

            asm volatile ("vsetvl %0, %1"
                    : "=r" (consumed)
                    : "r" (artificial));

            // C rows 1, 2, 3, 4
            asm volatile ("vmca va2, %0"
                    : 
                    : "r" (&result[i*n+k]));
            asm volatile ("vmca va4, %0"
                    : 
                    : "r" (&result[(i+1)*n+k]));
            asm volatile ("vmca va6, %0"
                    : 
                    : "r" (&result[(i+2)*n+k]));
            asm volatile ("vmca va8, %0"
                    : 
                    : "r" (&result[(i+3)*n+k]));

            asm volatile ("la t0, hsgemm_opt_v_4_4_pre"
                    :
                    :
                    : "t0");
            asm volatile ("vf 0(t0)");



            for (int j = 0; j < n; j+=4) {

                // A row 1
                asm volatile ("vmcs vs1, %0"
                        : 
                        : "r" (A[j+(i+0)*n+0]));
                asm volatile ("vmcs vs2, %0"
                        : 
                        : "r" (A[j+(i+0)*n+1]));
                asm volatile ("vmcs vs3, %0"
                        : 
                        : "r" (A[j+(i+0)*n+2]));
                asm volatile ("vmcs vs4, %0"
                        : 
                        : "r" (A[j+(i+0)*n+3]));

                // A row 2
                asm volatile ("vmcs vs5, %0"
                        : 
                        : "r" (A[j+(i+1)*n+0]));
                asm volatile ("vmcs vs6, %0"
                        : 
                        : "r" (A[j+(i+1)*n+1]));
                asm volatile ("vmcs vs7, %0"
                        : 
                        : "r" (A[j+(i+1)*n+2]));
                asm volatile ("vmcs vs8, %0"
                        : 
                        : "r" (A[j+(i+1)*n+3]));

                // A row 3
                asm volatile ("vmcs vs9, %0"
                        : 
                        : "r" (A[j+(i+2)*n+0]));
                asm volatile ("vmcs vs10, %0"
                        : 
                        : "r" (A[j+(i+2)*n+1]));
                asm volatile ("vmcs vs11, %0"
                        : 
                        : "r" (A[j+(i+2)*n+2]));
                asm volatile ("vmcs vs12, %0"
                        : 
                        : "r" (A[j+(i+2)*n+3]));

                // A row 4
                asm volatile ("vmcs vs13, %0"
                        : 
                        : "r" (A[j+(i+3)*n+0]));
                asm volatile ("vmcs vs14, %0"
                        : 
                        : "r" (A[j+(i+3)*n+1]));
                asm volatile ("vmcs vs15, %0"
                        : 
                        : "r" (A[j+(i+3)*n+2]));
                asm volatile ("vmcs vs16, %0"
                        : 
                        : "r" (A[j+(i+3)*n+3]));



                // B row 1, 2, 3, 4
                asm volatile ("vmca va1, %0"
                        : 
                        : "r" (&B[j*n+k]));
                asm volatile ("vmca va3, %0"
                        : 
                        : "r" (&B[(j+1)*n+k]));
                asm volatile ("vmca va5, %0"
                        : 
                        : "r" (&B[(j+2)*n+k]));
                asm volatile ("vmca va7, %0"
                        : 
                        : "r" (&B[(j+3)*n+k]));



                asm volatile ("la t0, hsgemm_opt_v_4_4"
                        :
                        :
                        : "t0");
                asm volatile ("vf 0(t0)");
            }
            k += consumed;
            asm volatile ("la t0, hsgemm_opt_v_4_4_post"
                    :
                    :
                    : "t0");
            asm volatile ("vf 0(t0)");

        }
    }
    asm volatile ("fence");
}
