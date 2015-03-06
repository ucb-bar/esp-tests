// See LICENSE for license details.

#ifndef __TEST_MACROS_VECTOR_H
#define __TEST_MACROS_VECTOR_H

#undef EXTRA_INIT
#define EXTRA_INIT RVTEST_VEC_ENABLE

#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------

#define TEST_CASE( testnum, testreg, correctval, code... ) \
  TEST_CASE_NREG( testnum, 32, testreg, correctval, 0, 0, code )

# We use j fail, because for some cases branches are not enough to jump to fail

#define TEST_CASE_NREG( testnum, nxreg, testreg, correctval, val1, val2, code... ) \
test_ ## testnum: \
  vsetcfg nxreg,1; \
  li a3,2048; \
  vsetvl a3,a3; \
  la a4,dst; \
  vmsa va4, a4; \
  li a4, val1; \
  vmss vs1, a4; \
  li a4, val2; \
  vmss vs2, a4; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  fence; \
  li a1,correctval; \
  li a2,0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,8; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j next ## testnum; \
vtcode ## testnum : \
  code; \
  vsd v ## testreg, va4; \
  vstop; \
next ## testnum :

# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.

#define TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_1  nop; TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_2  nop; TEST_INSERT_NOPS_1
#define TEST_INSERT_NOPS_3  nop; TEST_INSERT_NOPS_2
#define TEST_INSERT_NOPS_4  nop; TEST_INSERT_NOPS_3
#define TEST_INSERT_NOPS_5  nop; TEST_INSERT_NOPS_4
#define TEST_INSERT_NOPS_6  nop; TEST_INSERT_NOPS_5
#define TEST_INSERT_NOPS_7  nop; TEST_INSERT_NOPS_6
#define TEST_INSERT_NOPS_8  nop; TEST_INSERT_NOPS_7
#define TEST_INSERT_NOPS_9  nop; TEST_INSERT_NOPS_8
#define TEST_INSERT_NOPS_10 nop; TEST_INSERT_NOPS_9


#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
# TODO: update sext for 32 bit immedaites?
#-----------------------------------------------------------------------

#define SEXT_IMM(x) ((x) | (-(((x) >> 11) & 1) << 11))

#define TEST_IMM_OP( testnum, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      vadd 1,0,0,  vx3, vs3, vs0; \
    )

#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, x1, result, val1, 0, \
      v ## inst vs1, vs1, SEXT_IMM(imm); \
      vadd 1,0,0,  vx1, vs1, vs0; \
    )

#define TEST_IMM_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 5, x4, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd 1,0,0,  vx4, vs3, vs0; \
    )

#define TEST_IMM_SRC1_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, 0, \
      vadd 0,0,0,  vs1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      vadd 1,0,0,  vx3, vs3, vs0; \
    )

#define TEST_IMM_ZEROSRC1( testnum, inst, result, imm ) \
    TEST_CASE_NREG( testnum, 2, x1, result, 0, 0, \
      v ## inst vs1, vs0, SEXT_IMM(imm); \
      vadd 1,0,0,  vx1, vs1, vs0; \
    )

#define TEST_IMM_ZERODEST( testnum, inst, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, x0, 0, val1, 0, \
      v ## inst vs0, vs1, SEXT_IMM(imm); \
      vadd 1,0,0,  vx0, vs0, vs0; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------

#define TEST_R_OP( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1, vx3, vx1; \
    )

#define TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, x1, result, val1, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1, vx1, vx1; \
    )

#define TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 5, x4, result, val1, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1, vx3, vx1; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd 1,1,0, vx4, vx3, vs0; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      v ## inst 1,1,1, vx3, vx1, vx2; \
    )

#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, x1, result, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      v ## inst 1,1,1, vx1, vx1, vx2; \
    )

#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, x2, result, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      v ## inst 1,1,1, vx2, vx1, vx2; \
    )

#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, x1, result, val1, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1,1, vx1, vx1, vx1; \
    )

#define TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 5, x4, result, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      v ## inst 1,1,1, vx3, vx1, vx2; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd 1,1,0, vx4, vx3, vs0; \
    )

#define TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd 1,0,0,  vx2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst 1,1,1, vx3, vx1, vx2; \
    )

