/*
**
** Test program for colorspace conversion
**
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


typedef short int16;

void nv_conv(size_t n_pixels,	/* size of each color plane (in bytes) */
	     const short trans[3][3],	/* transformation matrix */
	     const int rshift,		/* shamt for matrix el's */
	     const unsigned char *R_in,
	     const unsigned char *G_in,
	     const unsigned char *B_in,
	     unsigned char *Y_out,
	     unsigned char *U_out,
	     unsigned char *V_out)
{
	size_t i;

	for (i=0; i < n_pixels; i++)
	{
		*(Y_out++) = (*(R_in) * trans[0][0] +
				*(G_in) * trans[0][1] +
				*(B_in) * trans[0][2]) >> rshift;

		*(U_out++) = (*(R_in) * trans[1][0] +
				*(G_in) * trans[1][1] +
				*(B_in) * trans[1][2]) >> rshift;

		*(V_out++) = (*(R_in++) * trans[2][0] +
				*(G_in++) * trans[2][1] +
				*(B_in++) * trans[2][2]) >> rshift;

	}
}

void separate(size_t n_pixels,
	      const unsigned char *RGBin,
	      unsigned char *R,
	      unsigned char *G,
	      unsigned char *B)
{
	size_t i;

	for (i=0; i < n_pixels; i++)
	{
		*(R++) = *(RGBin++);
		*(G++) = *(RGBin++);
		*(B++) = *(RGBin++);
	}
}

void merge(size_t n_pixels,
	   const unsigned char *Y,
	   const unsigned char *U,
	   const unsigned char *V,
	   unsigned char *YUVout)

{
	size_t i;

	for (i=0; i < n_pixels; i++)
	{
		*(YUVout++) = *(Y++);
		*(YUVout++) = *(U++);
		*(YUVout++) = *(V++);
	}
}


const int inx = 9;
const int iny = 9;


static int conv_verify(const unsigned char *yuv_test, const unsigned char *yuv_ref,
    size_t n, const char *label)
{
    size_t i;

    for (i = 0; i < n; i++) {
        int8_t ref = *yuv_ref++;
        int8_t test = *yuv_test++;
        if (test != ref) {
            printf("%s: index=%lu expected=0x%x result=0x%x\n", label, i, ref, test);
            return i + 1;
        }
    }
    return 0;
}



main(int argc, char **argv)
{
	//FILE *infp, *outfp;
	//char inxs[8], inys[8];
	//int inx, iny;
	//unsigned char *RGBin, *R, *G, *B, *Y, *U, *V, *YUVout;
	short trans[3][3] = {
		{ 0x2646, 0x4b23, 0x0e98 },
		{ 0x4000, 0xca68, 0xf598 },
		{ 0xea68, 0xd598, 0x4000 }};
	int rshift = 15;

/*	short trans[3][3] = {
		{ 0, 0, 0 },
		{ 0, 0, 0 },
		{ -4, 4, 4 }};
	int rshift = 3;
*/
/*
	if (argc != 3)
	    {
		fprintf (stderr, "Usage: conv <in.ppm> <out.ppm>\n");
		return -1;
	    }
*/
	//infp = fopen(argv[1], "rb");
	//outfp = fopen(argv[2], "wb");

	//if (infp == NULL || outfp == NULL) return -1;

	//if (fscanf(infp, "P6\n%s %s\n255\n", inxs, inys) != 2) return -1;

	//inx = atoi(inxs);
	//iny = atoi(inys);

	//RGBin = malloc(sizeof(unsigned char) * inx * iny * 3);
	//assert (RGBin != NULL);
	unsigned char RGBin[inx * iny * 3];
	//assert (fread(RGBin, sizeof (unsigned char), inx * iny * 3, infp) == (inx * iny * 3));
	//fclose (infp);

        for (int i=0; i< inx * iny * 3; i++)
        {
          RGBin[i] = i;
        }

	//R = malloc(sizeof(unsigned char) * inx * iny);
	//assert (R != NULL);
	//G = malloc(sizeof(unsigned char) * inx * iny);
	//assert (G != NULL);
	//B = malloc(sizeof(unsigned char) * inx * iny);
	//assert (B != NULL);
	unsigned char R[inx * iny];
	unsigned char G[inx * iny];
	unsigned char B[inx * iny];

	separate (inx * iny, RGBin, R, G, B);
	//free(RGBin);

	//Y = malloc(sizeof(unsigned char) * inx * iny);
	//assert (Y != NULL);
	//U = malloc(sizeof(unsigned char) * inx * iny);
	//assert (U != NULL);
	//V = malloc(sizeof(unsigned char) * inx * iny);
	//assert (V != NULL);
	unsigned char Y[inx * iny];
	unsigned char U[inx * iny];
	unsigned char V[inx * iny];

	unsigned char Y_nv[inx * iny];
	unsigned char U_nv[inx * iny];
	unsigned char V_nv[inx * iny];


#ifdef NO_VECT
	nv_conv(inx*iny,
	     trans,
	     rshift,
	     R,
	     G,
	     B,
	     Y,
	     U,
	     V);

	nv_conv(inx*iny,
	     trans,
	     rshift,
	     R,
	     G,
	     B,
	     Y_nv,
	     U_nv,
	     V_nv);
#endif

#ifdef VECT
	conv(inx*iny,
	     trans,
	     rshift,
	     R,
	     G,
	     B,
	     Y,
	     U,
	     V);

	nv_conv(inx*iny,
	     trans,
	     rshift,
	     R,
	     G,
	     B,
	     Y_nv,
	     U_nv,
	     V_nv);
#endif


	//YUVout = malloc(sizeof(unsigned char) * inx * iny * 3);
	//assert (YUVout != NULL);
	unsigned char YUVout[inx * iny * 3];
	unsigned char YUVout_nv[inx * iny * 3];

	merge (inx * iny, Y, U, V, YUVout);
	merge (inx * iny, Y_nv, U_nv, V_nv, YUVout_nv);

	//fprintf(outfp, "P6\n%i %i\n255\n", inx, iny);
	//fwrite(YUVout, sizeof(unsigned char), inx * iny * 3, outfp);
	//fclose(outfp);
        return conv_verify(YUVout, YUVout_nv, inx * iny * 3, "test_verify");
}
