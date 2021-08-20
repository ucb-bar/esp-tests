// See LICENSE for license details.

/*
 * Spatially separable 3x3 convolution routine
 */
#include <stddef.h>
#include <stdio.h>

#include "util.h"
#include "sconv3x3.h"
#include "dataset.h"

#define VERIFY

int main(void)
{
    static float tmp[IH][OW];
    static float rand_b_result[OH][OW];

    setStats(1);
    sconv3x3(OH, OW, IW, OW, rand_kw, rand_kh, *rand_a, *rand_b_result, *tmp);
    setStats(0);

#ifdef VERIFY
    return verifyFloat(OH * OW, *rand_b_result, *rand_b_verify);
#else
    return 0;
#endif
}
