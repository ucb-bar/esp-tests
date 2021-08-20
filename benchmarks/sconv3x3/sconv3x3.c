// See LICENSE for license details.

//**************************************************************************
// Spatially separable 3x3 convolution
//--------------------------------------------------------------------------
#include "sconv3x3.h"

/*
 * Spatially separable 3x3 convolution routine
 */
void sconv3x3(
    size_t rows,
    size_t cols,
    size_t a_stride,
    size_t b_stride,
    const float kw[3],
    const float kh[3],
    const float *a,
    float *b,
    float *t)
{
    size_t i;
    float *tp;

    /* 1x3 convolution */
    tp = t;
    for (i = 0; i < rows+2; i++) {
        const float *ap;
        size_t j;

        ap = a;
        for (j = 0; j < cols; j++) {
            float sum;

            sum = ap[0] * kw[0];
            sum += ap[1] * kw[1];
            sum += ap[2] * kw[2];
            *tp++ = sum;
            ap++;
        }
        a += a_stride;
    }

    /* 3x1 convolution */
    for (i = 0; i < rows; i++) {
        float *bp;
        size_t j;

        bp = b;
        for (j = 0; j < cols; j++) {
            float sum;

            sum = t[0] * kh[0];
            sum += t[cols] * kh[1];
            sum += t[2*cols] * kh[2];
            *bp++ = sum;
            t++;
        }
        b += b_stride;
    }
}
