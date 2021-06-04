// See LICENSE for license details.

#ifndef __TEST_MACROS_SCALAR_H
#define __TEST_MACROS_SCALAR_H


#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------

#define MASK_XLEN(x) ((x) & ((1 << (__riscv_xlen - 1) << 1) - 1))

#define TEST_CASE( testnum, testreg, correctval, code... ) \
test_ ## testnum: \
    code; \
    li  x7, MASK_XLEN(correctval); \
    li  TESTNUM, testnum; \
    bne testreg, x7, fail;

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
#-----------------------------------------------------------------------

#define SEXT_IMM(x) ((x) | (-(((x) >> 11) & 1) << 11))

#define TEST_IMM_OP( testnum, inst, result, val1, imm ) \
    TEST_CASE( testnum, x14, result, \
      li  x1, MASK_XLEN(val1); \
      inst x14, x1, SEXT_IMM(imm); \
    )

#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      inst x1, x1, SEXT_IMM(imm); \
    )

#define TEST_IMM_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      inst x14, x1, SEXT_IMM(imm); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, x14, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_IMM_SRC1_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE( testnum, x14, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      inst x14, x1, SEXT_IMM(imm); \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_IMM_ZEROSRC1( testnum, inst, result, imm ) \
    TEST_CASE( testnum, x1, result, \
      inst x1, x0, SEXT_IMM(imm); \
    )

#define TEST_IMM_ZERODEST( testnum, inst, val1, imm ) \
    TEST_CASE( testnum, x0, 0, \
      li  x1, MASK_XLEN(val1); \
      inst x0, x1, SEXT_IMM(imm); \
    )

#-----------------------------------------------------------------------
# Tests for vector config instructions
#-----------------------------------------------------------------------

#define VCFG(nvvd, nvvw, nvvh, nvp) \
  (((nvvd) & 0x1ff) | \
  (((nvp) & 0x1f) << 9) | \
  (((nvvw) & 0x1ff) << 14) | \
  (((nvvh) & 0x1ff) << 23))

#define TEST_VSETCFGIVL( testnum, nvvd, nvp, vl, result ) \
    TEST_CASE( testnum, x1, result, \
      vsetcfg (nvvd),(nvp); \
      li x1, vl; \
      vsetvl x1,x1; \
    )

#define TEST_VVCFG( testnum, nvvd, nvp, vl, result ) \
    TEST_CASE( testnum, x1, result, \
      li x1, VCFG(nvvd,0,0,nvp); \
      vsetcfg x1; \
      li x1, vl; \
      vsetvl x1,x1; \
    )

#define TEST_VSETVL( testnum, nvvd, nvp, vl, result ) \
    TEST_CASE( testnum, x1, result, \
      li x1, VCFG(nvvd,0,0,nvp); \
      vsetcfg x1; \
      li x1, vl; \
      vsetvl x1, x1; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------

#define TEST_R_OP( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, x14, result, \
      li  x1, val1; \
      inst x14, x1; \
    )

#define TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, val1; \
      inst x1, x1; \
    )

#define TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, val1; \
      inst x14, x1; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, x14, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x14, result, \
      li  x1, MASK_XLEN(val1); \
      li  x2, MASK_XLEN(val2); \
      inst x14, x1, x2; \
    )

#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      li  x2, MASK_XLEN(val2); \
      inst x1, x1, x2; \
    )

#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x2, result, \
      li  x1, MASK_XLEN(val1); \
      li  x2, MASK_XLEN(val2); \
      inst x2, x1, x2; \
    )

#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      inst x1, x1, x1; \
    )

#define TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      li  x2, MASK_XLEN(val2); \
      inst x14, x1, x2; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, x14, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x14, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## src1_nops \
      li  x2, MASK_XLEN(val2); \
      TEST_INSERT_NOPS_ ## src2_nops \
      inst x14, x1, x2; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x14, result, \
      li  x4, 0; \
1:    li  x2, MASK_XLEN(val2); \
      TEST_INSERT_NOPS_ ## src1_nops \
      li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## src2_nops \
      inst x14, x1, x2; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_ZEROSRC1( testnum, inst, result, val ) \
    TEST_CASE( testnum, x2, result, \
      li x1, MASK_XLEN(val); \
      inst x2, x0, x1; \
    )

