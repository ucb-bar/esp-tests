	.text
	.file	"pocl/OI/OPPEJADLIIGEFMGNAFOFFCCFABHHEDNBDBCNO/spmv_jds_naive/32-1-1/target_parallel.bc"
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

	.globl	_pocl_launcher_spmv_jds_naive
	.align	2
	.type	_pocl_launcher_spmv_jds_naive,@function
_pocl_launcher_spmv_jds_naive:          # @_pocl_launcher_spmv_jds_naive
# BB#0:
	addi	x2, x2, -768
	sd	x1, 760(x2)             # 8-byte Folded Spill
	sd	x22, 752(x2)            # 8-byte Folded Spill
	sd	x21, 744(x2)            # 8-byte Folded Spill
	sd	x20, 736(x2)            # 8-byte Folded Spill
	sd	x19, 728(x2)            # 8-byte Folded Spill
	sd	x18, 720(x2)            # 8-byte Folded Spill
	sd	x9, 712(x2)             # 8-byte Folded Spill
	sd	x8, 704(x2)             # 8-byte Folded Spill
	addi	x5, x11, 0
	addi	x6, x10, 0
	ld	x7, 768(x2)
	ld	x10, 32(x7)
	sd	x10, 640(x2)
	ld	x7, 56(x7)
	sd	x7, 632(x2)
	sd	x0, 672(x2)
	sd	x0, 664(x2)
	sd	x0, 656(x2)
	li	x7, 32
	sd	x7, 648(x2)
1:auipc x10, %pcrel_hi(pocl.barrier)
	addi	x28, x10, %pcrel_lo(1b)
	jalr	x1, x28, 0
	sd	x0, 672(x2)
	addi	x10, x2, 448
	li	x11, 1
	addi	x29, x2, 192
	addi	x30, x2, 64
LBB1_1:                                 # %pregion_for_entry.entry.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_4 Depth 2
	ld	x31, 648(x2)
	ld	x1, 640(x2)
	mul	x31, x1, x31
	ld	x1, 632(x2)
	add	x31, x31, x1
	ld	x9, 672(x2)
	add	x31, x31, x9
	bge	x31, x15, LBB1_7
# BB#2:                                 # %if.then.i
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	x18, 664(x2)
	ld	x19, 656(x2)
	sraiw	x1, x31, 31
	srliw	x1, x1, 27
	addw	x1, x31, x1
	sraiw	x1, x1, 5
	slli	x1, x1, 2
	add	x1, x17, x1
	lw	x8, 0(x1)
	slli	x20, x19, 7
	add	x1, x10, x20
	slli	x21, x18, 7
	add	x1, x1, x21
	slli	x22, x9, 2
	add	x1, x1, x22
	sw	x0, 0(x1)
	blt	x8, x11, LBB1_6
# BB#3:                                 # %for.body.preheader.i
                                        #   in Loop: Header=BB1_1 Depth=1
	slli	x19, x19, 8
	add	x19, x29, x19
	slli	x18, x18, 8
	add	x18, x19, x18
	slli	x9, x9, 3
	add	x9, x18, x9
	sd	x0, 0(x9)
	add	x18, x30, x20
	add	x18, x18, x21
	add	x18, x18, x22
	sw	x0, 0(x18)
LBB1_4:                                 # %for.body.i
                                        #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	flw	f0, 0(x18)
	ld	x19, 0(x9)
	slli	x20, x19, 2
	add	x20, x16, x20
	lw	x20, 0(x20)
	addw	x20, x20, x31
	slli	x20, x20, 2
	add	x21, x5, x20
	flw	f1, 0(x21)
	add	x20, x12, x20
	lw	x20, 0(x20)
	slli	x20, x20, 2
	add	x20, x14, x20
	flw	f2, 0(x20)
	addi	x19, x19, 1
	sd	x19, 0(x9)
	fmul.s	f1, f1, f2
	fadd.s	f0, f0, f1
	fsw	f0, 0(x18)
	bne	x19, x8, LBB1_4
# BB#5:                                 # %for.cond.cleanup.loopexit.i
                                        #   in Loop: Header=BB1_1 Depth=1
	fsw	f0, 0(x1)
LBB1_6:                                 # %for.cond.cleanup.i
                                        #   in Loop: Header=BB1_1 Depth=1
	slli	x31, x31, 32
	srai	x31, x31, 30
	add	x31, x13, x31
	lw	x31, 0(x31)
	slli	x31, x31, 2
	add	x31, x6, x31
	flw	f0, 0(x1)
	fsw	f0, 0(x31)
