// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7

#include "vec-util.h"

void vec_sgemm_opt_c(int n, float * result, float * A, float * B)
{
    asm volatile ("vsetcfg %0" : : "r" (VCFG(8, 0, 0, 1)));

    int vlen_result;
    asm volatile ("vsetvl %0, %1" : "=r" (vlen_result) : "r" (n));

    void * vpset_vfblockaddr;
    asm volatile ("la %0, sgemm_opt_v_4_4_vpset" : "=r" (vpset_vfblockaddr));
    asm volatile ("vf 0(%0)" : : "r" (vpset_vfblockaddr));

    void * pre_vfblockaddr;
    void * main_vfblockaddr;
    void * post_vfblockaddr;
    asm volatile ("la %0, sgemm_opt_v_4_4_pre" : "=r" (pre_vfblockaddr));
    asm volatile ("la %0, sgemm_opt_v_4_4" : "=r" (main_vfblockaddr));
    asm volatile ("la %0, sgemm_opt_v_4_4_post" : "=r" (post_vfblockaddr));

    for (int i = 0; i < n; i+=4) {
        for (int k = 0; k < n; ) {
            int consumed;
#ifdef ARTIFICAL_LIMIT
            int artificial = n-k < ARTIFICAL_LIMIT ? n-k : ARTIFICAL_LIMIT;
#else
            int artificial = n;
#endif

            asm volatile ("vsetvl %0, %1" : "=r" (consumed) : "r" (artificial));

            // C rows 1, 2, 3, 4
            asm volatile ("vmca va0, %0" : : "r" (&result[i*n+k]));
            asm volatile ("vmca va1, %0" : : "r" (&result[(i+1)*n+k]));
            asm volatile ("vmca va2, %0" : : "r" (&result[(i+2)*n+k]));
            asm volatile ("vmca va3, %0" : : "r" (&result[(i+3)*n+k]));

            asm volatile ("vf 0(%0)" : : "r" (pre_vfblockaddr));

            for (int j = 0; j < n; j+=4) {

                // B row 1, 2, 3, 4
                asm volatile ("vmca va4, %0" : : "r" (&B[j*n+k]));
                asm volatile ("vmca va5, %0" : : "r" (&B[(j+1)*n+k]));
                asm volatile ("vmca va6, %0" : : "r" (&B[(j+2)*n+k]));
                asm volatile ("vmca va7, %0" : : "r" (&B[(j+3)*n+k]));

                // A row 1, 2, 3, 4
                asm volatile ("vmcs vs1, %0\n"
                              "vmcs vs2, %1\n"
                              "vmcs vs3, %2\n"
                              "vmcs vs4, %3\n"

                              "vmcs vs5, %4\n"
                              "vmcs vs6, %5\n"
                              "vmcs vs7, %6\n"
                              "vmcs vs8, %7\n"

                              "vmcs vs9, %8\n"
                              "vmcs vs10, %9\n"
                              "vmcs vs11, %10\n"
                              "vmcs vs12, %11\n"

                              "vmcs vs13, %12\n"
                              "vmcs vs14, %13\n"
                              "vmcs vs15, %14\n"
                              "vmcs vs16, %15"
                        : 
                        : "r" (A[j+(i+0)*n+0]), "r" (A[j+(i+0)*n+1]), "r" (A[j+(i+0)*n+2]), "r" (A[j+(i+0)*n+3]), 
                          "r" (A[j+(i+1)*n+0]), "r" (A[j+(i+1)*n+1]), "r" (A[j+(i+1)*n+2]), "r" (A[j+(i+1)*n+3]),
                          "r" (A[j+(i+2)*n+0]), "r" (A[j+(i+2)*n+1]), "r" (A[j+(i+2)*n+2]), "r" (A[j+(i+2)*n+3]),
                          "r" (A[j+(i+3)*n+0]), "r" (A[j+(i+3)*n+1]), "r" (A[j+(i+3)*n+2]), "r" (A[j+(i+3)*n+3])
                        );

                asm volatile ("vf 0(%0)" : : "r" (main_vfblockaddr));
            }
            asm volatile ("vf 0(%0)" : : "r" (post_vfblockaddr));
            k += consumed;
        }
    }
    asm volatile ("fence");
}
