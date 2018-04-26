import random

data_size = 128

X = [int(random.random()*100) for x in range(data_size*data_size)]
Y = [int(random.random()*100) for x in range(data_size*data_size)]


result = [0 for x in range(data_size*data_size)]

result_holder = [0 for x in range(data_size*data_size)]

for i in range(data_size):
    for j in range(data_size):
        for k in range(data_size):
            result[i*data_size+j] += X[i*data_size+k]*Y[k*data_size+j]            




def print_arr(array_type, array_name, array_sz, pyarr):
    print "{} __attribute__((aligned(16))) {}[{}] = ".format(array_type, array_name, array_sz)
    print "{"
    print ", ".join(map(str, pyarr))
    print "};"


def print_scalar(scalar_type, scalar_name, pyscalar):
    print "{} {} = {};".format(scalar_type, scalar_name, pyscalar)

print "#define MAT_WIDTH {}".format(data_size)

print_arr("double", "input_data_X", "MAT_WIDTH*MAT_WIDTH", X)

print_arr("double", "input_data_Y", "MAT_WIDTH*MAT_WIDTH", Y)

print_arr("double", "verify_data", "MAT_WIDTH*MAT_WIDTH", result)

print_arr("double", "result_holder", "MAT_WIDTH*MAT_WIDTH", result_holder)

