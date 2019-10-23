// See LICENSE for license details.

/*
 * General 3x3 box filter routine
 *
 * Based on T0 test code by Krste Asanovic:
 *   apps/box3x3/box3x3_mi16mu8_mi8s_test.c
 */
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>

#include "util.h"
#include "dataset.h"

/* Vectorized implementation */
extern void box3x3_mi16mu8_mi8s(
    size_t n_rows,
    size_t n_cols,
    size_t a_stride,
    size_t b_stride,
    const int16_t k[3][3],
    const uint8_t *a,
    int8_t *b,
    unsigned int rshift);

/* Reference scalar implementation */
static bool box3x3_ref(
    size_t n_rows,
    size_t n_cols,
    size_t a_stride,
    size_t b_stride,
    const int16_t k[3][3],
    const uint8_t *a,
    int8_t *b,
    unsigned int rshift)
{
    size_t i;
    const int32_t mask = (1 << rshift) - 1;
    const int rshift_zero = (rshift == 0);
    const int32_t rbit = rshift_zero ? 0 : (1 << (rshift - 1));
    bool sat = 0;

    for (i = 0; i < n_rows; i++) {
        const uint8_t *ap;
        int8_t *bp;
        size_t j;

        ap = a;
        bp = b;

        for (j = 0; j < n_cols; j++) {
            int32_t sum;
            int32_t sticky;
            int32_t sticky_correct;
            int32_t rsum;

            const uint8_t *app = ap;

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

            /* Round off sum before storing back. */
            rsum = sum + rbit;
            sticky = ((rsum & mask) != 0) | rshift_zero;
            sticky_correct = ~1 | sticky;
            rsum = (rsum >> rshift) & sticky_correct;

            if (rsum > INT8_MAX) {
                rsum = INT8_MAX;
                sat = true;
            } else if (rsum < INT8_MIN) {
                rsum = INT8_MIN;
                sat = true;
            }

            /* Store rounded, saturated result. */
            *bp++ = rsum;

            ap++;
        }

        a += a_stride;
        b += b_stride;
    }

    return sat;
}

static int box3x3_verify(const int8_t *b_test, const int8_t *b_ref,
    size_t n, const char *label)
{
    size_t i;

    for (i = 0; i < n; i++) {
        int8_t ref = *b_ref++;
        int8_t test = *b_test++;
        if (test != ref) {
            printf("%s: index=%lu expected=0x%x result=0x%x\n", label, i, ref, test);
            return i + 1;
        }
    }
    return 0;
}

static int box3x3_test(
    size_t n_rows,
    size_t n_cols,
    size_t a_stride,
    size_t b_stride,
    const int16_t k[3][3],
    const uint8_t *a,
    const int8_t *b,
    unsigned int rshift,
    bool sat,
    const char *label)
{
    size_t n = n_rows * n_cols;
    int8_t b_buf[n];

    box3x3_mi16mu8_mi8s(n_rows, n_cols, a_stride, b_stride, k, a, b_buf, rshift);

    return box3x3_verify(b_buf, b, n, label);
}

static int test1(void)
{
    /* Basic op test */
    const static uint8_t a[] = {
        1, 2, 3,
        4, 5, 6,
        7, 8, 9,
    };
    const static int16_t k[3][3] = {
        {9, 8, 7},
        {-6, -5, -4},
        {3, 2, 1},
    };
    const static int8_t b[] = { 19 };

    return box3x3_test(1, 1, 3, 1, k, a, b, 0, false, __func__);
}

static int test2(void)
{
    /* Test A stride */
    const static uint8_t a[] = {
        1, 2, 3, 1,
        4, 5, 6, 3,
        7, 8, 9, 2,
        0, 1, 1, 2,
    };
    const static int16_t k[3][3] = {
        {9, 8, 7},
        {-6, -5, -4},
        {3, 2, 1},
    };
    const static int8_t b[] = { 19 };

    return box3x3_test(1, 1, 4, 1, k, a, b, 0, false, __func__);
}

static int test3(void)
{
    /* Test multiple outputs */
    const static uint8_t a[] = {
        1, 2, 3, 1,
        4, 5, 6, 3,
        7, 8, 9, 2,
        0, 1, 1, 2,
    };
    const static int16_t k[3][3] = {
        {9, 8, 7},
        {-6, -5, -4},
        {3, 2, 1},
    };
    const static int8_t b[] = {
        19, 21,
        3, 20,
    };

    return box3x3_test(2, 2, 4, 2, k, a, b, 0, false, __func__);
}

static int test4(void)
{
    /* Test rounding */
    const static uint8_t a[] = {
        1, 2, 3, 1,
        4, 5, 6, 3,
        7, 8, 9, 2,
        0, 1, 1, 2,
    };
    const static int16_t k[3][3] = {
        {9, 8, 7},
        {-6, -5, -4},
        {3, 2, 1},
    };
    const static int8_t b[] = {
        2, 3,
        0, 2,
    };

    return box3x3_test(2, 2, 4, 2, k, a, b, 3, false, __func__);
}

static int test5(void)
{
    /* Test saturation */
    const static uint8_t a[] = {
        0xff, 0, 0,
        0, 0, 0,
        0, 0, 0,
    };
    const static int16_t k[3][3] = {
        {0xff, 0, 0},
        {0, 0, 0},
        {0, 0, 0},
    };
    const static int8_t b[] = { 0x7f };

    return box3x3_test(1, 1, 3, 1, k, a, b, 5, true, __func__);
}

int test_random(void)
{
    size_t i;

    box3x3_ref(RAND_ROWS, RAND_COLS, RAND_A_STRIDE, RAND_B_STRIDE,
        rand_k, rand_a, rand_b_verify, 17);

    setStats(1);
    box3x3_mi16mu8_mi8s(RAND_ROWS, RAND_COLS, RAND_A_STRIDE, RAND_B_STRIDE,
        rand_k, rand_a, rand_b_result, 17);
    setStats(0);

    return box3x3_verify(rand_b_result, rand_b_verify, sizeof(rand_b_verify), __func__);
}

int main(void)
{
    int rc;

    if ((rc = test1()) ||
        (rc = test2()) ||
        (rc = test3()) ||
        (rc = test4()) ||
        (rc = test5())) {
        return rc;
    }
    return test_random();
}
