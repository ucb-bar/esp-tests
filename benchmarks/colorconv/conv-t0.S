/*
**
** colorspace conversion
**
*/

#include "machine/tordef.h"

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
#define	in2_r		t0
#define	in3_r		t1
#define o1_r		t2
#define o2_r		t3
#define o3_r		t4
#define t11_r		t5
#define t12_r		t6
#define t13_r		t7
#define t21_r		t8
#define t22_r		t9
#define t23_r		s0
#define t31_r		s1
#define t32_r		s2
#define t33_r		s3
#define done_r		s4
#define len_r		a1


	.globl	conv

	.ent	conv

conv:
setup:
	# save some registers...
	# adjust sp for 6 saved regs
	subu	sp, sp, 24
	.frame	sp, 24, ra
	sw	ra, 0(sp)
	sw	s0, 4(sp)
	sw	s1, 8(sp)
	sw	s2, 12(sp)
	sw	s3, 16(sp)
	sw	s4, 20(sp)

	# get the last few arguments from the stack
	lw	in2_r, 40(sp)
	lw	in3_r, 44(sp)
	lw	o1_r, 48(sp)
	lw	o2_r, 52(sp)
	lw	o3_r, 56(sp)
	lh	t11_r, 0(matrix_r)
	lh	t21_r, 2(matrix_r)
	lh	t31_r, 4(matrix_r)
	lh	t12_r, 6(matrix_r)
	lh	t22_r, 8(matrix_r)
	lh	t32_r, 10(matrix_r)
	lh	t13_r, 12(matrix_r)
	lh	t23_r, 14(matrix_r)
	lh	t33_r, 16(matrix_r)
	
	# produce len_r, rshift_r, done_r
	li	len_r, MAXVLEN
	ctvu	len_r, vlr
	andi	rshift_r, rshift_r, 0x1f
	sll	rshift_r, rshift_r, 13
	ori	rshift_r, rshift_r, 0x1000
	and	done_r, n_pixels_r, ~(MAXVLEN - 1)
	add	done_r, in3_r, done_r
	jal	enter_loop

	andi	len_r, n_pixels_r, (MAXVLEN - 1)
	beq	len_r, $0, done
	add	done_r, in3_r, len_r
	ctvu	len_r, vlr
	jal	enter_loop

done:
	# fix the stack
	lw	ra, 0(sp)
	lw	s0, 4(sp)
	lw	s1, 8(sp)
	lw	s2, 12(sp)
	lw	s3, 16(sp)
	lw	s4, 20(sp)
	addi	sp, sp, 24

	# then return
	jr	ra

	.end	conv



	.globl	enter_loop

	.ent	enter_loop

enter_loop:
	.frame	sp, 0, ra
	lbuai.v	in1_v, in1_r, len_r
	fxmul.vs	o1_v, in1_v, t11_r, $0
	lbuai.v	in2_v, in2_r, len_r
	fxmul.vs	o2_v, in1_v, t12_r, $0
	lbuai.v	in3_v, in3_r, len_r
	fxmul.vs	o3_v, in1_v, t13_r, $0
	fxmul.vs	temp1_v, in2_v, t21_r, $0
	fxadd.vv	o1_v, o1_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t31_r, $0
	fxadd.vv	out1_v, o1_v, temp2_v, rshift_r
	fxmul.vs	temp1_v, in2_v, t22_r, $0
	fxadd.vv	o2_v, o2_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t32_r, $0
	fxadd.vv	out2_v, o2_v, temp2_v, rshift_r
	fxmul.vs	temp1_v, in2_v, t23_r, $0
	lbuai.v	in1_v, in1_r, len_r
	fxadd.vv	o3_v, o3_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t33_r, $0
	beq	in3_r, done_r, exit

loop:
	fxmul.vs	o1_v, in1_v, t11_r, $0
	fxadd.vv	out3_v, o3_v, temp2_v, rshift_r
	lbuai.v	in2_v, in2_r, len_r
	fxmul.vs	o2_v, in1_v, t12_r, $0
	lbuai.v	in3_v, in3_r, len_r
	fxmul.vs	o3_v, in1_v, t13_r, $0
	sbai.v	out1_v, o1_r, len_r
	fxmul.vs	temp1_v, in2_v, t21_r, $0
	sbai.v	out2_v, o2_r, len_r
	fxadd.vv	o1_v, o1_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t31_r, $0
	sbai.v	out3_v, o3_r, len_r
	fxadd.vv	out1_v, o1_v, temp2_v, rshift_r
	fxmul.vs	temp1_v, in2_v, t22_r, $0
	fxadd.vv	o2_v, o2_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t32_r, $0
	fxadd.vv	out2_v, o2_v, temp2_v, rshift_r
	fxmul.vs	temp1_v, in2_v, t23_r, $0
	lbuai.v	in1_v, in1_r, len_r
	fxadd.vv	o3_v, o3_v, temp1_v, $0
	fxmul.vs	temp2_v, in3_v, t33_r, $0
	bne	in3_r, done_r, loop

exit:
	fxadd.vv	out3_v, o3_v, temp2_v, rshift_r
	sbai.v	out1_v, o1_r, len_r
	sbai.v	out2_v, o2_r, len_r
	sbai.v	out3_v, o3_r, len_r
	jr	ra

	.end enter_loop
