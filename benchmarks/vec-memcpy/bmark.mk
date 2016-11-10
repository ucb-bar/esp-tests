#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_memcpy_c_src = \
	vec_memcpy_main.c \
	vec_memcpy.c \
	syscalls.c \

vec_memcpy_riscv_src = \
	vec_memcpy_asm.S \
	crt.S \

vec_memcpy_c_objs     = $(patsubst %.c, %.o, $(vec_memcpy_c_src))
vec_memcpy_riscv_objs = $(patsubst %.S, %.o, $(vec_memcpy_riscv_src))

vec_memcpy_host_bin = vec-memcpy.host
$(vec_memcpy_host_bin) : $(vec_memcpy_c_src)
	$(HOST_COMP) $^ -o $(vec_memcpy_host_bin)

vec_memcpy_riscv_bin = vec-memcpy.riscv
$(vec_memcpy_riscv_bin) : $(vec_memcpy_c_objs) $(vec_memcpy_riscv_objs)
	$(RISCV_LINK) $(vec_memcpy_c_objs) $(vec_memcpy_riscv_objs) -o $(vec_memcpy_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_memcpy_c_objs) $(vec_memcpy_riscv_objs) \
        $(vec_memcpy_host_bin) $(vec_memcpy_riscv_bin)
