import random

data_size = 10000
num_streams = 10

def print_arr(array_type, array_name, array_sz, pyarr):
    print "{} {}[{}] = ".format(array_type, array_name, array_sz)
    print "{"
    print ", ".join(map(str, pyarr))
    print "};"

def print_scalar(scalar_type, scalar_name, pyscalar):
    print "{} {} = {};".format(scalar_type, scalar_name, pyscalar)


class SpecialStr:
    def __init__(self, stri):
        self.stri = stri

    def __repr__(self):
        return self.stri


a = int(random.random()*1000.00)
Y = [int(random.random()*1000.00) for x in range(data_size)]

result = [x for x in Y]


print "#define DATA_SIZE {}".format(data_size)

print "#define NUM_STREAMS {}".format(num_streams)
print_scalar("float", "input_data_a", a)
print_arr("float", "input_data_Y", "DATA_SIZE", Y)

xstreams = []

for x in range(num_streams):
    arr_name = "input_data_X_"+str(x)
    X = [int(random.random()*1000.00) for x in range(data_size)]
    print_arr("float", arr_name, "DATA_SIZE", X)
    xstreams.append(SpecialStr(arr_name))

    for i in range(data_size):
        result[i] = a*X[i] + result[i]





print_arr("float *", "input_data_X_streams", num_streams, xstreams)

print_arr("float", "verify_data", "DATA_SIZE", result)


