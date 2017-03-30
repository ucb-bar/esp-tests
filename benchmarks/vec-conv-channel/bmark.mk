#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_conv_channel_c_src = \
	vec_conv_channel_main.c \
	vec_conv_channel.c \
	syscalls.c \

vec_conv_channel_riscv_src = \
	crt.S \
	vec_conv_channel_asm.S

vec_conv_channel_c_objs     = $(patsubst %.c, %.o, $(vec_conv_channel_c_src))
vec_conv_channel_riscv_objs = $(patsubst %.S, %.o, $(vec_conv_channel_riscv_src))

vec_conv_channel_host_bin = vec-conv_channel.host
$(vec_conv_channel_host_bin): $(vec_conv_channel_c_src)
	$(HOST_COMP) $^ -o $(vec_conv_channel_host_bin)

vec_conv_channel_riscv_bin = vec-conv-channel.riscv
$(vec_conv_channel_riscv_bin): $(vec_conv_channel_c_objs) $(vec_conv_channel_riscv_objs)
	$(RISCV_LINK) $(vec_conv_channel_c_objs) $(vec_conv_channel_riscv_objs) -o $(vec_conv_channel_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_conv_channel_c_objs) $(vec_conv_channel_riscv_objs) \
        $(vec_conv_channel_host_bin) $(vec_conv_channel_riscv_bin)