#define TEST_RR_ZEROSRC2( testnum, inst, result, val ) \
    TEST_CASE( testnum, x2, result, \
      li x1, MASK_XLEN(val); \
      inst x2, x1, x0; \
    )

#define TEST_RR_ZEROSRC12( testnum, inst, result ) \
    TEST_CASE( testnum, x1, result, \
      inst x1, x0, x0; \
    )

#define TEST_RR_ZERODEST( testnum, inst, val1, val2 ) \
    TEST_CASE( testnum, x0, 0, \
      li x1, MASK_XLEN(val1); \
      li x2, MASK_XLEN(val2); \
      inst x0, x1, x2; \
    )

#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------

#define TEST_LD_OP( testnum, inst, result, offset, base ) \
    TEST_CASE( testnum, x14, result, \
      la  x1, base; \
      inst x14, offset(x1); \
    )

#define TEST_ST_OP( testnum, load_inst, store_inst, result, offset, base ) \
    TEST_CASE( testnum, x14, result, \
      la  x1, base; \
      li  x2, result; \
      store_inst x2, offset(x1); \
      load_inst x14, offset(x1); \
    )

#define TEST_LD_DEST_BYPASS( testnum, nop_cycles, inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x1, base; \
    inst x14, offset(x1); \
    TEST_INSERT_NOPS_ ## nop_cycles \
    addi  x6, x14, 0; \
    li  x7, result; \
    bne x6, x7, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b; \

