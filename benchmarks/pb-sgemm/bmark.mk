#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

pb_sgemm_c_src = \
	pb-sgemm.c \
	syscalls.c \

pb_sgemm_riscv_src = \
	crt.S \
	pb-sgemm-kernel.S \

pb_sgemm_c_objs     = $(patsubst %.c, %.o, $(pb_sgemm_c_src))
pb_sgemm_riscv_objs = $(patsubst %.S, %.o, $(pb_sgemm_riscv_src))

pb_sgemm_host_bin = pb-sgemm.host
$(pb_sgemm_host_bin) : $(pb_sgemm_c_src)
	$(HOST_COMP) $^ -o $(pb_sgemm_host_bin)

pb_sgemm_riscv_bin = pb-sgemm.riscv
$(pb_sgemm_riscv_bin) : $(pb_sgemm_c_objs) $(pb_sgemm_riscv_objs)
	$(RISCV_LINK) $(pb_sgemm_c_objs) $(pb_sgemm_riscv_objs) -o $(pb_sgemm_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(pb_sgemm_c_objs) $(pb_sgemm_riscv_objs) \
        $(pb_sgemm_host_bin) $(pb_sgemm_riscv_bin)
