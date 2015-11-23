#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec-sgemm-naive_c_src = \
	vec-sgemm-naive_main.c \
	vec-sgemm-naive.c \
	syscalls.c \

vec-sgemm-naive_riscv_src = \
	crt.S \
	vec-sgemm-naive_asm.S

vec-sgemm-naive_c_objs     = $(patsubst %.c, %.o, $(vec-sgemm-naive_c_src))
vec-sgemm-naive_riscv_objs = $(patsubst %.S, %.o, $(vec-sgemm-naive_riscv_src))

vec-sgemm-naive_host_bin = vec-sgemm-naive.host
$(vec-sgemm-naive_host_bin): $(vec-sgemm-naive_c_src)
	$(HOST_COMP) $^ -o $(vec-sgemm-naive_host_bin)

vec-sgemm-naive_riscv_bin = vec-sgemm-naive.riscv
$(vec-sgemm-naive_riscv_bin): $(vec-sgemm-naive_c_objs) $(vec-sgemm-naive_riscv_objs)
	$(RISCV_LINK) $(vec-sgemm-naive_c_objs) $(vec-sgemm-naive_riscv_objs) -o $(vec-sgemm-naive_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec-sgemm-naive_c_objs) $(vec-sgemm-naive_riscv_objs) \
        $(vec-sgemm-naive_host_bin) $(vec-sgemm-naive_riscv_bin)
