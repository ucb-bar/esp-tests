#!/usr/bin/env python3

import numpy
import sys

KH = 3              # kernel height
KW = 3              # kernel width
OH = 68             # output height
OW = 68             # output width
IH = OH + KH - 1    # input height
IW = OW + KW - 1    # input width

def randf(size=None, minexp=-8, maxexp=0, maxmant=5):
    return numpy.ldexp(
        numpy.random.randint(1<<maxmant, size=size),
        numpy.random.randint(minexp, maxexp, size=size))

inputs = randf(size=(IH, IW)).astype(numpy.float32)
weights_w = randf(size=KW, maxexp=-2).astype(numpy.float32)
weights_h = randf(size=KH, maxexp=-2).astype(numpy.float32)
temp = numpy.full((IH, OW), numpy.float32(0.0))
outputs = numpy.full((OH, OW), numpy.float32(0.0))

# 1xKW convolution
for kw in range(KW):
    temp += inputs[:, kw:(kw+OW)] * weights_w[kw]

# KHx1 convolution
for kh in range(KH):
    outputs += temp[kh:(kh+OH)] * weights_h[kh]


print('''#define KH {}
#define KW {}
#define IH {}
#define IW {}
#define OH {}
#define OW {}

'''.format(KH, KW, IH, IW, OH, OW))

def print_array(data, data_fmt='{}f', indent='  ', fold=16):
    def _helper(a, prefix):
        if a.ndim > 1:
            _prefix = prefix + indent
            for x in a:
                print(prefix, '{', sep='')
                _helper(x, _prefix)
                print(prefix, '},', sep='')
        else:
            for i in range(0, len(a), fold):
                print(prefix,
                    ', '.join(data_fmt.format(x) for x in a[i:i+fold]),
                    ',', sep='')

    print('{')
    _helper(data, indent)
    print('};')

print('const float rand_kw[KW] = ', end='')
print_array(weights_w)
print('const float rand_kh[KH] = ', end='')
print_array(weights_h)
print()


print('const float rand_a[IH][IW] = ', end='')
print_array(inputs)
print()

print('const float rand_b_verify[OH][OW] = ', end='')
print_array(outputs)