#define TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, x3, result, val1, val2, \
      vadd 1,0,0,  vx2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd 1,0,0,  vx1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst 1,1,1, vx3, vx1, vx2; \
    )

#define TEST_RR_ZEROSRC1( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, x2, result, val, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1,1, vx2, vx0, vx1; \
    )

#define TEST_RR_ZEROSRC2( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, x2, result, val, 0, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      v ## inst 1,1,1, vx2, vx1, vx0; \
    )

#define TEST_RR_ZEROSRC12( testnum, inst, result ) \
    TEST_CASE_NREG( testnum, 2, x1, result, 0, 0, \
      v ## inst 1,1,1, vx1, vx0, vx0; \
    )

#define TEST_RR_ZERODEST( testnum, inst, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, x0, 0, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      v ## inst 1,1,1, vx0, vx1, vx2; \
    )


#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------

#define TEST_FP_OP_S_INTERNAL_NREG( testnum, nxreg, nfreg, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  vsetcfg nxreg,nfreg; \
  li a3,2048; \
  vsetvl a3,a3; \
  la  a5, test_ ## testnum ## _data ;\
  vmsa va3, a5; \
  addi a5,a5,4; \
  vmsa va4, a5; \
  addi a5,a5,4; \
  vmsa va5, a5; \
  addi a5,a5,4; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  la a4,dst; \
  vmsa va6,a4; \
  fence; \
  lw  a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  lw a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,4; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j 1f; \
vtcode ## testnum : \
  vlw vx2, va3; \
  vlw vx3, va4; \
  vlw vx4, va5; \
  code; \
  vsw vx1, va6; \
  vstop; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float val3; \
  .result; \
1:

#define TEST_FP_OP_D_INTERNAL_NREG( testnum, nxreg, nfreg, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  vsetcfg nxreg,nfreg; \
  li a3,2048; \
  vsetvl a3,a3; \
  la  a5, test_ ## testnum ## _data ;\
  vmsa va3, a5; \
  addi a5,a5,8; \
  vmsa va4, a5; \
  addi a5,a5,8; \
  vmsa va5, a5; \
  addi a5,a5,8; \
  la a4,dst; \
  vmsa va6, a4; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  fence; \
  ld  a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,8; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j 1f; \
vtcode ## testnum : \
  vld vx2, va3; \
  vld vx3, va4; \
  vld vx4, va5; \
  code; \
  vsd vx1, va6; \
  vstop; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
1:

#define TEST_FCVT_S_D( testnum, result, val1 ) \
  TEST_FP_OP_D_INTERNAL_NREG( testnum, 6, 1, double result, val1, 0.0, 0.0, \
                    vfcvt.s.d 1,1, vx5, vx2; vfcvt.d.s 1,1, vx1, vx5)

#define TEST_FCVT_D_S( testnum, result, val1 ) \
  TEST_FP_OP_S_INTERNAL_NREG( testnum, 6, 1, float result, val1, 0.0, 0.0, \
                    vfcvt.d.s 1,1, vx5, vx2; vfcvt.s.d 1,1, vx1, vx5)

#define TEST_FP_OP2_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL_NREG( testnum, 6, 1, float result, val1, val2, 0.0, \
                    v ## inst 1,1,1, vx1, vx2, vx3)

#define TEST_FP_OP2_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_NREG( testnum, 6, 1, double result, val1, val2, 0.0, \
                    v ## inst 1,1,1, vx1, vx2, vx3)

#define TEST_FP_OP3_S( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_S_INTERNAL_NREG( testnum, 6, 1, float result, val1, val2, val3, \
                    v ## inst 1,1,1,1, vx1, vx2, vx3, vx4)

#define TEST_FP_OP3_D( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_D_INTERNAL_NREG( testnum, 6, 1, double result, val1, val2, val3, \
                    v ## inst 1,1,1,1, vx1, vx2, vx3, vx4)

#define TEST_FP_INT_OP_S( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_S_INTERNAL_NREG( testnum, 6, 1, word result, val1, 0.0, 0.0, \
                    v ## inst 1,1, vx1, vx2, rm)

#define TEST_FP_INT_OP_D( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_D_INTERNAL_NREG( testnum, 6, 1, dword result, val1, 0.0, 0.0, \
                    v ## inst 1,1, vx1, vx2, rm)

