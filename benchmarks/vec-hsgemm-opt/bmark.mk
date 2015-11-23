#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-hsgemm-opt_c_src = \
	vec-hsgemm-opt_main.c \
	vec-hsgemm-opt.c \
	syscalls.c \

vec-hsgemm-opt_riscv_src = \
	crt.S \
	vec-hsgemm-opt_asm.S

vec-hsgemm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-hsgemm-opt_c_src))
vec-hsgemm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-hsgemm-opt_riscv_src))

vec-hsgemm-opt_host_bin = vec-hsgemm-opt.host
$(vec-hsgemm-opt_host_bin): $(vec-hsgemm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-hsgemm-opt_host_bin)

vec-hsgemm-opt_riscv_bin = vec-hsgemm-opt.riscv
$(vec-hsgemm-opt_riscv_bin): $(vec-hsgemm-opt_c_objs) $(vec-hsgemm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-hsgemm-opt_c_objs) $(vec-hsgemm-opt_riscv_objs) -o $(vec-hsgemm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-hsgemm-opt_c_objs) $(vec-hsgemm-opt_riscv_objs) \
        $(vec-hsgemm-opt_host_bin) $(vec-hsgemm-opt_riscv_bin)