#define TEST_LD_SRC1_BYPASS( testnum, nop_cycles, inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x1, base; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst x14, offset(x1); \
    li  x7, result; \
    bne x14, x7, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_ST_SRC12_BYPASS( testnum, src1_nops, src2_nops, load_inst, store_inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  x1, result; \
    TEST_INSERT_NOPS_ ## src1_nops \
    la  x2, base; \
    TEST_INSERT_NOPS_ ## src2_nops \
    store_inst x1, offset(x2); \
    load_inst x14, offset(x2); \
    li  x7, result; \
    bne x14, x7, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_ST_SRC21_BYPASS( testnum, src1_nops, src2_nops, load_inst, store_inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x2, base; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  x1, result; \
    TEST_INSERT_NOPS_ ## src2_nops \
    store_inst x1, offset(x2); \
    load_inst x14, offset(x2); \
    li  x7, result; \
    bne x14, x7, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_BR2_OP_TAKEN( testnum, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x1, val1; \
    li  x2, val2; \
    inst x1, x2, 2f; \
    bne x0, TESTNUM, fail; \
1:  bne x0, TESTNUM, 3f; \
2:  inst x1, x2, 1b; \
    bne x0, TESTNUM, fail; \
3:

#define TEST_BR2_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x1, val1; \
    li  x2, val2; \
    inst x1, x2, 1f; \
    bne x0, TESTNUM, 2f; \
1:  bne x0, TESTNUM, fail; \
2:  inst x1, x2, 1b; \
3:

#define TEST_BR2_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  x1, val1; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  x2, val2; \
    TEST_INSERT_NOPS_ ## src2_nops \
    inst x1, x2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_BR2_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  x2, val2; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  x1, val1; \
    TEST_INSERT_NOPS_ ## src2_nops \
    inst x1, x2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------

#define TEST_JR_SRC1_BYPASS( testnum, nop_cycles, inst ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x6, 2f; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst x6; \
    bne x0, TESTNUM, fail; \
2:  addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_JALR_SRC1_BYPASS( testnum, nop_cycles, inst ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x6, 2f; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst x13, x6, 0; \
    bne x0, TESTNUM, fail; \
2:  addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \


#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------

#define qNaNh 0h:7e00
#define sNaNh 0h:7c01
#define qNaNf 0f:7fc00000
#define sNaNf 0f:7f800001
#define qNaN 0d:7ff8000000000000
#define sNaN 0d:7ff0000000000001

#define TEST_FP_OP_H_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  flh f0, 0(a0); \
  flh f1, 2(a0); \
  flh f2, 4(a0); \
  lh  a3, 6(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 1; \
  test_ ## testnum ## _data: \
  .float16 val1; \
  .float16 val2; \
  .float16 val3; \
  .result; \
  .popsection

#define TEST_FP_OP_S_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
  test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  flw f0, 0(a0); \
  flw f1, 4(a0); \
  flw f2, 8(a0); \
  lw  a3, 12(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float val3; \
  .result; \
  .popsection

#define TEST_FP_OP_D_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
  test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  ld  a3, 24(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection

// TODO: assign a separate mem location for the comparison address?
#define TEST_FP_OP_D32_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  t1, 28(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne t1, t2, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection

#define TEST_FCVT_S_D32( testnum, result, val1 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, 0, double result, val1, 0.0, 0.0, \
                    fcvt.s.d f3, f0; fcvt.d.s f3, f3; fsd f3, 0(a0); lw t2, 4(a0); lw a0, 0(a0))

#define TEST_FCVT_S_D( testnum, result, val1 ) \
    TEST_FP_OP_D_INTERNAL( testnum, 0, double result, val1, 0.0, 0.0, \
                            fcvt.s.d f3, f0; fcvt.d.s f3, f3; fmv.x.d a0, f3)

#define TEST_FCVT_D_S( testnum, result, val1 ) \
    TEST_FP_OP_S_INTERNAL( testnum, 0, float result, val1, 0.0, 0.0, \
                            fcvt.d.s f3, f0; fcvt.s.d f3, f3; fmv.x.s a0, f3)

#define TEST_FCVT_H_S( testnum, result, val1 ) \
  TEST_FP_OP_H_INTERNAL( testnum, 0, float16 result, val1, 0.0, 0.0, \
                    fcvt.s.h f3, f0; fcvt.h.s f3, f3; fmv.x.h a0, f3)

#define TEST_FCVT_H_D( testnum, result, val1 ) \
  TEST_FP_OP_H_INTERNAL( testnum, 0, float16 result, val1, 0.0, 0.0, \
                    fcvt.d.h f3, f0; fcvt.h.d f3, f3; fmv.x.h a0, f3)


#define TEST_FP_OP1_H( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, float16 result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.h a0, f3;)

#define TEST_FP_OP1_S( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, 0.0, 0.0, \
                            inst f3, f0; fmv.x.s a0, f3)

#define TEST_FP_OP1_D32( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, double result, val1, 0.0, 0.0, \
                    inst f3, f0; fsd f3, 0(a0); lw t2, 4(a0); lw a0, 0(a0))
// ^: store computation result in address from a0, load high-word into t2

#define TEST_FP_OP1_D( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, 0.0, 0.0, \
                            inst f3, f0; fmv.x.d a0, f3)

#define TEST_FP_OP1_S_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_S_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                            inst f3, f0; fmv.x.s a0, f3)

#define TEST_FP_OP1_H_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, word result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.h a0, f3)

#define TEST_FP_OP1_D32_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst f3, f0; fsd f3, 0(a0); lw t2, 4(a0); lw a0, 0(a0))
// ^: store computation result in address from a0, load high-word into t2

#define TEST_FP_OP1_D_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
    TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                            inst f3, f0; fmv.x.d a0, f3)

#define TEST_FP_OP2_S( testnum, inst, flags, result, val1, val2 ) \
    TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, val2, 0.0, \
                            inst f3, f0, f1; fmv.x.s a0, f3)

#define TEST_FP_OP2_H( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, float16 result, val1, val2, 0.0, \
                    inst f3, f0, f1; fmv.x.h a0, f3)

#define TEST_FP_OP2_D32( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, double result, val1, val2, 0.0, \
                    inst f3, f0, f1; fsd f3, 0(a0); lw t2, 4(a0); lw a0, 0(a0))
// ^: store computation result in address from a0, load high-word into t2

#define TEST_FP_OP2_D( testnum, inst, flags, result, val1, val2 ) \
    TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, val2, 0.0, \
                            inst f3, f0, f1; fmv.x.d a0, f3)

#define TEST_FP_OP3_S( testnum, inst, flags, result, val1, val2, val3 ) \
    TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, val2, val3, \
                            inst f3, f0, f1, f2; fmv.x.s a0, f3)

#define TEST_FP_OP3_H( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, float16 result, val1, val2, val3, \
                    inst f3, f0, f1, f2; fmv.x.h a0, f3)

#define TEST_FP_OP3_D32( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, double result, val1, val2, val3, \
                    inst f3, f0, f1, f2; fsd f3, 0(a0); lw t2, 4(a0); lw a0, 0(a0))
