// See LICENSE for license details.

// artificial limit for testing without having to set a huge matrix size
// "fakes" a short max vector length
// #define ARTIFICAL_LIMIT 7


void vec_mm_naive_c(int n, float * result, float * A, float * B) {

    asm volatile ("vsetcfg 2, 1");

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            asm volatile ("vmss vs1, %0"
                    : 
                    : "r" (A[j+i*n]));

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


                asm volatile ("vmsa va1, %0"
                        : 
                        : "r" (&B[j*n+k]));
                asm volatile ("vmsa va2, %0"
                        : 
                        : "r" (&result[i*n+k]));

                asm volatile ("la t0, mm_naive_v"
                        :
                        :
                        : "t0");
                asm volatile ("vf 0(t0)");
                k += consumed;
            }
        }
    }
    asm volatile ("fence");
}
