import random

data_size = 10000

a = int(random.random()*1000.00)
X = [int(random.random()*1000.00) for x in range(data_size)]
Y = [int(random.random()*1000.00) for x in range(data_size)]

result = []

for i in range(data_size):
    result.append(a*X[i] + Y[i])


def print_arr(array_type, array_name, array_sz, pyarr):
    print "{} {}[{}] = ".format(array_type, array_name, array_sz)
    print "{"
    print ", ".join(map(str, pyarr))
    print "};"


def print_scalar(scalar_type, scalar_name, pyscalar):
    print "{} {} = {};".format(scalar_type, scalar_name, pyscalar)

print "#define DATA_SIZE {}".format(data_size)

print_scalar("float", "input_data_a", a)

print_arr("float", "input_data_X", "DATA_SIZE", X)

print_arr("float", "input_data_Y", "DATA_SIZE", Y)

print_arr("float", "verify_data", "DATA_SIZE", result)

