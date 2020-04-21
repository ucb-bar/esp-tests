// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7

#include "vec-util.h"

void vec_dgemm_opt_c(int n, double * result, double * A, double * B)
{
    asm volatile ("vsetcfg %0" : : "r" (VCFG(24, 0, 0, 1)));

    int vlen_result;
    asm volatile ("vsetvl %0, %1" : "=r" (vlen_result) : "r" (n));

    void * vpset_vfblockaddr;
    asm volatile ("la %0, dgemm_opt_v_8_8_vpset" : "=r" (vpset_vfblockaddr));
    asm volatile ("vf 0(%0)" : : "r" (vpset_vfblockaddr));

    void * pre_vfblockaddr;
    void * main_vfblockaddr;
    void * last_vfblockaddr;
    void * post_vfblockaddr;
    asm volatile ("la %0, dgemm_opt_v_8_8_pre" : "=r" (pre_vfblockaddr));
    asm volatile ("la %0, dgemm_opt_v_8_8" : "=r" (main_vfblockaddr));
    asm volatile ("la %0, dgemm_opt_v_8_8_last" : "=r" (last_vfblockaddr));
    asm volatile ("la %0, dgemm_opt_v_8_8_post" : "=r" (post_vfblockaddr));

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
            asm volatile ("vmca va1, %0" : : "r" (&result[(i+1)*n+k]));
            asm volatile ("vmca va2, %0" : : "r" (&result[(i+2)*n+k]));
            asm volatile ("vmca va3, %0" : : "r" (&result[(i+3)*n+k]));
            asm volatile ("vmca va4, %0" : : "r" (&result[(i+4)*n+k]));
            asm volatile ("vmca va5, %0" : : "r" (&result[(i+5)*n+k]));
            asm volatile ("vmca va6, %0" : : "r" (&result[(i+6)*n+k]));
            asm volatile ("vmca va7, %0" : : "r" (&result[(i+7)*n+k]));

                // B row 1, 2, 3, 4, 5, 6, 7, 8
                asm volatile ("vmca va8,  %0" : : "r" (&B[0*n+k]));
                asm volatile ("vmca va9,  %0" : : "r" (&B[(0+1)*n+k]));
                asm volatile ("vmca va10, %0" : : "r" (&B[(0+2)*n+k]));
                asm volatile ("vmca va11, %0" : : "r" (&B[(0+3)*n+k]));

            asm volatile ("vf 0(%0)" : : "r" (pre_vfblockaddr));

            for (int j = 0; j < n; j+=8) {

                // B row 1, 2, 3, 4, 5, 6, 7, 8
                if (j >= n-8) { 
                } else {
                  asm volatile ("vmca va8,  %0" : : "r" (&B[(j+8)*n+k]));
                  asm volatile ("vmca va9,  %0" : : "r" (&B[(j+9)*n+k]));
                  asm volatile ("vmca va10, %0" : : "r" (&B[(j+10)*n+k]));
                  asm volatile ("vmca va11, %0" : : "r" (&B[(j+11)*n+k]));
                }
                asm volatile ("vmca va12, %0" : : "r" (&B[(j+4)*n+k]));
                asm volatile ("vmca va13, %0" : : "r" (&B[(j+5)*n+k]));
                asm volatile ("vmca va14, %0" : : "r" (&B[(j+6)*n+k]));
                asm volatile ("vmca va15, %0" : : "r" (&B[(j+7)*n+k]));

                // A row 1, 2, 3, 4, 5, 6, 7, 8
                asm volatile ("vmca va16, %0" : : "r" (&A[j+i*n]));
                asm volatile ("vmca va17, %0" : : "r" (&A[j+(i+1)*n]));
                asm volatile ("vmca va18, %0" : : "r" (&A[j+(i+2)*n]));
                asm volatile ("vmca va19, %0" : : "r" (&A[j+(i+3)*n]));
                asm volatile ("vmca va20, %0" : : "r" (&A[j+(i+4)*n]));
                asm volatile ("vmca va21, %0" : : "r" (&A[j+(i+5)*n]));
                asm volatile ("vmca va22, %0" : : "r" (&A[j+(i+6)*n]));
                asm volatile ("vmca va23, %0" : : "r" (&A[j+(i+7)*n]));

                // A row 1, 2, 3, 4, 5, 6, 7, 8 offset by 4
                asm volatile ("vmca va24, %0" : : "r" (&A[j+4+i*n]));
                asm volatile ("vmca va25, %0" : : "r" (&A[j+4+(i+1)*n]));
                asm volatile ("vmca va26, %0" : : "r" (&A[j+4+(i+2)*n]));
                asm volatile ("vmca va27, %0" : : "r" (&A[j+4+(i+3)*n]));
                asm volatile ("vmca va28, %0" : : "r" (&A[j+4+(i+4)*n]));
                asm volatile ("vmca va29, %0" : : "r" (&A[j+4+(i+5)*n]));
                asm volatile ("vmca va30, %0" : : "r" (&A[j+4+(i+6)*n]));
                asm volatile ("vmca va31, %0" : : "r" (&A[j+4+(i+7)*n]));
                /*
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
                */

                if (j >= n-8) { 
                  asm volatile ("vf 0(%0)" : : "r" (last_vfblockaddr));
                } else {
                  asm volatile ("vf 0(%0)" : : "r" (main_vfblockaddr));
                }
            }
            asm volatile ("vf 0(%0)" : : "r" (post_vfblockaddr));
            k += consumed;
        }
    }
    asm volatile ("fence");
}
