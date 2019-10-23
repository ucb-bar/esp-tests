// See LICENSE for license details.

//**************************************************************************
// 3x3 convolution
//--------------------------------------------------------------------------
#include "conv3x3.h"

/*
 * 3x3 convolution routine
 *
 * Based on T0 test code by Krste Asanovic:
 *   apps/box3x3/box3x3_mi16mu8_mi8s_test.c
 */
void conv3x3(
    size_t rows,
    size_t cols,
    size_t a_stride,
    size_t b_stride,
    const float k[3][3],
    const float *a,
    float *b)
{
    size_t i;
    for (i = 0; i < rows; i++) {
        const float *ap;
        float *bp;
        size_t j;

        ap = a;
        bp = b;

        for (j = 0; j < cols; j++) {
            float sum;
            const float *app = ap;

            sum = app[0] * k[0][0];
            sum += app[1] * k[0][1];
            sum += app[2] * k[0][2];
            app += a_stride;

            sum += app[0] * k[1][0];
            sum += app[1] * k[1][1];
            sum += app[2] * k[1][2];
            app += a_stride;

            sum += app[0] * k[2][0];
            sum += app[1] * k[2][1];
            sum += app[2] * k[2][2];

            *bp++ = sum;

            ap++;
        }

        a += a_stride;
        b += b_stride;
    }
}
