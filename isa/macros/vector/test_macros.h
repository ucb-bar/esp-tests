// See LICENSE for license details.

#ifndef __TEST_MACROS_VECTOR_H
#define __TEST_MACROS_VECTOR_H

// remove to disable VRU
#define VRU_ENABLE

#ifdef VRU_ENABLE
// because gcc complains about shifting without L
#define VRU_SWITCH 0x8000000000000000
#else
#define VRU_SWITCH 0x0
#endif

#define VCFG(nvvd, nvvw, nvvh, nvp) \
  (((nvvd) & 0x1ff) | \
  (((nvp) & 0x1f) << 9) | \
  (((nvvw) & 0x1ff) << 14) | \
  (((nvvh) & 0x1ff) << 23) | \
  (VRU_SWITCH))

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
  li a3, VCFG(nxreg, 0, 0, 1); \
  vsetcfg a3; \
  li a3,2048; \
  vsetvl a3,a3; \
  li a4, val1; \
  vmcs vs1, a4; \
  li a4, val2; \
  vmcs vs2, a4; \
  la a4,dst; \
  vmca va4, a4; \
1:auipc a0,%pcrel_hi(vtcode ## testnum); \
  vf %pcrel_lo(1b)(a0); \
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
.align 3; \
vtcode ## testnum : \
  vpset vp0; \
  code; \
  vsd v ## testreg, va4; \
  vstop; \
next ## testnum :

# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.

#define TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_1  vnop; TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_2  vnop; TEST_INSERT_NOPS_1
#define TEST_INSERT_NOPS_3  vnop; TEST_INSERT_NOPS_2
#define TEST_INSERT_NOPS_4  vnop; TEST_INSERT_NOPS_3
#define TEST_INSERT_NOPS_5  vnop; TEST_INSERT_NOPS_4
#define TEST_INSERT_NOPS_6  vnop; TEST_INSERT_NOPS_5
#define TEST_INSERT_NOPS_7  vnop; TEST_INSERT_NOPS_6
#define TEST_INSERT_NOPS_8  vnop; TEST_INSERT_NOPS_7
#define TEST_INSERT_NOPS_9  vnop; TEST_INSERT_NOPS_8
#define TEST_INSERT_NOPS_10 vnop; TEST_INSERT_NOPS_9


#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
# TODO: update sext for 32 bit immedaites?
#-----------------------------------------------------------------------

#define SEXT_IMM(x) ((x) | (-(((x) >> 11) & 1) << 11))

#define TEST_IMM_OP( testnum, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      vadd.ss  vv3, vs3, vs0; \
    )

#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, v1, result, val1, 0, \
      v ## inst vs1, vs1, SEXT_IMM(imm); \
      vadd.ss  vv1, vs1, vs0; \
    )

#define TEST_IMM_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 5, v4, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd.ss  vv4, vs3, vs0; \
    )

#define TEST_IMM_SRC1_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, 0, \
      TEST_INSERT_NOPS_ ## nop_cycles \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      vadd.ss  vv3, vs3, vs0; \
    )

#define TEST_IMM_ZEROSRC1( testnum, inst, result, imm ) \
    TEST_CASE_NREG( testnum, 2, v1, result, 0, 0, \
      v ## inst vs1, vs0, SEXT_IMM(imm); \
      vadd.ss  vv1, vs1, vs0; \
    )

#define TEST_IMM_ZERODEST( testnum, inst, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, v0, 0, val1, 0, \
      v ## inst vs0, vs1, SEXT_IMM(imm); \
      vadd.ss  vv0, vs0, vs0; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------

#define TEST_R_OP( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.v vv3, vv1; \
    )

#define TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, v1, result, val1, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.v vv1, vv1; \
    )

#define TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 5, v4, result, val1, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.v vv3, vv1; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd.vs vv4, vv3, vs0; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      v ## inst.vv vv3, vv1, vv2; \
    )

#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, v1, result, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      v ## inst.vv vv1, vv1, vv2; \
    )

#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, v2, result, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      v ## inst.vv vv2, vv1, vv2; \
    )

#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, v1, result, val1, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.vv vv1, vv1, vv1; \
    )

#define TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 5, v4, result, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      v ## inst.vv vv3, vv1, vv2; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd.vs vv4, vv3, vs0; \
    )

