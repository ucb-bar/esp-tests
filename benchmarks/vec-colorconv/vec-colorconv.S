/*
**
** colorspace conversion
**
*/

//#include "machine/tordef.h"

/* This function takes an input image, separated into 3 color planes, 
and performs a colorspace conversion described by the given transformation
matrix.  The output is placed into 3 separate color planes.  The first
input, n_pixels, is the size in pixels of the image.  The transformation
matrix is composed of 16-bit signed values, with the shift amount in
rshift.

void nv_conv(size_t n_pixels,	size of each color plane (in bytes) 
	     const short trans[3][3],	transformation matrix 
	     const int rshift,		shamt for matrix el's 
	     const unsigned char *R_in,
	     const unsigned char *G_in,
	     const unsigned char *B_in,
	     unsigned char *Y_out,
	     unsigned char *U_out,
	     unsigned char *V_out)
*/

	.globl	_conv


#define	in1_v		vv1
#define	in2_v		vv2
#define	in3_v		vv3
#define	o1_v		vv4
#define	o2_v		vv5
#define	o3_v		vv6
#define	out1_v		vv7
#define	out2_v		vv8
#define	out3_v		vv9
#define	temp1_v		vv10
#define	temp2_v		vv11

#define	n_pixels_r	a0
#define	matrix_r	a1
#define	rshift_r	a2
#define	in1_r		a3
#define	in2_r		a4
#define	in3_r		a5
#define o1_r		a6
#define o2_r		a7
#define o3_r		t0
#define t1_r		t1
#define t2_r		t2
#define t3_r		t3
#define done_r		t4
#define len_r		t5
#define	in1_r2		t6

/*Hwacha scalar registers*/
#define	n_pixels_r_h	vs0
#define	matrix_r_h	vs1
#define	rshift_r_h	vs2
#define	in1_r_h1	va0
#define	in2_r_h1	va1
#define	in3_r_h1	va2
#define	in1_r_h2	va0
#define o1_r_h		va3
#define o2_r_h		va4
#define o3_r_h		va5
#define t11_r_h		vs3
#define t12_r_h		vs4
#define t13_r_h		vs5
#define t21_r_h		vs6
#define t22_r_h		vs7
#define t23_r_h		vs8
#define t31_r_h		vs9
#define t32_r_h		vs10
#define t33_r_h		vs11
#define done_r_h	vs12
#define len_r_h		vs13

	.globl	conv

conv:
setup:
	# get the last few arguments from the stack
	lw	o3_r, 0(sp)

        # move arguments into hwacha scalar registers
	vmcs	n_pixels_r_h, n_pixels_r
	vmcs	matrix_r_h, matrix_r
	vmcs	rshift_r_h, rshift_r
	vmca	in1_r_h1, in1_r
	vmca	in2_r_h1, in2_r
	vmca	in3_r_h1, in3_r
	vmca	o1_r_h, o1_r
	vmca	o2_r_h, o2_r
	vmca	o3_r_h, o3_r
	lh	t1_r, 0(matrix_r)
	lh	t2_r, 2(matrix_r)
	lh	t3_r, 4(matrix_r)
	vmcs	t11_r_h, t1_r
	vmcs	t12_r_h, t2_r
	vmcs	t13_r_h, t3_r
	lh	t1_r, 6(matrix_r)
	lh	t2_r, 8(matrix_r)
	lh	t3_r, 10(matrix_r)
	vmcs	t21_r_h, t1_r
	vmcs	t22_r_h, t2_r
	vmcs	t23_r_h, t3_r
	lh	t1_r, 12(matrix_r)
	lh	t2_r, 14(matrix_r)
	lh	t3_r, 16(matrix_r)
	vmcs	t31_r_h, t1_r
	vmcs	t32_r_h, t2_r
	vmcs	t33_r_h, t3_r
	vmcs	done_r_h, done_r
	vmcs	len_r_h, len_r
	andi	rshift_r, rshift_r, 0x1f
	beqz	n_pixels_r, done
	
	vsetvl	len_r, n_pixels_r
        add     in1_r2, in1_r, len_r
	vmca	in1_r_h2, in1_r
