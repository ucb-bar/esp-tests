#!/usr/bin/env python3

import numpy
import sys

KH = 3              # kernel height
KW = 3              # kernel width
OH = 68             # output height
OW = 68             # output width
IH = OH + KH - 1    # input height
IW = OW + KW - 1    # input width

def randf(size=None, minexp=-8, maxexp=0, maxmant=8):
    return numpy.ldexp(
        numpy.random.randint(1<<maxmant, size=size),
        numpy.random.randint(minexp, maxexp, size=size))

inputs = randf(size=(IH, IW)).astype(numpy.float32)
weights = randf(size=(KH, KW), maxexp=-2).astype(numpy.float32)
outputs = numpy.full((OH, OW), numpy.float32(0.0))

# Convolution
for kh in range(KH):
    for kw in range(KW):
        outputs += inputs[kh:(kh+OH),kw:(kw+OW)] * weights[kh][kw]


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

print('const float rand_k[KH][KW] = ', end='')
print_array(weights)
print()

print('const float rand_a[IH][IW] = ', end='')
print_array(inputs)
print()

print('const float rand_b_verify[OH][OW] = ', end='')
print_array(outputs)

