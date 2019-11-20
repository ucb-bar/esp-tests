#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-colorconv_c_src = \
	main.c \
	syscalls.c \

vec-colorconv_riscv_src = \
	crt.S \
	vec-colorconv \

vec-colorconv_c_objs     = $(patsubst %.c, %.o, $(vec-colorconv_c_src))
vec-colorconv_riscv_objs = $(patsubst %.S, %.o, $(vec-colorconv_riscv_src))

vec-colorconv_host_bin = vec-colorconv.host
$(vec-colorconv_host_bin): $(vec-colorconv_c_src)
	$(HOST_COMP) $^ -o $(vec-colorconv_host_bin)

vec-colorconv_riscv_bin = vec-colorconv.riscv
$(vec-colorconv_riscv_bin): $(vec-colorconv_c_objs) $(vec-colorconv_riscv_objs)
	$(RISCV_LINK) $(vec-colorconv_c_objs) $(vec-colorconv_riscv_objs) -o $(vec-colorconv_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-colorconv_c_objs) $(vec-colorconv_riscv_objs) \
        $(vec-colorconv_host_bin) $(vec-colorconv_riscv_bin)
