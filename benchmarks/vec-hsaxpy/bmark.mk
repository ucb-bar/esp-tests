#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_hsaxpy_c_src = \
	vec_hsaxpy_main.c \
	vec_hsaxpy.c \
	syscalls.c \

vec_hsaxpy_riscv_src = \
	crt.S \
	vec_hsaxpy_asm.S

vec_hsaxpy_c_objs     = $(patsubst %.c, %.o, $(vec_hsaxpy_c_src))
vec_hsaxpy_riscv_objs = $(patsubst %.S, %.o, $(vec_hsaxpy_riscv_src))

vec_hsaxpy_host_bin = vec-hsaxpy.host
$(vec_hsaxpy_host_bin): $(vec_hsaxpy_c_src)
	$(HOST_COMP) $^ -o $(vec_hsaxpy_host_bin)

vec_hsaxpy_riscv_bin = vec-hsaxpy.riscv
$(vec_hsaxpy_riscv_bin): $(vec_hsaxpy_c_objs) $(vec_hsaxpy_riscv_objs)
	$(RISCV_LINK) $(vec_hsaxpy_c_objs) $(vec_hsaxpy_riscv_objs) -o $(vec_hsaxpy_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_hsaxpy_c_objs) $(vec_hsaxpy_riscv_objs) \
        $(vec_hsaxpy_host_bin) $(vec_hsaxpy_riscv_bin)