1:
        auipc	t4, %pcrel_hi(enter_loop)
        vf	%pcrel_lo(1b)(t4)
	#vf	enter_loop

	# produce len_r, rshift_r, done_r
outer:	vsetvl	len_r, n_pixels_r
	add    	in2_r, in2_r, len_r
	add	in3_r, in3_r, len_r
        add     in1_r2, in1_r, len_r
	vmca	in2_r_h1, in2_r
	vmca	in3_r_h1, in3_r
	vmca	in1_r_h2, in1_r2
2:
        auipc	t4, %pcrel_hi(loop)
        vf	%pcrel_lo(2b)(t4)
	#vf	loop
        sub	n_pixels_r, n_pixels_r, len_r
	add	o1_r, o1_r, len_r
	add	o2_r, o2_r, len_r
	add	o3_r, o3_r, len_r
	vmca	o1_r_h, o1_r
	vmca	o2_r_h, o2_r
	vmca	o3_r_h, o3_r
	add	in1_r, in1_r, len_r
	vmca	in1_r_h1, in1_r
        bnez     n_pixels_r, outer

done:
	# then return
3:
        auipc	t4, %pcrel_hi(exit)
        vf	%pcrel_lo(3b)(t4)
	#vf	exit
	fence
	ret


enter_loop:
	vlbu		in1_v, in1_r_h1
	vmul.vs		o1_v, in1_v, t11_r_h
	vlbu    	in2_v, in2_r_h1
	vmul.vs		o2_v, in1_v, t12_r_h
	vlbu	  	in3_v, in3_r_h1
	vmul.vs		o3_v, in1_v, t13_r_h
	vmul.vs		temp1_v, in2_v, t21_r_h
	vadd.vv		o1_v, o1_v, temp1_v
	vmul.vs		temp2_v, in3_v, t31_r_h
	vadd.vv		out1_v, o1_v, temp2_v
	vsra.vs		out1_v, out1_v, rshift_r_h
	vmul.vs		temp1_v, in2_v, t22_r_h
	vadd.vv		o2_v, o2_v, temp1_v
	vmul.vs		temp2_v, in3_v, t32_r_h
	vadd.vv		out2_v, o2_v, temp2_v
	vsra.vs		out2_v, out2_v, rshift_r_h
	vmul.vs		temp1_v, in2_v, t23_r_h
	vlbu		in1_v, in1_r_h2
	vadd.vv		o3_v, o3_v, temp1_v
	vmul.vs		temp2_v, in3_v, t33_r_h
        vstop

loop:
	vmul.vs		o1_v, in1_v, t11_r_h
	vadd.vv		out3_v, o3_v, temp2_v
	vsra.vs		out3_v, out3_v, rshift_r_h
	vlbu		in2_v, in2_r_h1
	vmul.vs		o2_v, in1_v, t12_r_h
	vmul.vs		o3_v, in1_v, t13_r_h
	vsb		out1_v, o1_r_h
	vmul.vs		temp1_v, in2_v, t21_r_h
	vsb		out2_v, o2_r_h
	vadd.vv		o1_v, o1_v, temp1_v
	vmul.vs		temp2_v, in3_v, t31_r_h
	vsb		out3_v, o3_r_h
	vadd.vv		out1_v, o1_v, temp2_v
	vsra.vs		out1_v, out1_v, rshift_r_h
	vmul.vs		temp1_v, in2_v, t22_r_h
	vadd.vv		o2_v, o2_v, temp1_v
	vmul.vs		temp2_v, in3_v, t32_r_h
	vadd.vv		out2_v, o2_v, temp2_v
	vsra.vs		out2_v, out2_v, rshift_r_h
	vmul.vs		temp1_v, in2_v, t23_r_h
	vlbu		in1_v, in1_r_h2
	vadd.vv		o3_v, o3_v, temp1_v
	vmul.vs		temp2_v, in3_v, t33_r_h
        vstop

exit:
	vadd.vv		out3_v, o3_v, temp2_v
	vsra.vs		out3_v, out3_v, rshift_r_h
	vsb		out1_v, o1_r_h
	vsb		out2_v, o2_r_h
	vsb		out3_v, o3_r_h
        vstop
