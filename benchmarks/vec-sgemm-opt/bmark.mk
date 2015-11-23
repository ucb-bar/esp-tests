#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-sgemm-opt_c_src = \
	vec-sgemm-opt_main.c \
	vec-sgemm-opt.c \
	syscalls.c \

vec-sgemm-opt_riscv_src = \
	crt.S \
	vec-sgemm-opt_asm.S

vec-sgemm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-sgemm-opt_c_src))
vec-sgemm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-sgemm-opt_riscv_src))

vec-sgemm-opt_host_bin = vec-sgemm-opt.host
$(vec-sgemm-opt_host_bin): $(vec-sgemm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-sgemm-opt_host_bin)

vec-sgemm-opt_riscv_bin = vec-sgemm-opt.riscv
$(vec-sgemm-opt_riscv_bin): $(vec-sgemm-opt_c_objs) $(vec-sgemm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-sgemm-opt_c_objs) $(vec-sgemm-opt_riscv_objs) -o $(vec-sgemm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-sgemm-opt_c_objs) $(vec-sgemm-opt_riscv_objs) \
        $(vec-sgemm-opt_host_bin) $(vec-sgemm-opt_riscv_bin)
