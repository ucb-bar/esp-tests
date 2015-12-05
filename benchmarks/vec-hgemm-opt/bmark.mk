#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-hgemm-opt_c_src = \
	vec-hgemm-opt_main.c \
	vec-hgemm-opt.c \
	syscalls.c \

vec-hgemm-opt_riscv_src = \
	crt.S \
	vec-hgemm-opt_asm.S

vec-hgemm-opt_c_objs     = $(patsubst %.c, %.o, $(vec-hgemm-opt_c_src))
vec-hgemm-opt_riscv_objs = $(patsubst %.S, %.o, $(vec-hgemm-opt_riscv_src))

vec-hgemm-opt_host_bin = vec-hgemm-opt.host
$(vec-hgemm-opt_host_bin): $(vec-hgemm-opt_c_src)
	$(HOST_COMP) $^ -o $(vec-hgemm-opt_host_bin)

vec-hgemm-opt_riscv_bin = vec-hgemm-opt.riscv
$(vec-hgemm-opt_riscv_bin): $(vec-hgemm-opt_c_objs) $(vec-hgemm-opt_riscv_objs)
	$(RISCV_LINK) $(vec-hgemm-opt_c_objs) $(vec-hgemm-opt_riscv_objs) -o $(vec-hgemm-opt_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-hgemm-opt_c_objs) $(vec-hgemm-opt_riscv_objs) \
        $(vec-hgemm-opt_host_bin) $(vec-hgemm-opt_riscv_bin)
