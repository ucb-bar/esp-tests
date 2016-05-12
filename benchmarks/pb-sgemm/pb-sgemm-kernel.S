	.text
	.file	"parallel.ll"
	.weak	pocl.barrier
	.align	2
	.type	pocl.barrier,@function
pocl.barrier:                           # @pocl.barrier
	.cfi_startproc
# BB#0:
	ret
Lfunc_end0:
	.size	pocl.barrier, Lfunc_end0-pocl.barrier
	.cfi_endproc

	.globl	_pocl_launcher_mysgemmNT
	.align	2
	.type	_pocl_launcher_mysgemmNT,@function
_pocl_launcher_mysgemmNT:               # @_pocl_launcher_mysgemmNT
# BB#0:
	li	x17, -4352
	add	x2, x2, x17
	li	x17, 4344
	add	x17, x2, x17
	sd	x1, 0(x17)              # 8-byte Folded Spill
	li	x1, 4336
	add	x1, x2, x1
	sd	x25, 0(x1)              # 8-byte Folded Spill
	li	x1, 4328
	add	x1, x2, x1
	sd	x24, 0(x1)              # 8-byte Folded Spill
	li	x1, 4320
	add	x1, x2, x1
	sd	x23, 0(x1)              # 8-byte Folded Spill
	li	x1, 4312
	add	x1, x2, x1
	sd	x22, 0(x1)              # 8-byte Folded Spill
	li	x1, 4304
	add	x1, x2, x1
	sd	x21, 0(x1)              # 8-byte Folded Spill
	li	x1, 4296
	add	x1, x2, x1
	sd	x20, 0(x1)              # 8-byte Folded Spill
	li	x1, 4288
	add	x1, x2, x1
	sd	x19, 0(x1)              # 8-byte Folded Spill
	li	x1, 4280
	add	x1, x2, x1
	sd	x18, 0(x1)              # 8-byte Folded Spill
	li	x1, 4272
	add	x1, x2, x1
	sd	x9, 0(x1)               # 8-byte Folded Spill
	li	x1, 4264
	add	x1, x2, x1
	sd	x8, 0(x1)               # 8-byte Folded Spill
	fcvt.d.s	f1, f17
	addi	x5, x11, 0
	addi	x6, x10, 0
	li	x8, 4360
	add	x8, x2, x8
	ld	x7, 0(x8)
	ld	x10, 32(x7)
	li	x8, 4192
	add	x8, x2, x8
	sd	x10, 0(x8)
	ld	x10, 40(x7)
	li	x8, 4184
	add	x8, x2, x8
	sd	x10, 0(x8)
	ld	x10, 56(x7)
	li	x8, 4176
	add	x8, x2, x8
	sd	x10, 0(x8)
	ld	x7, 64(x7)
	li	x8, 4168
	add	x8, x2, x8
	sd	x7, 0(x8)
	li	x8, 4232
	add	x8, x2, x8
	sd	x0, 0(x8)
	li	x8, 4224
	add	x8, x2, x8
	sd	x0, 0(x8)
	li	x8, 4216
	add	x8, x2, x8
	sd	x0, 0(x8)
	li	x7, 16
	li	x8, 4208
	add	x8, x2, x8
	sd	x7, 0(x8)
	li	x8, 4200
	add	x8, x2, x8
	sd	x7, 0(x8)
1:auipc x10, %pcrel_hi(pocl.barrier)
	addi	x17, x10, %pcrel_lo(1b)
	jalr	x1, x17, 0
	li	x8, 4224
	add	x8, x2, x8
	sd	x0, 0(x8)
	li	x8, 4352
	add	x8, x2, x8
	flw	f0, 0(x8)
	li	x8, 3136
	add	x8, x2, x8
	addi	x10, x8, 0
	li	x11, 1
	addi	x28, x2, 1088
	addi	x29, x2, 64
	fcvt.s.d	f1, f1
LBB1_1:                                 # %pregion_for_entry.pregion_for_init.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_2 Depth 2
                                        #       Child Loop BB1_4 Depth 3
	li	x8, 4232
	add	x8, x2, x8
	sd	x0, 0(x8)
