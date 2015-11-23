#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-dgemm-opt_c_src = \
	vec-dgemm-opt_main.c \
	vec-dgemm-opt.c \
	syscalls.c \

vec-dgemm-opt_riscv_src = \
	crt.S \
	vec-dgemm-opt_asm.S

vec-dgemm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-dgemm-opt_c_src))
vec-dgemm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-dgemm-opt_riscv_src))

vec-dgemm-opt_host_bin = vec-dgemm-opt.host
$(vec-dgemm-opt_host_bin): $(vec-dgemm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-dgemm-opt_host_bin)

vec-dgemm-opt_riscv_bin = vec-dgemm-opt.riscv
$(vec-dgemm-opt_riscv_bin): $(vec-dgemm-opt_c_objs) $(vec-dgemm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-dgemm-opt_c_objs) $(vec-dgemm-opt_riscv_objs) -o $(vec-dgemm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-dgemm-opt_c_objs) $(vec-dgemm-opt_riscv_objs) \
        $(vec-dgemm-opt_host_bin) $(vec-dgemm-opt_riscv_bin)
