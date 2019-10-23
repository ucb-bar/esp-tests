#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-box3x3_c_src = \
	vec-box3x3_main.c \
	syscalls.c \

vec-box3x3_riscv_src = \
	crt.S \
	vec-box3x3_asm.S \

vec-box3x3_c_objs     = $(patsubst %.c, %.o, $(vec-box3x3_c_src))
vec-box3x3_riscv_objs = $(patsubst %.S, %.o, $(vec-box3x3_riscv_src))

vec-box3x3_host_bin = vec-box3x3.host
$(vec-box3x3_host_bin): $(vec-box3x3_c_src)
	$(HOST_COMP) $^ -o $(vec-box3x3_host_bin)

vec-box3x3_riscv_bin = vec-box3x3.riscv
$(vec-box3x3_riscv_bin): $(vec-box3x3_c_objs) $(vec-box3x3_riscv_objs)
	$(RISCV_LINK) $(vec-box3x3_c_objs) $(vec-box3x3_riscv_objs) -o $(vec-box3x3_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-box3x3_c_objs) $(vec-box3x3_riscv_objs) \
        $(vec-box3x3_host_bin) $(vec-box3x3_riscv_bin)
