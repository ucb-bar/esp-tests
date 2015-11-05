#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

pb_spmv_c_src = \
	pb-spmv.c \
	syscalls.c \

pb_spmv_riscv_src = \
	crt.S \
	pb-spmv-kernel.S \

pb_spmv_c_objs     = $(patsubst %.c, %.o, $(pb_spmv_c_src))
pb_spmv_riscv_objs = $(patsubst %.S, %.o, $(pb_spmv_riscv_src))

pb_spmv_host_bin = pb-spmv.host
$(pb_spmv_host_bin) : $(pb_spmv_c_src)
	$(HOST_COMP) $^ -o $(pb_spmv_host_bin)

pb_spmv_riscv_bin = pb-spmv.riscv
$(pb_spmv_riscv_bin) : $(pb_spmv_c_objs) $(pb_spmv_riscv_objs)
	$(RISCV_LINK) $(pb_spmv_c_objs) $(pb_spmv_riscv_objs) -o $(pb_spmv_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(pb_spmv_c_objs) $(pb_spmv_riscv_objs) \
        $(pb_spmv_host_bin) $(pb_spmv_riscv_bin)
