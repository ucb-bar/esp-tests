#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_stream_c_src = \
	vec_stream_main.c \
	vec_stream.c \
	syscalls.c \

vec_stream_riscv_src = \
	crt.S \
	vec_stream_asm.S

vec_stream_c_objs     = $(patsubst %.c, %.o, $(vec_stream_c_src))
vec_stream_riscv_objs = $(patsubst %.S, %.o, $(vec_stream_riscv_src))

vec_stream_host_bin = vec-stream.host
$(vec_stream_host_bin): $(vec_stream_c_src)
	$(HOST_COMP) $^ -o $(vec_stream_host_bin)

vec_stream_riscv_bin = vec-stream.riscv
$(vec_stream_riscv_bin): $(vec_stream_c_objs) $(vec_stream_riscv_objs)
	$(RISCV_LINK) $(vec_stream_c_objs) $(vec_stream_riscv_objs) -o $(vec_stream_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_stream_c_objs) $(vec_stream_riscv_objs) \
        $(vec_stream_host_bin) $(vec_stream_riscv_bin)
