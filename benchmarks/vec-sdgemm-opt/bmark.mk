#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-sdgemm-opt_c_src = \
	vec-sdgemm-opt_main.c \
	vec-sdgemm-opt.c \
	syscalls.c \

vec-sdgemm-opt_riscv_src = \
	crt.S \
	vec-sdgemm-opt_asm.S

vec-sdgemm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-sdgemm-opt_c_src))
vec-sdgemm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-sdgemm-opt_riscv_src))

vec-sdgemm-opt_host_bin = vec-sdgemm-opt.host
$(vec-sdgemm-opt_host_bin): $(vec-sdgemm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-sdgemm-opt_host_bin)

vec-sdgemm-opt_riscv_bin = vec-sdgemm-opt.riscv
$(vec-sdgemm-opt_riscv_bin): $(vec-sdgemm-opt_c_objs) $(vec-sdgemm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-sdgemm-opt_c_objs) $(vec-sdgemm-opt_riscv_objs) -o $(vec-sdgemm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-sdgemm-opt_c_objs) $(vec-sdgemm-opt_riscv_objs) \
        $(vec-sdgemm-opt_host_bin) $(vec-sdgemm-opt_riscv_bin)
