// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7

#include "vec-util.h"

void vec_sgemm_opt_c(int n, float * result, float * A, float * B)
{
    asm volatile ("vsetcfg %0" : : "r" (VCFG(0, 8, 0, 1)));

    int vlen_result;
    asm volatile ("vsetvl %0, %1" : "=r" (vlen_result) : "r" (n));

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
            asm volatile ("vld v0, %0 # c0\n
                           vld v1, %1 # c1\n
                           vld v2, %2 # c2\n
                           vld v3, %3 # c3\n
                          " : : "r" (&result[i*n+k]),
                                "r" (&result[(i+1)*n+k]),
                                "r" (&result[(i+2)*n+k]),
                                "r" (&result[(i+3)*n+k]));

            for (int j = 0; j < n; j+=4) {

                // A row 1, 2, 3, 4
                asm volatile ("vinsert v31, %0, zero\n"
                              "vinsert v30, %1, zero\n"
                              "vinsert v29, %2, zero\n"
                              "vinsert v28, %3, zero\n"

                              "vinsert v27, %4, zero\n"
                              "vinsert v26, %5, zero\n"
                              "vinsert v25, %6, zero\n"
                              "vinsert v24, %7, zero\n"

                              "vinsert v23, %8, zero\n"
                              "vinsert v22, %9, zero\n"
                              "vinsert v21, %10, zero\n"
                              "vinsert v20, %11, zero\n"

                              "vinsert v19, %12, zero\n"
                              "vinsert v18, %13, zero\n"
                              "vinsert v17, %14, zero\n"
                              "vinsert v16, %15, zero"
                        :
                        : "r" (A[j+(i+0)*n+0]), "r" (A[j+(i+0)*n+1]), "r" (A[j+(i+0)*n+2]), "r" (A[j+(i+0)*n+3]),
                          "r" (A[j+(i+1)*n+0]), "r" (A[j+(i+1)*n+1]), "r" (A[j+(i+1)*n+2]), "r" (A[j+(i+1)*n+3]),
                          "r" (A[j+(i+2)*n+0]), "r" (A[j+(i+2)*n+1]), "r" (A[j+(i+2)*n+2]), "r" (A[j+(i+2)*n+3]),
                          "r" (A[j+(i+3)*n+0]), "r" (A[j+(i+3)*n+1]), "r" (A[j+(i+3)*n+2]), "r" (A[j+(i+3)*n+3])
                        );
                                                                                                                                                                 
                asm volatile ("vld v4, %0                     # b0\n
                               vmadd v0, v4, v31, v0     # c0 += a00 * b0\n
                               vmadd v1, v4, v27, v1     # c1 += a10 * b0\n

                               vld v5, %1                     # b1\n
                               vmadd v2, v4, v23, v2     # c2 += a20 * b0\n
                               vmadd v3, v4, v19, v3    # c3 += a30 * b0\n

                               vld v6, %2                     # b2\n
                               vmadd v0, v5, v30, v0     # c0 += a01 * b1\n
                               vmadd v1, v5, v26, v1     # c1 += a11 * b1\n

                               vld v7, %3                     # b3\n
                               vmadd v0, v6, v29, v0     # c0 += a02 * b2\n
                               vmadd v1, v6, v25, v1     # c1 += a12 * b2\n
                               vmadd v0, v7, v28, v0     # c0 += a03 * b3\n
                               vmadd v1, v7, v24, v1     # c1 += a13 * b3\n
                               vmadd v2, v5, v22, v2    # c2 += a21 * b1\n
                               vmadd v3, v5, v18, v3    # c3 += a31 * b1\n
                               vmadd v2, v6, v21, v2    # c2 += a22 * b2\n
                               vmadd v3, v6, v17, v3    # c3 += a32 * b2\n
                               vmadd v2, v7, v20, v2    # c2 += a23 * b3\n
                               vmadd v3, v7, v16, v3    # c3 += a33 * b3\n
                              " : : "r" (&B[j*n+k]),
                                    "r" (&B[(j+1)*n+k]),
                                    "r" (&B[(j+2)*n+k]),
                                    "r" (&B[(j+3)*n+k]));
            }
            asm volatile ("vst v0, va0 # c0\n
                           vst v1, va1 # c1\n
                           vst v2, va2 # c2\n
                           vst v3, va3 # c3\n
                           " : : "r" (&result[i*n+k]),
                                 "r" (&result[(i+1)*n+k]),
                                 "r" (&result[(i+2)*n+k]),
                                 "r" (&result[(i+3)*n+k]));
            k += consumed;
        }
    }
    asm volatile ("fence");
}
