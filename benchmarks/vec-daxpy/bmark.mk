#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_daxpy_c_src = \
	vec_daxpy_main.c \
	vec_daxpy.c \
	syscalls.c \

vec_daxpy_riscv_src = \
	crt.S \
	vec_daxpy_asm.S

vec_daxpy_c_objs     = $(patsubst %.c, %.o, $(vec_daxpy_c_src))
vec_daxpy_riscv_objs = $(patsubst %.S, %.o, $(vec_daxpy_riscv_src))

vec_daxpy_host_bin = vec-daxpy.host
$(vec_daxpy_host_bin): $(vec_daxpy_c_src)
	$(HOST_COMP) $^ -o $(vec_daxpy_host_bin)

vec_daxpy_riscv_bin = vec-daxpy.riscv
$(vec_daxpy_riscv_bin): $(vec_daxpy_c_objs) $(vec_daxpy_riscv_objs)
	$(RISCV_LINK) $(vec_daxpy_c_objs) $(vec_daxpy_riscv_objs) -o $(vec_daxpy_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_daxpy_c_objs) $(vec_daxpy_riscv_objs) \
        $(vec_daxpy_host_bin) $(vec_daxpy_riscv_bin)
