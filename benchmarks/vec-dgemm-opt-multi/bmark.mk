#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

CORES = 2

vec-dgemm-opt-multi_c_src = \
	vec-dgemm-opt-multi_main.c \
	vec-dgemm-opt-multi.c \
	syscalls.c \

vec-dgemm-opt-multi_riscv_src = \
	crt.S \
	vec-dgemm-opt-multi_asm.S

vec-dgemm-opt-multi_c_objs     = $(patsubst %.c, %.o, $(vec-dgemm-opt-multi_c_src))
vec-dgemm-opt-multi_riscv_objs = $(patsubst %.S, %.o, $(vec-dgemm-opt-multi_riscv_src))

vec-dgemm-opt-multi_host_bin = vec-dgemm-opt-multi.host
$(vec-dgemm-opt-multi_host_bin): $(vec-dgemm-opt-multi_c_src)
	$(HOST_COMP) $^ -o $(vec-dgemm-opt-multi_host_bin)

vec-dgemm-opt-multi_riscv_bin = vec-dgemm-opt-multi.riscv
$(vec-dgemm-opt-multi_riscv_bin): $(vec-dgemm-opt-multi_c_objs) $(vec-dgemm-opt-multi_riscv_objs)
	$(RISCV_LINK) $(vec-dgemm-opt-multi_c_objs) $(vec-dgemm-opt-multi_riscv_objs) -o $(vec-dgemm-opt-multi_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-dgemm-opt-multi_c_objs) $(vec-dgemm-opt-multi_riscv_objs) \
        $(vec-dgemm-opt-multi_host_bin) $(vec-dgemm-opt-multi_riscv_bin)