#define TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd.ss  vv2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst.vv vv3, vv1, vv2; \
    )

#define TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, v3, result, val1, val2, \
      vadd.ss  vv2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd.ss  vv1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst.vv vv3, vv1, vv2; \
    )

#define TEST_RR_ZEROSRC1( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, v2, result, val, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.sv vv2, vs0, vv1; \
    )

#define TEST_RR_ZEROSRC2( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, v2, result, val, 0, \
      vadd.ss  vv1, vs1, vs0; \
      v ## inst.vs vv2, vv1, vs0; \
    )

#define TEST_RR_ZEROSRC12( testnum, inst, result ) \
    TEST_CASE_NREG( testnum, 2, v1, result, 0, 0, \
      v ## inst.ss vv1, vs0, vs0; \
    )

#define TEST_RR_ZERODEST( testnum, inst, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, v0, 0, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      v ## inst.vv vv0, vv1, vv2; \
      v ## inst.ss vv0, vs0, vs0; \
    )

#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
#define qNaNf 0f:7fc00000
#define sNaNf 0f:7f800001
#define qNaN 0d:7ff8000000000000
#define sNaN 0d:7ff0000000000001

#define TEST_FP_OP_INTERNAL_NREG( testnum, nxreg, npreg, result, val1, val2, val3, vload, vstore, load, lskip, code... ) \
test_ ## testnum: \
  li a3, VCFG(nxreg, 0, 0, npreg); \
  vsetcfg a3; \
  li a3,2048; \
  vsetvl a3,a3; \
  la a5, 3f; vmca va3, a5; \
  la a5, 4f; vmca va4, a5; \
  la a5, 5f; vmca va5, a5; \
  la a5, 6f; \
  la a4, dst; vmca va6,a4; \
1:auipc a0,%pcrel_hi(vtcode ## testnum); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
  load a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
test_loop ## testnum: \
  load a0, 0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  addi a4,a4,lskip; \
  addi a2,a2,1; \
  bne a2,a3,test_loop ## testnum; \
  j 1f; \
.align 3; \
vtcode ## testnum : \
  vpset vp0; \
  vload vs2, va3; \
  vload vs3, va4; \
  vload vs4, va5; \
  vadd.ss vv2, vs2, vs0; \
  vadd.ss vv3, vs3, vs0; \
  vadd.ss vv4, vs4, vs0; \
  code; \
  vstore vv1, va6; \
  vstop; \
  test_ ## testnum ## _data: \
  .align 3; \
3:.val1; \
4:.val2; \
5:.val3; \
  .align 3; \
6:.result; \
1:

#define TEST_FCVT_S_D( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double 0.0, double 0.0, vlad, vsd, ld, 8, \
                    vfcvt.s.d.v vv5, vv2; vfcvt.d.s.v vv1, vv5)

#define TEST_FCVT_D_S( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float 0.0, float 0.0, vlaw, vsw, lw, 4, \
                    vfcvt.d.s.v vv5, vv2; vfcvt.s.d.v vv1, vv5)

#define TEST_FP_OP1_S( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float 0.0, float 0.0, vlaw, vsw, lw, 4, \
                    v ## inst.v vv1, vv2)

#define TEST_FP_OP1_D( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double 0.0, double 0.0, vlad, vsd, ld, 8, \
                    v ## inst.v vv1, vv2)

#define TEST_FP_OP1_S_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, float val1, float 0.0, float 0.0, vlaw, vsw, lw, 4, \
                    v ## inst.v vv1, vv2)

#define TEST_FP_OP1_D_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, double val1, double 0.0, double 0.0, vlad, vsd, ld, 8, \
                    v ## inst.v vv1, vv2)

#define TEST_FP_OP2_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float val2, float 0.0, vlaw, vsw, lw, 4, \
                    v ## inst.vv vv1, vv2, vv3)

#define TEST_FP_OP2_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double val2, double 0.0, vlad, vsd, ld, 8, \
                    v ## inst.vv vv1, vv2, vv3)

#define TEST_FP_OP3_S( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float val2, float val3, vlaw, vsw, lw, 4, \
                    v ## inst.vvv vv1, vv2, vv3, vv4)

#define TEST_FP_OP3_D( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double val2, double val3, vlad, vsd, ld, 8, \
                    v ## inst.vvv vv1, vv2, vv3, vv4)

