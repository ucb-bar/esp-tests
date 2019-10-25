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

main(int argc, char **argv)
{
	FILE *infp, *outfp;
	char inxs[8], inys[8];
	int inx, iny;
	unsigned char *RGBin, *R, *G, *B, *Y, *U, *V, *YUVout;
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

	if (argc != 3)
	    {
		fprintf (stderr, "Usage: conv <in.ppm> <out.ppm>\n");
		return -1;
	    }

	infp = fopen(argv[1], "rb");
	outfp = fopen(argv[2], "wb");

	if (infp == NULL || outfp == NULL) return -1;

	if (fscanf(infp, "P6\n%s %s\n255\n", inxs, inys) != 2) return -1;

	inx = atoi(inxs);
	iny = atoi(inys);

	RGBin = malloc(sizeof(unsigned char) * inx * iny * 3);
	assert (RGBin != NULL);
	assert (fread(RGBin, sizeof (unsigned char), inx * iny * 3, infp) == (inx * iny * 3));
	fclose (infp);

	R = malloc(sizeof(unsigned char) * inx * iny);
	assert (R != NULL);
	G = malloc(sizeof(unsigned char) * inx * iny);
	assert (G != NULL);
	B = malloc(sizeof(unsigned char) * inx * iny);
	assert (B != NULL);

	separate (inx * iny, RGBin, R, G, B);
	free(RGBin);

	Y = malloc(sizeof(unsigned char) * inx * iny);
	assert (Y != NULL);
	U = malloc(sizeof(unsigned char) * inx * iny);
	assert (U != NULL);
	V = malloc(sizeof(unsigned char) * inx * iny);
	assert (V != NULL);

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
#endif


	YUVout = malloc(sizeof(unsigned char) * inx * iny * 3);
	assert (YUVout != NULL);

	merge (inx * iny, Y, U, V, YUVout);

	fprintf(outfp, "P6\n%i %i\n255\n", inx, iny);
	fwrite(YUVout, sizeof(unsigned char), inx * iny * 3, outfp);
	fclose(outfp);

}
