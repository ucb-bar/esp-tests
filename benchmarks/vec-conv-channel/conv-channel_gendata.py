import random


channels = 32
srcwidth = 20
srcheight = 20
ksize = 2

kernel = [1.0]*(2*ksize+1)**2*channels
src = [1.0]*srcwidth*srcheight*channels


dest = [0.0] * srcwidth * srcheight * channels
result = [0.0] * srcwidth * srcheight * channels
for x in range(srcwidth):
    for y in range(srcheight):
        if x >= ksize and x < srcwidth - ksize and y >= ksize and y < srcheight - ksize:
            for c in range(channels):
                result[x*channels+y*channels*srcwidth + c] = (2*ksize+1)**2


def print_arr(array_type, array_name, array_sz, pyarr):
    print "{} {}[{}] = ".format(array_type, array_name, array_sz)
    print "{"
    print ", ".join(map(str, pyarr))
    print "};"


def print_scalar(scalar_type, scalar_name, pyscalar):
    print "{} {} = {};".format(scalar_type, scalar_name, pyscalar)

print "#define DATA_SIZE {}".format(srcwidth*srcheight*channels)
print "#define KERN_SIZE {}".format(channels*(2*ksize+1)**2)
print "#define SRCWIDTH {}".format(srcwidth)
print "#define SRCHEIGHT {}".format(srcheight)
print "#define CHANNELS {}".format(channels)
print "#define KSIZE {}".format(ksize)



print_arr("float", "input_src", "DATA_SIZE", src)

print_arr("float", "input_dest", "DATA_SIZE", dest)

print_arr("float", "input_kern", "KERN_SIZE", kernel)

print_arr("float", "verify_data", "DATA_SIZE", result)