#define TEST_FP_INT_OP_S( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, word result, float val1, float 0.0, float 0.0, vlaw, vsw, lw, 4, \
                    v ## inst.v vv1, vv2, rm)

#define TEST_FP_INT_OP_D( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, double val1, double 0.0, double 0.0, vlad, vsd, ld, 8, \
                    v ## inst.v vv1, vv2, rm)

#define TEST_FP_INT_OP_S_HEX( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, word val1, word 0, word 0, vlaw, vsd, ld, 8, \
                    v ## inst.v vv1, vv2, rm)

#define TEST_FP_INT_OP_D_HEX( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, dword val1, dword 0, dword 0, vlad, vsd, ld, 8, \
                    v ## inst.v vv1, vv2, rm)

#define TEST_FP_CMP_OP_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 2, word result, float val1, float val2, float 0.0, vlaw, vsw, lw, 4, \
                    vcmp ## inst.vv vp1, vv2, vv3;\
                    vaddi vs1,vs0,1; @vp1 vadd.ss vv1,vs0,vs1;\
                    @!vp1 vadd.ss vv1,vs0,vs0 )

#define TEST_FP_CMP_OP_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 2, dword result, double val1, double val2, double 0.0, vlad, vsd, ld, 8, \
                    vcmp ## inst.vv vp1, vv2, vv3;\
                    vaddi vs1,vs0,1; @vp1 vadd.ss vv1,vs0,vs1;\
                    @!vp1 vadd.ss vv1,vs0,vs0 )

#define TEST_FCLASS_S( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, word val1, word 0, word 0, vlaw, vsd, ld, 8, \
                    vfclass.s.v vv1, vv2)

#define TEST_FCLASS_D( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, dword val1, dword 0, dword 0, vlad, vsd, ld, 8, \
                    vfclass.d.v vv1, vv2)

#define TEST_INT_FP_OP_S( testnum, inst, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, word val1, word 0, word 0, vlaw, vsd, lw, 8, \
                    v ## inst.v vv1, vv2)

#define TEST_INT_FP_OP_D( testnum, inst, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, dword val1, dword 0, dword 0, vlad, vsd, ld, 8, \
                    v ## inst.v vv1, vv2)

#-----------------------------------------------------------------------
# RV64UV MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Test branch instructions
#-----------------------------------------------------------------------

#define TEST_BR2_OP_TAKEN( testnum, inst, val1, val2) \
    TEST_CASE_NREG( testnum, 4, v3, 0, val1, val2, \
      vadd.ss  vv1, vs1, vs0; \
      vadd.ss  vv2, vs2, vs0; \
      vadd vv3, vv0, vv0; \
      v ## inst vv1, vv2, 2f; \
      addi vv3, vv3, 1; \
1:    j 3f; \
      addi vv3, vv3, 4; \
2:    v ## inst vv1, vv2, 1b; \
      addi vv3, vv3, 2; \
3: \
    )

#define TEST_BR2_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 4, v3, 0, val1, val2, \
    vadd.ss  vv1, vs1, vs0; \
    vadd.ss  vv2, vs2, vs0; \
    add vv3, vv0, vv0; \
    v ## inst vv1, vv2, 1f; \
    j 2f; \
1:  addi vv3, vv3, 1; \
    j 3f; \
2:  v ## inst vv1, vv2, 1b; \
3: \
                  )

#define TEST_BR2_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 6, v3, 0, val1, val2, \
    add vv3, vv0, vv0; \
    li  vv4, 0; \
1:  vadd.ss  vv1, vs1, vs0; \
    TEST_INSERT_NOPS_ ## src1_nops \
    vadd.ss  vv2, vs2, vs0; \
    TEST_INSERT_NOPS_ ## src2_nops \
    v ## inst vv1, vv2, 2f; \
    addi  vv4, vv4, 1; \
    li  vv5, 2; \
    bne vv4, vv5, 1b; \
    j 3f; \
2:  add vv3, vv3, 1; \
3:  \
  )