LBB1_2:                                 # %pregion_for_entry.entry.i
                                        #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_4 Depth 3
	li	x24, 4216
	add	x24, x2, x24
	ld	x8, 0(x24)
	slli	x9, x8, 10
	add	x30, x10, x9
	li	x25, 4224
	add	x25, x2, x25
	ld	x20, 0(x25)
	slli	x18, x20, 6
	add	x30, x30, x18
	li	x25, 4232
	add	x25, x2, x25
	ld	x21, 0(x25)
	slli	x19, x21, 2
	add	x30, x30, x19
	li	x25, 4176
	add	x25, x2, x25
	ld	x1, 0(x25)
	li	x25, 4192
	add	x25, x2, x25
	ld	x22, 0(x25)
	li	x25, 4208
	add	x25, x2, x25
	ld	x23, 0(x25)
	li	x25, 4168
	add	x25, x2, x25
	ld	x31, 0(x25)
	li	x25, 4184
	add	x25, x2, x25
	ld	x24, 0(x25)
	li	x25, 4200
	add	x25, x2, x25
	ld	x25, 0(x25)
	sw	x0, 0(x30)
	mul	x24, x24, x25
	add	x31, x24, x31
	add	x31, x31, x20
	mul	x22, x22, x23
	add	x1, x22, x1
	add	x1, x1, x21
	blt	x16, x11, LBB1_6
# BB#3:                                 # %for.body.lr.ph.i
                                        #   in Loop: Header=BB1_2 Depth=2
	slli	x8, x8, 11
	add	x8, x28, x8
	slli	x20, x20, 7
	add	x8, x8, x20
	slli	x20, x21, 3
	add	x8, x8, x20
	sd	x0, 0(x8)
	add	x9, x29, x9
	add	x9, x9, x18
	add	x9, x9, x19
	sw	x0, 0(x9)
	slli	x18, x1, 32
	srai	x18, x18, 32
	slli	x19, x31, 32
	srai	x19, x19, 32
LBB1_4:                                 # %for.body.i
                                        #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	flw	f2, 0(x9)
	ld	x20, 0(x8)
	mul	x21, x20, x13
	add	x21, x21, x19
	slli	x21, x21, 2
	add	x21, x12, x21
	flw	f3, 0(x21)
	mul	x21, x20, x5
	add	x21, x21, x18
	slli	x21, x21, 2
	add	x21, x6, x21
	flw	f4, 0(x21)
	addi	x20, x20, 1
	sd	x20, 0(x8)
	fmul.s	f3, f4, f3
	fadd.s	f2, f2, f3
	fsw	f2, 0(x9)
	bne	x20, x16, LBB1_4
# BB#5:                                 # %for.cond.cleanup.loopexit.i
                                        #   in Loop: Header=BB1_2 Depth=2
	fsw	f2, 0(x30)
LBB1_6:                                 # %for.cond.cleanup.r_exit.i
                                        #   in Loop: Header=BB1_2 Depth=2
	flw	f2, 0(x30)
	fmul.s	f2, f2, f1
	mulw	x30, x31, x15
	addw	x30, x30, x1
	slli	x30, x30, 2
	add	x30, x14, x30
	flw	f3, 0(x30)
	fmul.s	f3, f3, f0
	fadd.s	f2, f2, f3
	fsw	f2, 0(x30)
	li	x8, 4232
	add	x8, x2, x8
	ld	x30, 0(x8)
	addi	x30, x30, 1
	li	x8, 4232
	add	x8, x2, x8
	sd	x30, 0(x8)
	bltu	x30, x7, LBB1_2
# BB#7:                                 # %pregion_for_end.i
                                        #   in Loop: Header=BB1_1 Depth=1
	li	x8, 4224
	add	x8, x2, x8
	ld	x30, 0(x8)
	addi	x30, x30, 1
	li	x8, 4224
	add	x8, x2, x8
	sd	x30, 0(x8)
	bltu	x30, x7, LBB1_1
# BB#8:                                 # %mysgemmNT.exit
	jalr	x1, x17, 0
	li	x1, 4264
	add	x1, x2, x1
	ld	x8, 0(x1)               # 8-byte Folded Reload
	li	x1, 4272
	add	x1, x2, x1
	ld	x9, 0(x1)               # 8-byte Folded Reload
	li	x10, 4280
	add	x10, x2, x10
	ld	x18, 0(x10)             # 8-byte Folded Reload
	li	x10, 4288
	add	x10, x2, x10
	ld	x19, 0(x10)             # 8-byte Folded Reload
	li	x10, 4296
	add	x10, x2, x10
	ld	x20, 0(x10)             # 8-byte Folded Reload
	li	x10, 4304
	add	x10, x2, x10
	ld	x21, 0(x10)             # 8-byte Folded Reload
	li	x10, 4312
	add	x10, x2, x10
	ld	x22, 0(x10)             # 8-byte Folded Reload
	li	x10, 4320
	add	x10, x2, x10
	ld	x23, 0(x10)             # 8-byte Folded Reload
	li	x10, 4328
	add	x10, x2, x10
	ld	x24, 0(x10)             # 8-byte Folded Reload
	li	x10, 4336
	add	x10, x2, x10
	ld	x25, 0(x10)             # 8-byte Folded Reload
	li	x10, 4344
	add	x10, x2, x10
	ld	x1, 0(x10)              # 8-byte Folded Reload
	li	x10, 4352
	add	x2, x2, x10
	ret