#define TEST_FP_CMP_OP_S( testnum, inst, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL_NREG( testnum, 6, 2, word result, val1, val2, 0.0, \
                    vcmp ## inst 1,1, vp1, vx2, vx3;\
                    vaddi vs1,vs0,1; @vp1 vadd 1,0,0, vx1,vs0,vs1;\
                    @!vp1 vadd 1,0,0, vx1,vs0,vs0 )

#define TEST_FP_CMP_OP_D( testnum, inst, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_NREG( testnum, 6, 2, dword result, val1, val2, 0.0, \
                    vcmp ## inst 1,1, vp1, vx2, vx3;\
                    vaddi vs1,vs0,1; @vp1 vadd 1,0,0, vx1,vs0,vs1;\
                    @!vp1 vadd 1,0,0, vx1,vs0,vs0 )

#define TEST_INT_FP_OP_S( testnum, inst, result, val1 ) \
test_ ## testnum: \
  vsetcfg 2,0; \
  li a3,2048; \
  vsetvl a3,a3; \
  la a4,dst; \
  vmsa va4, a4; \
  li a5, val1; \
  vmss vs1, a5; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  fence; \
  la  a5, test_ ## testnum ## _data ;\
  lw  a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  lw a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,4; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j 1f; \
vtcode ## testnum : \
  vadd 1,0,0, vx1, vs1, vs0; \
  v ## inst 1,1, vx1, vx1; \
  vsw vx1, va4; \
  vstop; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float result; \
1:

#define TEST_INT_FP_OP_D( testnum, inst, result, val1 ) \
test_ ## testnum: \
  vsetcfg 2,0; \
  li a3,2048; \
  vsetvl a3,a3; \
  la a4,dst; \
  vmsa va4, a4; \
  li a5, val1; \
  vmss vs1, a5; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  fence; \
  la  a5, test_ ## testnum ## _data ;\
  ld  a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,8; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j 1f; \
vtcode ## testnum : \
  vadd 1,0,0, vx1, vs1, vs0; \
  v ## inst 1,1, vx1, vx1; \
  vsd vx1, va4; \
  vstop; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double result; \
1:


#-----------------------------------------------------------------------
# RV64UV MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Test branch instructions
#-----------------------------------------------------------------------

#define TEST_BR2_OP_TAKEN( testnum, inst, val1, val2) \
    TEST_CASE_NREG( testnum, 4, x3, 0, val1, val2, \
      vadd 1,0,0,  vx1, vs1, vs0; \
      vadd 1,0,0,  vx2, vs2, vs0; \
      vadd vx3, vx0, vx0; \
      v ## inst vx1, vx2, 2f; \
      addi vx3, vx3, 1; \
1:    j 3f; \
      addi vx3, vx3, 4; \
2:    v ## inst vx1, vx2, 1b; \
      addi vx3, vx3, 2; \
3: \
    )

#define TEST_BR2_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 4, x3, 0, val1, val2, \
    vadd 1,0,0,  vx1, vs1, vs0; \
    vadd 1,0,0,  vx2, vs2, vs0; \
    add vx3, vx0, vx0; \
    v ## inst vx1, vx2, 1f; \
    j 2f; \
1:  addi vx3, vx3, 1; \
    j 3f; \
2:  v ## inst vx1, vx2, 1b; \
3: \
                  )

#define TEST_BR2_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 6, x3, 0, val1, val2, \
    add vx3, vx0, vx0; \
    li  vx4, 0; \
1:  vadd 1,0,0,  vx1, vs1, vs0; \
    TEST_INSERT_NOPS_ ## src1_nops \
    vadd 1,0,0,  vx2, vs2, vs0; \
    TEST_INSERT_NOPS_ ## src2_nops \
    v ## inst vx1, vx2, 2f; \
    addi  vx4, vx4, 1; \
    li  vx5, 2; \
    bne vx4, vx5, 1b; \
    j 3f; \
2:  add vx3, vx3, 1; \
3:  \
  )

#define TEST_BR2_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 6, x3, 0, val1, val2, \
    add vx3, vx0, vx0; \
    li  vx4, 0; \
