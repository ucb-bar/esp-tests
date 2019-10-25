#
# Makefile for SPERT colorspace conversion

CC = spert0-gcc
NVCC = gcc
AS = spert0-gcc
CFLAGS = -g -DVECT
NVCFLAGS = -g -DNO_VECT
ASFLAGS =

conv: conv.o main.o
	$(CC) conv.o main.o -o conv

conv.o: conv.S
	$(AS) -c $(ASFLAGS) conv.S

main.o: main.c
	$(CC) -c $(CFLAGS) main.c

nv: main.c
	$(NVCC) $(NVCFLAGS) -o nv_conv main.c