Lfunc_end1:
	.size	_pocl_launcher_mysgemmNT, Lfunc_end1-_pocl_launcher_mysgemmNT

	.globl	_pocl_launcher_mysgemmNT_workgroup
	.align	2
	.type	_pocl_launcher_mysgemmNT_workgroup,@function
_pocl_launcher_mysgemmNT_workgroup:     # @_pocl_launcher_mysgemmNT_workgroup
	.cfi_startproc
# BB#0:
	addi	x2, x2, -32
Ltmp0:
	.cfi_def_cfa_offset 32
	sd	x1, 24(x2)              # 8-byte Folded Spill
Ltmp1:
	.cfi_offset f1, -8
	ld	x5, 56(x10)
	flw	f17, 0(x5)
	ld	x5, 48(x10)
	lw	x16, 0(x5)
	ld	x5, 40(x10)
	lw	x15, 0(x5)
	ld	x5, 32(x10)
	ld	x14, 0(x5)
	ld	x5, 24(x10)
	lw	x13, 0(x5)
	ld	x5, 16(x10)
	ld	x12, 0(x5)
	ld	x5, 8(x10)
	lw	x5, 0(x5)
	ld	x6, 0(x10)
	ld	x6, 0(x6)
	ld	x7, 64(x10)
	flw	f0, 0(x7)
	sd	x11, 8(x2)
	fsw	f0, 0(x2)
1:auipc x7, %pcrel_hi(_pocl_launcher_mysgemmNT)
	addi	x7, x7, %pcrel_lo(1b)
	addi	x10, x6, 0
	addi	x11, x5, 0
	jalr	x1, x7, 0
	ld	x1, 24(x2)              # 8-byte Folded Reload
	addi	x2, x2, 32
	ret
Lfunc_end2:
	.size	_pocl_launcher_mysgemmNT_workgroup, Lfunc_end2-_pocl_launcher_mysgemmNT_workgroup
	.cfi_endproc

	.globl	_pocl_launcher_mysgemmNT_workgroup_fast
	.align	2
	.type	_pocl_launcher_mysgemmNT_workgroup_fast,@function
_pocl_launcher_mysgemmNT_workgroup_fast: # @_pocl_launcher_mysgemmNT_workgroup_fast
	.cfi_startproc
# BB#0:
	addi	x2, x2, -32
Ltmp2:
	.cfi_def_cfa_offset 32
	sd	x1, 24(x2)              # 8-byte Folded Spill
Ltmp3:
	.cfi_offset f1, -8
	ld	x14, 32(x10)
	ld	x12, 16(x10)
	ld	x5, 0(x10)
	ld	x6, 56(x10)
	flw	f17, 0(x6)
	ld	x6, 48(x10)
	lw	x16, 0(x6)
	ld	x6, 40(x10)
	lw	x15, 0(x6)
	ld	x6, 24(x10)
	lw	x13, 0(x6)
	ld	x6, 8(x10)
	lw	x6, 0(x6)
	ld	x7, 64(x10)
	flw	f0, 0(x7)
	sd	x11, 8(x2)
	fsw	f0, 0(x2)
1:auipc x7, %pcrel_hi(_pocl_launcher_mysgemmNT)
	addi	x7, x7, %pcrel_lo(1b)
	addi	x10, x5, 0
	addi	x11, x6, 0
	jalr	x1, x7, 0
	ld	x1, 24(x2)              # 8-byte Folded Reload
	addi	x2, x2, 32
	ret
Lfunc_end3:
	.size	_pocl_launcher_mysgemmNT_workgroup_fast, Lfunc_end3-_pocl_launcher_mysgemmNT_workgroup_fast
	.cfi_endproc