LBB1_7:                                 # %if.end.r_exit.i
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	x31, 672(x2)
	addi	x31, x31, 1
	sd	x31, 672(x2)
	bltu	x31, x7, LBB1_1
# BB#8:                                 # %spmv_jds_naive.exit
	jalr	x1, x28, 0
	ld	x8, 704(x2)             # 8-byte Folded Reload
	ld	x9, 712(x2)             # 8-byte Folded Reload
	ld	x18, 720(x2)            # 8-byte Folded Reload
	ld	x19, 728(x2)            # 8-byte Folded Reload
	ld	x20, 736(x2)            # 8-byte Folded Reload
	ld	x21, 744(x2)            # 8-byte Folded Reload
	ld	x22, 752(x2)            # 8-byte Folded Reload
	ld	x1, 760(x2)             # 8-byte Folded Reload
	addi	x2, x2, 768
	ret
Lfunc_end1:
	.size	_pocl_launcher_spmv_jds_naive, Lfunc_end1-_pocl_launcher_spmv_jds_naive

	.globl	_pocl_launcher_spmv_jds_naive_workgroup
	.align	2
	.type	_pocl_launcher_spmv_jds_naive_workgroup,@function
_pocl_launcher_spmv_jds_naive_workgroup: # @_pocl_launcher_spmv_jds_naive_workgroup
	.cfi_startproc
# BB#0:
	addi	x2, x2, -16
Ltmp0:
	.cfi_def_cfa_offset 16
	sd	x1, 8(x2)               # 8-byte Folded Spill
Ltmp1:
	.cfi_offset f1, -8
	ld	x5, 56(x10)
	ld	x17, 0(x5)
	ld	x5, 48(x10)
	ld	x16, 0(x5)
	ld	x5, 40(x10)
	lw	x15, 0(x5)
	ld	x5, 32(x10)
	ld	x14, 0(x5)
	ld	x5, 24(x10)
	ld	x13, 0(x5)
	ld	x5, 16(x10)
	ld	x12, 0(x5)
	ld	x5, 8(x10)
	ld	x5, 0(x5)
	ld	x6, 0(x10)
	ld	x10, 0(x6)
	sd	x11, 0(x2)
1:auipc x6, %pcrel_hi(_pocl_launcher_spmv_jds_naive)
	addi	x6, x6, %pcrel_lo(1b)
	addi	x11, x5, 0
	jalr	x1, x6, 0
	ld	x1, 8(x2)               # 8-byte Folded Reload
	addi	x2, x2, 16
	ret
Lfunc_end2:
	.size	_pocl_launcher_spmv_jds_naive_workgroup, Lfunc_end2-_pocl_launcher_spmv_jds_naive_workgroup
	.cfi_endproc

	.globl	_pocl_launcher_spmv_jds_naive_workgroup_fast
	.align	2
	.type	_pocl_launcher_spmv_jds_naive_workgroup_fast,@function
_pocl_launcher_spmv_jds_naive_workgroup_fast: # @_pocl_launcher_spmv_jds_naive_workgroup_fast
	.cfi_startproc
# BB#0:
	addi	x2, x2, -16
Ltmp2:
	.cfi_def_cfa_offset 16
	sd	x1, 8(x2)               # 8-byte Folded Spill
Ltmp3:
	.cfi_offset f1, -8
	ld	x17, 56(x10)
	ld	x16, 48(x10)
	ld	x14, 32(x10)
	ld	x13, 24(x10)
	ld	x12, 16(x10)
	ld	x5, 8(x10)
	ld	x6, 0(x10)
	ld	x7, 40(x10)
	lw	x15, 0(x7)
	sd	x11, 0(x2)
1:auipc x7, %pcrel_hi(_pocl_launcher_spmv_jds_naive)
	addi	x7, x7, %pcrel_lo(1b)
	addi	x10, x6, 0
	addi	x11, x5, 0
	jalr	x1, x7, 0
	ld	x1, 8(x2)               # 8-byte Folded Reload
	addi	x2, x2, 16
	ret
Lfunc_end3:
	.size	_pocl_launcher_spmv_jds_naive_workgroup_fast, Lfunc_end3-_pocl_launcher_spmv_jds_naive_workgroup_fast
	.cfi_endproc


