#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-mm-naive_c_src = \
	vec-mm-naive_main.c \
	vec-mm-naive.c \
	syscalls.c \

vec-mm-naive_riscv_src = \
	crt.S \
	vec-mm-naive_asm.S

vec-mm-naive_c_objs     = $(patsubst %.c, %.o, $(vec-mm-naive_c_src))
vec-mm-naive_riscv_objs = $(patsubst %.S, %.o, $(vec-mm-naive_riscv_src))

vec-mm-naive_host_bin = vec-mm-naive.host
$(vec-mm-naive_host_bin): $(vec-mm-naive_c_src)
	$(HOST_COMP) $^ -o $(vec-mm-naive_host_bin)

vec-mm-naive_riscv_bin = vec-mm-naive.riscv
$(vec-mm-naive_riscv_bin): $(vec-mm-naive_c_objs) $(vec-mm-naive_riscv_objs)
	$(RISCV_LINK) $(vec-mm-naive_c_objs) $(vec-mm-naive_riscv_objs) -o $(vec-mm-naive_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-mm-naive_c_objs) $(vec-mm-naive_riscv_objs) \
        $(vec-mm-naive_host_bin) $(vec-mm-naive_riscv_bin)
