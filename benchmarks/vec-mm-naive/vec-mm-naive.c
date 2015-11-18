// See LICENSE for license details.

//**************************************************************************
// Median filter (c version)
//--------------------------------------------------------------------------



void vec_mm_naive_c(int n, float * result, float * A, float * B) {

    asm volatile ("vsetcfg 2, 1");
    asm volatile ("vsetvl t0, a0"
            :
            :
            : "t0");


    // small example, with no k loop
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            asm volatile ("vmss vs1, %0"
                    : 
                    : "r" (A[j+i*n]));
            asm volatile ("vmsa va1, %0"
                    : 
                    : "r" (&B[j*n]));
            asm volatile ("vmsa va2, %0"
                    : 
                    : "r" (&result[i*n]));

            asm volatile ("la t0, mm_naive_v"
                    :
                    :
                    : "t0");
            asm volatile ("vf 0(t0)");
        }
    }
    asm volatile ("fence");
}