#define TEST_BR2_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
  TEST_CASE_NREG( testnum, 6, v3, 0, val1, val2, \
    add vv3, vv0, vv0; \
    li  vv4, 0; \
1:  vadd.ss  vv2, vs2, vs0; \
    TEST_INSERT_NOPS_ ## src1_nops \
    vadd.ss  vv1, vs1, vs0; \
    TEST_INSERT_NOPS_ ## src2_nops \
    v ## inst vv1, vv2, 2f; \
    addi  vv4, vv4, 1; \
    li  vv5, 2; \
    bne vv4, vv4, 1b; \
    j 3f; \
2:  add vv3, vv3, 1; \
3: \
                  )

#define TEST_BR2_DIVERGED_ODD_EVEN( testnum, inst, n, result, code...)   \
  TEST_CASE_NREG( testnum, 5, v3, result, 0, 0, \
    utidx vv1; \
    andi vv2, vv1, 1;\
    add vv3, vv0, vv0; \
    li vv4, n; \
1: \
    beq vv0, vv2, 2f; \
    code; \
    j 3f; \
2: \
    code; \
3: \
    addi vv4, vv4, -1; \
    bne vv4, vv0, 1b; \
                  )

#define TEST_BR2_DIVERGED_FULL12( testnum, inst, n, result, code... )    \
  TEST_CASE_NREG( testnum, 5, v3, result, 0, 0, \
    utidx vv1; \
    sltiu vv2, vv1, 1; \
    add vv3, vv0, vv0; \
    li vv4, n; \
1: \
    v ## inst vv2, vv4, 2f; \
    addi vv1, vv1, -1; \
    sltiu vv2, vv1, 1; \
    j 1b; \
2: \
    code; \
                 )

#define TEST_BR2_DIVERGED_FULL21( testnum, inst, n, result, code... )    \
  TEST_CASE_NREG( testnum, 5, v3, result, 0, 0, \
    utidx vv1; \
    sltiu vv2, vv1, 1; \
    add vv3, vv0, vv0; \
    li vv4, n; \
1: \
    v ## inst vv4, vv2, 2f; \
    addi vv1, vv1, -1; \
    sltiu vv2, vv1, 1; \
    j 1b; \
2: \
    code; \
                 )

#define TEST_CASE_NREG_MEM( testnum, nxreg, npreg, correctval, code... ) \
test_ ## testnum: \
  li a3, VCFG(nxreg, 0, 0, npreg); \
  vsetcfg a3; \
  li a3,2048; \
  vsetvl a3,a3; \
1:auipc a0,%pcrel_hi(vtcode ## testnum); \
  vf %pcrel_lo(1b)(a0); \
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
.align 3; \
vtcode ## testnum : \
  vpset vp0; \
  code; \
  stop; \
next ## testnum :

#define TEST_BR2_DIVERGED_MEM_FULL12( testnum, inst, n) \
  TEST_CASE_NREG_MEM( testnum, 7, 0, 1, \
    utidx vv5; \
    slli vv5, vv5, 3; \
    la vv6, dst; \
    add vv5, vv5, vv6; \
    sd vv0, 0(x5); \
    utidx vv1; \
    sltiu vv2, vv1, 1; \
    li vv4, n; \
1: \
    v ## inst vv2, vv4, 2f; \
    addi vv1, vv1, -1; \
    sltiu vv2, vv1, 1; \
    j 1b; \
2: \
    ld vv3, 0(x5); \
    addi vv3, vv3, 1; \
    sd vv3, 0(x5); \
                 )

#define TEST_BR2_DIVERGED_MEM_FULL21( testnum, inst, n) \
  TEST_CASE_NREG_MEM( testnum, 7, 0, 1, \
    utidx vv5; \
    slli vv5, vv5, 3; \
    la vv6, dst; \
    add vv5, vv5, vv6; \
    sd vv0, 0(x5); \
    utidx vv1; \
    sltiu vv2, vv1, 1; \
    li vv4, n; \
1: \
    v ## inst vv4, vv2, 2f; \
    addi vv1, vv1, -1; \
    sltiu vv2, vv1, 1; \
    j 1b; \
2: \
    ld vv3, 0(x5); \
    addi vv3, vv3, 1; \
    sd vv3, 0(x5); \
                 )

#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in TESTNUM)
#-----------------------------------------------------------------------

#define TEST_PASSFAIL \
        bne x0, TESTNUM, pass; \
fail: \
        RVTEST_FAIL; \
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
