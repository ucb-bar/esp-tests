// See LICENSE for license details.

#ifndef __TEST_MACROS_SVECTOR_H
#define __TEST_MACROS_SVECTOR_H

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
1:auipc a0,%pcrel_hi(vtcode ## testnum ); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
  li a1,correctval; \
  li a2,0; \
  li TESTNUM, testnum; \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  j next ## testnum; \
.align 3; \
vtcode ## testnum : \
  vpset vp0; \
  code; \
  vsad va4, v ## testreg; \
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
    TEST_CASE_NREG( testnum, 4, s3, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
    )

#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, s1, result, val1, 0, \
      v ## inst vs1, vs1, SEXT_IMM(imm); \
    )

#define TEST_IMM_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 5, s4, result, val1, 0, \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd vs4, vs3, vs0; \
    )

#define TEST_IMM_SRC1_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE_NREG( testnum, 4, s3, result, val1, 0, \
      TEST_INSERT_NOPS_ ## nop_cycles \
      v ## inst vs3, vs1, SEXT_IMM(imm); \
    )

#define TEST_IMM_ZEROSRC1( testnum, inst, result, imm ) \
    TEST_CASE_NREG( testnum, 2, s1, result, 0, 0, \
      v ## inst vs1, vs0, SEXT_IMM(imm); \
    )

#define TEST_IMM_ZERODEST( testnum, inst, val1, imm ) \
    TEST_CASE_NREG( testnum, 2, s0, 0, val1, 0, \
      v ## inst vs0, vs1, SEXT_IMM(imm); \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------

#define TEST_R_OP( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 4, s3, result, val1, 0, \
      v ## inst vs3, vs1; \
    )

#define TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, s1, result, val1, 0, \
      v ## inst vs1, vs1; \
    )

#define TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 5, s4, result, val1, 0, \
      v ## inst vs3, vs1; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd vs4, vs3, vs0; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, s3, result, val1, val2, \
      v ## inst vs3, vs1, vs2; \
    )

#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, s1, result, val1, val2, \
      v ## inst vs1, vs1, vs2; \
    )

#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, s2, result, val1, val2, \
      v ## inst vs2, vs1, vs2; \
    )

#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE_NREG( testnum, 2, s1, result, val1, 0, \
      v ## inst vs1, vs1, vs1; \
    )

#define TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 5, s4, result, val1, val2, \
      v ## inst vs3, vs1, vs2; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      vadd vs4, vs3, vs0; \
    )

#define TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, s3, result, val1, val2, \
      vadd  vs1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd  vs2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst vs3, vs1, vs2; \
    )

#define TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE_NREG( testnum, 4, s3, result, val1, val2, \
      vadd  vs2, vs2, vs0; \
      TEST_INSERT_NOPS_ ## src1_nops \
      vadd  vs1, vs1, vs0; \
      TEST_INSERT_NOPS_ ## src2_nops \
      v ## inst vs3, vs1, vs2; \
    )

#define TEST_RR_ZEROSRC1( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, s2, result, val, 0, \
      v ## inst vs2, vs0, vs1; \
    )

#define TEST_RR_ZEROSRC2( testnum, inst, result, val ) \
    TEST_CASE_NREG( testnum, 3, s2, result, val, 0, \
      v ## inst vs2, vs1, vs0; \
    )

#define TEST_RR_ZEROSRC12( testnum, inst, result ) \
    TEST_CASE_NREG( testnum, 2, s1, result, 0, 0, \
      v ## inst vs1, vs0, vs0; \
    )

#define TEST_RR_ZERODEST( testnum, inst, val1, val2 ) \
    TEST_CASE_NREG( testnum, 3, s0, 0, val1, val2, \
      v ## inst vs0, vs1, vs2; \
      v ## inst vs0, vs0, vs0; \
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
1:auipc a0,%pcrel_hi(vtcode ## testnum ); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
  load a1, 0(a5); \
  li a2, 0; \
  li TESTNUM, testnum; \
  load a0, 0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  j 1f; \
.align 3; \
vtcode ## testnum : \
  vpset vp0; \
  vload vs2, va3; \
  vload vs3, va4; \
  vload vs4, va5; \
  code; \
  vstore va6, vs1; \
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
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double 0.0, double 0.0, vlad, vsad, ld, 8, \
                    vfcvt.s.d vs5, vs2; vfcvt.d.s vs1, vs5)

#define TEST_FCVT_D_S( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float 0.0, float 0.0, vlaw, vsaw, lw, 4, \
                    vfcvt.d.s vs5, vs2; vfcvt.s.d vs1, vs5)

#define TEST_FP_OP1_S( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float 0.0, float 0.0, vlaw, vsaw, lw, 4, \
                    v ## inst vs1, vs2)

#define TEST_FP_OP1_D( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double 0.0, double 0.0, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2)

#define TEST_FP_OP1_S_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, float val1, float 0.0, float 0.0, vlaw, vsaw, lw, 4, \
                            v ## inst vs1, vs2)

#define TEST_FP_OP1_D_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, double val1, double 0.0, double 0.0, vlad, vsad, ld, 8,\
                            v ## inst vs1, vs2)

#define TEST_FP_OP2_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float val2, float 0.0, vlaw, vsaw, lw, 4, \
                    v ## inst vs1, vs2, vs3)

#define TEST_FP_OP2_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double val2, double 0.0, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2, vs3)

#define TEST_FP_OP3_S( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, float val1, float val2, float val3, vlaw, vsaw, lw, 4, \
                    v ## inst vs1, vs2, vs3, vs4)

#define TEST_FP_OP3_D( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, double val1, double val2, double val3, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2, vs3, vs4)

#define TEST_FP_INT_OP_S( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, word result, float val1, float 0.0, float 0.0, vlaw, vsaw, lw, 4, \
                    v ## inst vs1, vs2, rm)

#define TEST_FP_INT_OP_D( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, double val1, double 0.0, double 0.0, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2, rm)

#define TEST_FP_INT_OP_S_HEX( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, word val1, word 0, word 0, vlaw, vsad, ld, 8, \
                    v ## inst vs1, vs2, rm)

#define TEST_FP_INT_OP_D_HEX( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, dword val1, dword 0, dword 0, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2, rm)

#define TEST_FCLASS_S( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, word val1, word 0, word 0, vlaw, vsad, ld, 8, \
                    vfclass.s vs1, vs2)

#define TEST_FCLASS_D( testnum, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, dword result, dword val1, dword 0, dword 0, vlad, vsad, ld, 8, \
                    vfclass.d vs1, vs2)

#define TEST_INT_FP_OP_S( testnum, inst, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, float result, word val1, word 0, word 0, vlaw, vsad, lw, 8, \
                    v ## inst vs1, vs2)

#define TEST_INT_FP_OP_D( testnum, inst, result, val1 ) \
  TEST_FP_OP_INTERNAL_NREG( testnum, 6, 1, double result, dword val1, dword 0, dword 0, vlad, vsad, ld, 8, \
                    v ## inst vs1, vs2)

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
