#include "vec_memcpy.h"
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

extern void vec_copy_d_asm(uintptr_t dst, uintptr_t src, size_t n);

void fill(int *arr, size_t n)
{
	for (int i = 0; i < n; i++) {
		arr[i] = i << 4;
	}
}

void vec_memcpy(void *dst, void *src, size_t len)
{
	uintptr_t dstaddr = (uintptr_t) dst;
	uintptr_t srcaddr = (uintptr_t) src;
	int n;

	// If dst and src are properly aligned,
	// use the vector move
	if (((dstaddr | srcaddr) & 0x7) == 0) {
		n = len / sizeof(uint64_t);
		vec_copy_d_asm(dstaddr, srcaddr, n);
		dst += (n * sizeof(uint64_t));
		src += (n * sizeof(uint64_t));
		len -= (n * sizeof(uint64_t));
	}

	memcpy(dst, src, len);
}
