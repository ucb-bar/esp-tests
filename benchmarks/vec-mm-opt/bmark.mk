#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-mm-opt_c_src = \
	vec-mm-opt_main.c \
	vec-mm-opt.c \
	syscalls.c \

vec-mm-opt_riscv_src = \
	crt.S \
	vec-mm-opt_asm.S

vec-mm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-mm-opt_c_src))
vec-mm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-mm-opt_riscv_src))

vec-mm-opt_host_bin = vec-mm-opt.host
$(vec-mm-opt_host_bin): $(vec-mm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-mm-opt_host_bin)

vec-mm-opt_riscv_bin = vec-mm-opt.riscv
$(vec-mm-opt_riscv_bin): $(vec-mm-opt_c_objs) $(vec-mm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-mm-opt_c_objs) $(vec-mm-opt_riscv_objs) -o $(vec-mm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-mm-opt_c_objs) $(vec-mm-opt_riscv_objs) \
        $(vec-mm-opt_host_bin) $(vec-mm-opt_riscv_bin)
