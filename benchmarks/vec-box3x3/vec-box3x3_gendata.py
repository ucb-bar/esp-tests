#!/usr/bin/env python3
import random
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('rows', type=int, default=64, nargs='?')
parser.add_argument('cols', type=int, default=64, nargs='?')
args = parser.parse_args()

size = args.rows * args.cols

print('#define RAND_ROWS {}'.format(args.rows))
print('#define RAND_COLS {}'.format(args.cols))
print('#define RAND_A_STRIDE {}'.format(args.cols + 2))
print('#define RAND_B_STRIDE {}'.format(args.cols))

print('const static uint8_t rand_a[] = {')
for i in range(args.rows + 2):
    print('  ', end='')
    for j in range(args.cols + 2):
        print('0x{:02x},'.format(int(random.random() * 0x100)), end='')
    print('')
print('};')

print('const static int16_t rand_k[3][3] = {')
for i in range(3):
    print('  {{ {k[0]:d}, {k[1]:d}, {k[2]:d} }},'.format(
        k=[int(random.uniform(-0x8000, 0x7fff)) for x in range(3)]))
print('};')

print('static int8_t rand_b_verify[{}];'.format(size))
print('static int8_t rand_b_result[{}];'.format(size))
