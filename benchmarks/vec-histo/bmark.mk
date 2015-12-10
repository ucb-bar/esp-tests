#=======================================================================
# UCB CS250 Makefile fragment for benchmarks
#-----------------------------------------------------------------------
#
# Each benchmark directory should have its own fragment which
# essentially lists what the source files are and how to link them
# into an riscv and/or host executable. All variables should include
# the benchmark name as a prefix so that they are unique.
#

vec_histo_c_src = \
	vec_histo_main.c \
	vec_histo.c \
	syscalls.c \

vec_histo_riscv_src = \
	crt.S \
	vec_histo_asm.S

vec_histo_c_objs     = $(patsubst %.c, %.o, $(vec_histo_c_src))
vec_histo_riscv_objs = $(patsubst %.S, %.o, $(vec_histo_riscv_src))

vec_histo_host_bin = vec-histo.host
$(vec_histo_host_bin): $(vec_histo_c_src)
	$(HOST_COMP) $^ -o $(vec_histo_host_bin)

vec_histo_riscv_bin = vec-histo.riscv
$(vec_histo_riscv_bin): $(vec_histo_c_objs) $(vec_histo_riscv_objs)
	$(RISCV_LINK) $(vec_histo_c_objs) $(vec_histo_riscv_objs) -o $(vec_histo_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(vec_histo_c_objs) $(vec_histo_riscv_objs) \
        $(vec_histo_host_bin) $(vec_histo_riscv_bin)
