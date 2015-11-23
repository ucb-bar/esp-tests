#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_sdaxpy_c_src = \
	vec_sdaxpy_main.c \
	vec_sdaxpy.c \
	syscalls.c \

vec_sdaxpy_riscv_src = \
	crt.S \
	vec_sdaxpy_asm.S

vec_sdaxpy_c_objs     = $(patsubst %.c, %.o, $(vec_sdaxpy_c_src))
vec_sdaxpy_riscv_objs = $(patsubst %.S, %.o, $(vec_sdaxpy_riscv_src))

vec_sdaxpy_host_bin = vec-sdaxpy.host
$(vec_sdaxpy_host_bin): $(vec_sdaxpy_c_src)
	$(HOST_COMP) $^ -o $(vec_sdaxpy_host_bin)

vec_sdaxpy_riscv_bin = vec-sdaxpy.riscv
$(vec_sdaxpy_riscv_bin): $(vec_sdaxpy_c_objs) $(vec_sdaxpy_riscv_objs)
	$(RISCV_LINK) $(vec_sdaxpy_c_objs) $(vec_sdaxpy_riscv_objs) -o $(vec_sdaxpy_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_sdaxpy_c_objs) $(vec_sdaxpy_riscv_objs) \
        $(vec_sdaxpy_host_bin) $(vec_sdaxpy_riscv_bin)