1:  vadd 1,0,0,  vx2, vs2, vs0; \
    TEST_INSERT_NOPS_ ## src1_nops \
    vadd 1,0,0,  vx1, vs1, vs0; \
    TEST_INSERT_NOPS_ ## src2_nops \
    v ## inst vx1, vx2, 2f; \
    addi  vx4, vx4, 1; \
    li  vx5, 2; \
    bne vx4, vx4, 1b; \
    j 3f; \
2:  add vx3, vx3, 1; \
3: \
                  )

#define TEST_BR2_DIVERGED_ODD_EVEN( testnum, inst, n, result, code...)   \
  TEST_CASE_NREG( testnum, 5, x3, result, 0, 0, \
    utidx vx1; \
    andi vx2, vx1, 1;\
    add vx3, vx0, vx0; \
    li vx4, n; \
1: \
    beq vx0, vx2, 2f; \
    code; \
    j 3f; \
2: \
    code; \
3: \
    addi vx4, vx4, -1; \
    bne vx4, vx0, 1b; \
                  )

#define TEST_BR2_DIVERGED_FULL12( testnum, inst, n, result, code... )    \
  TEST_CASE_NREG( testnum, 5, x3, result, 0, 0, \
    utidx vx1; \
    sltiu vx2, vx1, 1; \
    add vx3, vx0, vx0; \
    li vx4, n; \
1: \
    v ## inst vx2, vx4, 2f; \
    addi vx1, vx1, -1; \
    sltiu vx2, vx1, 1; \
    j 1b; \
2: \
    code; \
                 )

#define TEST_BR2_DIVERGED_FULL21( testnum, inst, n, result, code... )    \
  TEST_CASE_NREG( testnum, 5, x3, result, 0, 0, \
    utidx vx1; \
    sltiu vx2, vx1, 1; \
    add vx3, vx0, vx0; \
    li vx4, n; \
1: \
    v ## inst vx4, vx2, 2f; \
    addi vx1, vx1, -1; \
    sltiu vx2, vx1, 1; \
    j 1b; \
2: \
    code; \
                 )

#define TEST_CASE_NREG_MEM( testnum, nxreg, nfreg, correctval, code... ) \
test_ ## testnum: \
  vsetcfg nxreg,nfreg; \
  li a3,2048; \
  vsetvl a3,a3; \
  lui a0,%hi(vtcode ## testnum ); \
  vf %lo(vtcode ## testnum )(a0); \
  la a4,dst; \
  fence; \
  li a1,correctval; \
  li a2,0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,8; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j next ## testnum; \
vtcode ## testnum : \
  code; \
  stop; \
next ## testnum :

#define TEST_BR2_DIVERGED_MEM_FULL12( testnum, inst, n) \
  TEST_CASE_NREG_MEM( testnum, 7, 0, 1, \
    utidx vx5; \
    slli vx5, vx5, 3; \
    la vx6, dst; \
    add vx5, vx5, vx6; \
    sd vx0, 0(x5); \
    utidx vx1; \
    sltiu vx2, vx1, 1; \
    li vx4, n; \
1: \
    v ## inst vx2, vx4, 2f; \
    addi vx1, vx1, -1; \
    sltiu vx2, vx1, 1; \
    j 1b; \
2: \
    ld vx3, 0(x5); \
    addi vx3, vx3, 1; \
    sd vx3, 0(x5); \
                 )

#define TEST_BR2_DIVERGED_MEM_FULL21( testnum, inst, n) \
  TEST_CASE_NREG_MEM( testnum, 7, 0, 1, \
    utidx vx5; \
    slli vx5, vx5, 3; \
    la vx6, dst; \
    add vx5, vx5, vx6; \
    sd vx0, 0(x5); \
    utidx vx1; \
    sltiu vx2, vx1, 1; \
    li vx4, n; \
1: \
    v ## inst vx4, vx2, 2f; \
    addi vx1, vx1, -1; \
    sltiu vx2, vx1, 1; \
    j 1b; \
2: \
    ld vx3, 0(x5); \
    addi vx3, vx3, 1; \
    sd vx3, 0(x5); \
                 )

#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in TESTNUM)
#-----------------------------------------------------------------------

#define TEST_PASSFAIL \
        bne x0, TESTNUM, pass; \
fail: \
        RVTEST_FAIL \
pass: \
        RVTEST_PASS \


#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------

#define TEST_DATA \
        .data; \
        .align 3; \
dst: \
        .skip 16384; \

#endif
