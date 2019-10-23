// See LICENSE for license details.

/*
 * 3x3 convolution routine
 *
 * Based on T0 test code by Krste Asanovic:
 *   apps/box3x3/box3x3_mi16mu8_mi8s_test.c
 */
#include <stddef.h>
#include <stdio.h>

#include "util.h"
#include "conv3x3.h"
#include "dataset.h"

#define VERIFY

int main(void)
{
    static float rand_b_result[OH][OW];

    setStats(1);
    conv3x3(OH, OW, IW, OW, rand_k, *rand_a, *rand_b_result);
    setStats(0);

#ifdef VERIFY
    return verifyFloat(OH * OW, *rand_b_result, *rand_b_verify);
#else
    return 0;
#endif
}
