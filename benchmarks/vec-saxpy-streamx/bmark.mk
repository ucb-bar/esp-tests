#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_saxpy_streamx_c_src = \
	vec_saxpy_streamx_main.c \
	vec_saxpy_streamx.c \
	syscalls.c \

vec_saxpy_streamx_riscv_src = \
	crt.S \
	vec_saxpy_streamx_asm.S

vec_saxpy_streamx_c_objs     = $(patsubst %.c, %.o, $(vec_saxpy_streamx_c_src))
vec_saxpy_streamx_riscv_objs = $(patsubst %.S, %.o, $(vec_saxpy_streamx_riscv_src))

vec_saxpy_streamx_host_bin = vec-saxpy-streamx.host
$(vec_saxpy_streamx_host_bin): $(vec_saxpy_streamx_c_src)
	$(HOST_COMP) $^ -o $(vec_saxpy_streamx_host_bin)

vec_saxpy_streamx_riscv_bin = vec-saxpy-streamx.riscv
$(vec_saxpy_streamx_riscv_bin): $(vec_saxpy_streamx_c_objs) $(vec_saxpy_streamx_riscv_objs)
	$(RISCV_LINK) $(vec_saxpy_streamx_c_objs) $(vec_saxpy_streamx_riscv_objs) -o $(vec_saxpy_streamx_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_saxpy_streamx_c_objs) $(vec_saxpy_streamx_riscv_objs) \
        $(vec_saxpy_streamx_host_bin) $(vec_saxpy_streamx_riscv_bin)
