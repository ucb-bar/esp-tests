import random

data_size = 100000
data_max = 1000
bin_size = 100
scale = data_max / bin_size

input_data = [int(random.random() * data_max) for x in range(data_size)]

result = [0] * bin_size

for num in input_data:
    result[int(num / scale)] += 1

def print_arr(array_type, array_name, array_sz, pyarr):
    print "{} {}[{}] = ".format(array_type, array_name, array_sz)
    print "{"
    print ", ".join(map(str, pyarr))
    print "};"


print "#define DATA_MAX {}".format(data_max)
print "#define DATA_SIZE {}".format(data_size)

print_arr("int", "input_data", "DATA_SIZE", input_data)

print "#define NUM_BINS {}".format(bin_size)

print "int output_bins[NUM_BINS];"

print_arr("int", "verify_data", "NUM_BINS", result)