// ^: store computation result in address from a0, load high-word into t2

#define TEST_FP_OP3_D( testnum, inst, flags, result, val1, val2, val3 ) \
    TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, val2, val3, \
                            inst f3, f0, f1, f2; fmv.x.d a0, f3)

#define TEST_FP_INT_OP_S( testnum, inst, flags, result, val1, rm ) \
    TEST_FP_OP_S_INTERNAL( testnum, flags, word result, val1, 0.0, 0.0, \
                            inst a0, f0, rm)

#define TEST_FP_INT_OP_H( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, word result, val1, 0.0, 0.0, \
                    inst a0, f0, rm)

#define TEST_FP_INT_OP_D32( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst a0, f0, f1; li t2, 0)

#define TEST_FP_INT_OP_D( testnum, inst, flags, result, val1, rm ) \
    TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                            inst a0, f0, rm)

#define TEST_FP_CMP_OP_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, word result, val1, val2, 0.0, \
                    inst a0, f0, f1)

#define TEST_FP_CMP_OP_H( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_H_INTERNAL( testnum, flags, hword result, val1, val2, 0.0, \
                    inst a0, f0, f1)

#define TEST_FP_CMP_OP_D32( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D32_INTERNAL( testnum, flags, dword result, val1, val2, 0.0, \
                    inst a0, f0, f1; li t2, 0)

#define TEST_FP_CMP_OP_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, val2, 0.0, \
                    inst a0, f0, f1)

#define TEST_FCLASS_S(testnum, correct, input) \
  TEST_CASE(testnum, a0, correct, li a0, input; fmv.s.x fa0, a0; \
                    fclass.s a0, fa0)

#define TEST_FCLASS_D32(testnum, correct, input) \
  TEST_CASE(testnum, a0, correct, \
            la a0, test_ ## testnum ## _data ;\
            fld fa0, 0(a0); \
            fclass.d a0, fa0) \
    .pushsection .data; \
    .align 3; \
    test_ ## testnum ## _data: \
    .dword input; \
    .popsection

#define TEST_FCLASS_D(testnum, correct, input) \
  TEST_CASE(testnum, a0, correct, li a0, input; fmv.d.x fa0, a0; \
                    fclass.d a0, fa0)

#define TEST_INT_FP_OP_S( testnum, inst, result, val1 ) \
  test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  lw  a3, 0(a0); \
  li  a0, val1; \
  inst f0, a0; \
  fsflags x0; \
  fmv.x.s a0, f0; \
  bne a0, a3, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float result; \
  .popsection

#define TEST_INT_FP_OP_H( testnum, inst, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  lh  a3, 0(a0); \
  li  a0, val1; \
  inst f0, a0; \
  fsflags x0; \
  fmv.x.h a0, f0; \
  bne a0, a3, fail; \
  .pushsection .data; \
  .align 1; \
  test_ ## testnum ## _data: \
  .float16 result; \
  .popsection

#define TEST_INT_FP_OP_D32( testnum, inst, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  lw  a3, 0(a0); \
  lw  a4, 4(a0); \
  li  a1, val1; \
  inst f0, a1; \
  \
  fsd f0, 0(a0); \
  lw a1, 4(a0); \
  lw a0, 0(a0); \
  \
  fsflags x0; \
  bne a0, a3, fail; \
  bne a1, a4, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double result; \
  .popsection

#define TEST_INT_FP_OP_D( testnum, inst, result, val1 ) \
  test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  ld  a3, 0(a0); \
  li  a0, val1; \
  inst f0, a0; \
  fsflags x0; \
  fmv.x.d a0, f0; \
  bne a0, a3, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double result; \
  .popsection

// We need some special handling here to allow 64-bit comparison in 32-bit arch
// TODO: find a better name and clean up when intended for general usage?
#define TEST_CASE_D32( testnum, testreg1, testreg2, correctval, code... ) \
test_ ## testnum: \
    code; \
    la  x15, test_ ## testnum ## _data ; \
    lw  x7, 0(x15); \
    lw  x15, 4(x15); \
    li  TESTNUM, testnum; \
    bne testreg1, x7, fail;\
    bne testreg2, x15, fail;\
    .pushsection .data; \
    .align 3; \
    test_ ## testnum ## _data: \
    .dword correctval; \
    .popsection

// ^ x14 is used in some other macros, to avoid issues we use x15 for upper word

#-----------------------------------------------------------------------
# RV64UV MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
#define TEST_CASE_NREG_SCALAR( testnum, nxreg, npreg, input, output, code... ) \
test_ ## testnum: \
  vsetcfg nxreg,npreg; \
  li a3,2048; \
  vsetvl a3,a3; \
  li a1,input; \
  vmcs vs3, a1; \
  la a4,src1; \
  vmca va2, a4; \
  vmcs vs2, a4; \
  la a4,dst; \
  vmca va1, a4; \
  vmcs vs1, a4; \
1:auipc a0,%pcrel_hi(vtcode ## testnum ); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
  li a1, output; \
  li TESTNUM, testnum; \
  ld a0,0(a4); \
  beq a0,a1,skip ## testnum; \
  j fail; \
skip ## testnum : \
  j next ## testnum; \
.align 3; \
vtcode ## testnum : \
  code; \
  vstop; \
next ## testnum :

#define TEST_VST_OP( testnum, store_inst, areg, result ) \
    TEST_CASE_NREG_SCALAR( testnum, 1, 1, result, result, \
      store_inst areg, vs3; \
    )

#define TEST_VLD_OP( testnum, load_inst, store_inst, sreg, dreg, input, output ) \
    TEST_CASE_NREG_SCALAR( testnum, 1, 1, input, output, \
      store_inst sreg, vs3; \
      load_inst vs4, sreg; \
      store_inst dreg, vs4; \
    )

#define TEST_VLDU_OP( testnum, load_inst, store_inst, sreg, dreg, result ) \
    TEST_VLD_OP( testnum, load_inst, store_inst, sreg, dreg, result, result )

#-----------------------------------------------------------------------
# RV64SV MACROS
#-----------------------------------------------------------------------

#define TEST_ILLEGAL_VT_REGID( testnum, nxreg, nfreg, inst, reg1, reg2, reg3) \
  la a0, handler ## testnum; \
  csrw stvec, a0; \
  vsetcfg nxreg, nfreg; \
  li a0, 4; \
  vsetvl a0, a0; \
  la a0, src1; \
  vmca va0, a0; \
  la a1, src2; \
  vmca va1, a1; \
  la a3, dest; \
  vmca va2, a3; \
1:auipc a0,%pcrel_hi(vtcode1 ## testnum); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
.align 3; \
vtcode1 ## testnum: \
  vld vv2,va0; \
  vld vv3,va1; \
  vadd.vv vv2, vv2, vv3; \
  vsd vv2, va2; \
illegal ## testnum: \
  v ## inst.vv v ## reg1, v ## reg2, v ## reg3; \
  vstop; \
.align 3; \
vtcode2 ## testnum: \
  vld vv2,va0; \
  vld vv3,va1; \
  vadd.vv vv2, vv2, vv3; \
  vsd vv2, va2; \
  vstop; \
handler ## testnum: \
  vxcptkill; \
  li TESTNUM,2; \
  csrr a0, scause; \
  li a1,HWACHA_CAUSE_VF_ILLEGAL_REGID; \
  bne a0,a1,fail; \
  csrr a0, sbadaddr; \
  la a1,illegal ## testnum; \
  bne a0,a1,fail; \
  vsetcfg 32,1; \
  li a0,4; \
  vsetvl a0,a0; \
  la a0, src1; \
  vmca va0, a0; \
  la a1, src2; \
  vmca va1, a1; \
  la a3, dest; \
  vmca va2, a3; \
1:auipc a0,%pcrel_hi(vtcode2 ## testnum); \
  vf %pcrel_lo(1b)(a0); \
  fence; \
  ld a1,0(a3); \
  li a2,5; \
  li TESTNUM,2; \
  bne a1,a2,fail; \
  ld a1,8(a3); \
  li TESTNUM,3; \
  bne a1,a2,fail; \
  ld a1,16(a3); \
  li TESTNUM,4; \
  bne a1,a2,fail; \
  ld a1,24(a3); \
  li TESTNUM,5; \
  bne a1,a2,fail; \

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

#define TEST_DATA

#endif
