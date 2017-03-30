
#include "vec-util.h"
    .text
    .align 3
    .globl load
    .type load, @function
# a0 is right edge
# a1 is dest block
# a2 is channels
# a3 is sourcewidth
# a4 is destwidth
# a5 is n iter
load:
    sll t1, a2, 2
    mul t2, a3, t1
    mul t3, a4, t1

    add t4, a0, zero 
    vmca va0, t4
    add t4, t4, t1
    vmca va6, t4
    add t4, t4, t1
    add a0, a0, t2
    add t4, a0, zero 
    vmca va1, t4
    add t4, t4, t1
    vmca va7, t4
    add t4, t4, t1
    add a0, a0, t2
    add t4, a0, zero 
    vmca va2, t4
    add t4, t4, t1
    vmca va8, t4
    add t4, t4, t1
    add a0, a0, t2
    add t4, a0, zero 
    vmca va3, t4
    add t4, t4, t1
    vmca va9, t4
    add t4, t4, t1
    add a0, a0, t2
    add t4, a0, zero 
    vmca va4, t4
    add t4, t4, t1
    vmca va10, t4
    add t4, t4, t1
    add a0, a0, t2
    add t4, a0, zero 
    vmca va5, t4
    add t4, t4, t1
    vmca va11, t4
    add t4, t4, t1
    add a0, a0, t2

    add t4, a1, zero 
    vmca va12, t4
    add t4, t4, t1
    vmca va13, t4
    add t4, t4, t1
    add a1, a1, t3
    add t4, a1, zero 
    vmca va14, t4
    add t4, t4, t1
    vmca va15, t4
    add t4, t4, t1
    add a1, a1, t3

    add t1, zero, 0
    beq t1, a5, LOAD0
    add t1, zero, 1
    beq t1, a5, LOAD1
    add t1, zero, 2
    beq t1, a5, LOAD2
    add t1, zero, 3
    beq t1, a5, LOAD3
    add t1, zero, 4
    beq t1, a5, LOAD4
    add t1, zero, 5
    beq t1, a5, LOAD5
LOAD0:
    la t0, VFLOAD0
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret
LOAD1:
    la t0, VFLOAD1
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret
LOAD2:
    la t0, VFLOAD2
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret
LOAD3:
    la t0, VFLOAD3
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret
LOAD4:
    la t0, VFLOAD4
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret
LOAD5:
    la t0, VFLOAD5
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret

    .text
    .align 3
    .globl init
    .type init, @function
# a0 is src
# a1 is channels
# a2 is sourcewidth
init:
    sll t0, a1, 2
    mul t1, a2, t0 

    add t2, a0, zero 
    vmca va0, t2
    add t2, t2, t0
    vmca va1, t2
    add t2, t2, t0
    vmca va2, t2
    add t2, t2, t0
    vmca va3, t2
    add t2, t2, t0
    add a0, a0, t1
    add t2, a0, zero 
    vmca va4, t2
    add t2, t2, t0
    vmca va5, t2
    add t2, t2, t0
    vmca va6, t2
    add t2, t2, t0
    vmca va7, t2
    add t2, t2, t0
    add a0, a0, t1
    add t2, a0, zero 
    vmca va8, t2
    add t2, t2, t0
    vmca va9, t2
    add t2, t2, t0
    vmca va10, t2
    add t2, t2, t0
    vmca va11, t2
    add t2, t2, t0
    add a0, a0, t1
    add t2, a0, zero 
    vmca va12, t2
    add t2, t2, t0
    vmca va13, t2
    add t2, t2, t0
    vmca va14, t2
    add t2, t2, t0
    vmca va15, t2
    add t2, t2, t0
    add a0, a0, t1
    add t2, a0, zero 
    vmca va16, t2
    add t2, t2, t0
    vmca va17, t2
    add t2, t2, t0
    vmca va18, t2
    add t2, t2, t0
    vmca va19, t2
    add t2, t2, t0
    add a0, a0, t1
    add t2, a0, zero 
    vmca va20, t2
    add t2, t2, t0
    vmca va21, t2
    add t2, t2, t0
    vmca va22, t2
    add t2, t2, t0
    vmca va23, t2
    add t2, t2, t0
    add a0, a0, t1
    la t0, VFINIT
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret

    .text
    .align 3
    .globl loadkern
    .type loadkern, @function
# a0 is kernel
# a1 is channels
loadkern:
    sll t0, a1, 2
    vmca va0, a0
    add a0, a0, t0
    vmca va1, a0
    add a0, a0, t0
    vmca va2, a0
    add a0, a0, t0
    vmca va3, a0
    add a0, a0, t0
    vmca va4, a0
    add a0, a0, t0
    vmca va5, a0
    add a0, a0, t0
    vmca va6, a0
    add a0, a0, t0
    vmca va7, a0
    add a0, a0, t0
    vmca va8, a0
    add a0, a0, t0
    vmca va9, a0
    add a0, a0, t0
    vmca va10, a0
    add a0, a0, t0
    vmca va11, a0
    add a0, a0, t0
    vmca va12, a0
    add a0, a0, t0
    vmca va13, a0
    add a0, a0, t0
    vmca va14, a0
    add a0, a0, t0
    vmca va15, a0
    add a0, a0, t0
    vmca va16, a0
    add a0, a0, t0
    vmca va17, a0
    add a0, a0, t0
    vmca va18, a0
    add a0, a0, t0
    vmca va19, a0
    add a0, a0, t0
    vmca va20, a0
    add a0, a0, t0
    vmca va21, a0
    add a0, a0, t0
    vmca va22, a0
    add a0, a0, t0
    vmca va23, a0
    add a0, a0, t0
    vmca va24, a0
    add a0, a0, t0
    la t0, VFLOADKERN
    lw t1, 0(t0)
    vf 0(t0)
    fence
    ret

    .text
    .align 3
    .globl setvl
    .type setvl, @function
setvl:
    li t0, VCFG(0, 62, 0, 1)
    vsetcfg t0
    vsetvl t0, a0
    fence
    ret

    .align 8
VFLOAD0:
    vlw vv29, va0
    vlw vv35, va1
    vlw vv41, va2
    vlw vv47, va3
    vlw vv53, va4
    vlw vv59, va5
    vlw vv30, va6
    vlw vv36, va7
    vlw vv42, va8
    vlw vv48, va9
    vlw vv54, va10
    vlw vv60, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv25, vv61
    vfmadd.s vv61, vv1, vv26, vv61
    vfmadd.s vv61, vv2, vv27, vv61
    vfmadd.s vv61, vv3, vv28, vv61
    vfmadd.s vv61, vv4, vv29, vv61
    vfmadd.s vv61, vv5, vv31, vv61
    vfmadd.s vv61, vv6, vv32, vv61
    vfmadd.s vv61, vv7, vv33, vv61
    vfmadd.s vv61, vv8, vv34, vv61
    vfmadd.s vv61, vv9, vv35, vv61
    vfmadd.s vv61, vv10, vv37, vv61
    vfmadd.s vv61, vv11, vv38, vv61
    vfmadd.s vv61, vv12, vv39, vv61
    vfmadd.s vv61, vv13, vv40, vv61
    vfmadd.s vv61, vv14, vv41, vv61
    vfmadd.s vv61, vv15, vv43, vv61
    vfmadd.s vv61, vv16, vv44, vv61
    vfmadd.s vv61, vv17, vv45, vv61
    vfmadd.s vv61, vv18, vv46, vv61
    vfmadd.s vv61, vv19, vv47, vv61
    vfmadd.s vv61, vv20, vv49, vv61
    vfmadd.s vv61, vv21, vv50, vv61
    vfmadd.s vv61, vv22, vv51, vv61
    vfmadd.s vv61, vv23, vv52, vv61
    vfmadd.s vv61, vv24, vv53, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv26, vv61
    vfmadd.s vv61, vv1, vv27, vv61
    vfmadd.s vv61, vv2, vv28, vv61
    vfmadd.s vv61, vv3, vv29, vv61
    vfmadd.s vv61, vv4, vv30, vv61
    vfmadd.s vv61, vv5, vv32, vv61
    vfmadd.s vv61, vv6, vv33, vv61
    vfmadd.s vv61, vv7, vv34, vv61
    vfmadd.s vv61, vv8, vv35, vv61
    vfmadd.s vv61, vv9, vv36, vv61
    vfmadd.s vv61, vv10, vv38, vv61
    vfmadd.s vv61, vv11, vv39, vv61
    vfmadd.s vv61, vv12, vv40, vv61
    vfmadd.s vv61, vv13, vv41, vv61
    vfmadd.s vv61, vv14, vv42, vv61
    vfmadd.s vv61, vv15, vv44, vv61
    vfmadd.s vv61, vv16, vv45, vv61
    vfmadd.s vv61, vv17, vv46, vv61
    vfmadd.s vv61, vv18, vv47, vv61
    vfmadd.s vv61, vv19, vv48, vv61
    vfmadd.s vv61, vv20, vv50, vv61
    vfmadd.s vv61, vv21, vv51, vv61
    vfmadd.s vv61, vv22, vv52, vv61
    vfmadd.s vv61, vv23, vv53, vv61
    vfmadd.s vv61, vv24, vv54, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv31, vv61
    vfmadd.s vv61, vv1, vv32, vv61
    vfmadd.s vv61, vv2, vv33, vv61
    vfmadd.s vv61, vv3, vv34, vv61
    vfmadd.s vv61, vv4, vv35, vv61
    vfmadd.s vv61, vv5, vv37, vv61
    vfmadd.s vv61, vv6, vv38, vv61
    vfmadd.s vv61, vv7, vv39, vv61
    vfmadd.s vv61, vv8, vv40, vv61
    vfmadd.s vv61, vv9, vv41, vv61
    vfmadd.s vv61, vv10, vv43, vv61
    vfmadd.s vv61, vv11, vv44, vv61
    vfmadd.s vv61, vv12, vv45, vv61
    vfmadd.s vv61, vv13, vv46, vv61
    vfmadd.s vv61, vv14, vv47, vv61
    vfmadd.s vv61, vv15, vv49, vv61
    vfmadd.s vv61, vv16, vv50, vv61
    vfmadd.s vv61, vv17, vv51, vv61
    vfmadd.s vv61, vv18, vv52, vv61
    vfmadd.s vv61, vv19, vv53, vv61
    vfmadd.s vv61, vv20, vv55, vv61
    vfmadd.s vv61, vv21, vv56, vv61
    vfmadd.s vv61, vv22, vv57, vv61
    vfmadd.s vv61, vv23, vv58, vv61
    vfmadd.s vv61, vv24, vv59, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv32, vv61
    vfmadd.s vv61, vv1, vv33, vv61
    vfmadd.s vv61, vv2, vv34, vv61
    vfmadd.s vv61, vv3, vv35, vv61
    vfmadd.s vv61, vv4, vv36, vv61
    vfmadd.s vv61, vv5, vv38, vv61
    vfmadd.s vv61, vv6, vv39, vv61
    vfmadd.s vv61, vv7, vv40, vv61
    vfmadd.s vv61, vv8, vv41, vv61
    vfmadd.s vv61, vv9, vv42, vv61
    vfmadd.s vv61, vv10, vv44, vv61
    vfmadd.s vv61, vv11, vv45, vv61
    vfmadd.s vv61, vv12, vv46, vv61
    vfmadd.s vv61, vv13, vv47, vv61
    vfmadd.s vv61, vv14, vv48, vv61
    vfmadd.s vv61, vv15, vv50, vv61
    vfmadd.s vv61, vv16, vv51, vv61
    vfmadd.s vv61, vv17, vv52, vv61
    vfmadd.s vv61, vv18, vv53, vv61
    vfmadd.s vv61, vv19, vv54, vv61
    vfmadd.s vv61, vv20, vv56, vv61
    vfmadd.s vv61, vv21, vv57, vv61
    vfmadd.s vv61, vv22, vv58, vv61
    vfmadd.s vv61, vv23, vv59, vv61
    vfmadd.s vv61, vv24, vv60, vv61
    vsw vv61, va15
    vstop
    .align 8
VFLOAD1:
    vlw vv30, va0
    vlw vv36, va1
    vlw vv42, va2
    vlw vv48, va3
    vlw vv54, va4
    vlw vv60, va5
    vlw vv25, va6
    vlw vv31, va7
    vlw vv37, va8
    vlw vv43, va9
    vlw vv49, va10
    vlw vv55, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv26, vv61
    vfmadd.s vv61, vv1, vv27, vv61
    vfmadd.s vv61, vv2, vv28, vv61
    vfmadd.s vv61, vv3, vv29, vv61
    vfmadd.s vv61, vv4, vv30, vv61
    vfmadd.s vv61, vv5, vv32, vv61
    vfmadd.s vv61, vv6, vv33, vv61
    vfmadd.s vv61, vv7, vv34, vv61
    vfmadd.s vv61, vv8, vv35, vv61
    vfmadd.s vv61, vv9, vv36, vv61
    vfmadd.s vv61, vv10, vv38, vv61
    vfmadd.s vv61, vv11, vv39, vv61
    vfmadd.s vv61, vv12, vv40, vv61
    vfmadd.s vv61, vv13, vv41, vv61
    vfmadd.s vv61, vv14, vv42, vv61
    vfmadd.s vv61, vv15, vv44, vv61
    vfmadd.s vv61, vv16, vv45, vv61
    vfmadd.s vv61, vv17, vv46, vv61
    vfmadd.s vv61, vv18, vv47, vv61
    vfmadd.s vv61, vv19, vv48, vv61
    vfmadd.s vv61, vv20, vv50, vv61
    vfmadd.s vv61, vv21, vv51, vv61
    vfmadd.s vv61, vv22, vv52, vv61
    vfmadd.s vv61, vv23, vv53, vv61
    vfmadd.s vv61, vv24, vv54, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv27, vv61
    vfmadd.s vv61, vv1, vv28, vv61
    vfmadd.s vv61, vv2, vv29, vv61
    vfmadd.s vv61, vv3, vv30, vv61
    vfmadd.s vv61, vv4, vv25, vv61
    vfmadd.s vv61, vv5, vv33, vv61
    vfmadd.s vv61, vv6, vv34, vv61
    vfmadd.s vv61, vv7, vv35, vv61
    vfmadd.s vv61, vv8, vv36, vv61
    vfmadd.s vv61, vv9, vv31, vv61
    vfmadd.s vv61, vv10, vv39, vv61
    vfmadd.s vv61, vv11, vv40, vv61
    vfmadd.s vv61, vv12, vv41, vv61
    vfmadd.s vv61, vv13, vv42, vv61
    vfmadd.s vv61, vv14, vv37, vv61
    vfmadd.s vv61, vv15, vv45, vv61
    vfmadd.s vv61, vv16, vv46, vv61
    vfmadd.s vv61, vv17, vv47, vv61
    vfmadd.s vv61, vv18, vv48, vv61
    vfmadd.s vv61, vv19, vv43, vv61
    vfmadd.s vv61, vv20, vv51, vv61
    vfmadd.s vv61, vv21, vv52, vv61
    vfmadd.s vv61, vv22, vv53, vv61
    vfmadd.s vv61, vv23, vv54, vv61
    vfmadd.s vv61, vv24, vv49, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv32, vv61
    vfmadd.s vv61, vv1, vv33, vv61
    vfmadd.s vv61, vv2, vv34, vv61
    vfmadd.s vv61, vv3, vv35, vv61
    vfmadd.s vv61, vv4, vv36, vv61
    vfmadd.s vv61, vv5, vv38, vv61
    vfmadd.s vv61, vv6, vv39, vv61
    vfmadd.s vv61, vv7, vv40, vv61
    vfmadd.s vv61, vv8, vv41, vv61
    vfmadd.s vv61, vv9, vv42, vv61
    vfmadd.s vv61, vv10, vv44, vv61
    vfmadd.s vv61, vv11, vv45, vv61
    vfmadd.s vv61, vv12, vv46, vv61
    vfmadd.s vv61, vv13, vv47, vv61
    vfmadd.s vv61, vv14, vv48, vv61
    vfmadd.s vv61, vv15, vv50, vv61
    vfmadd.s vv61, vv16, vv51, vv61
    vfmadd.s vv61, vv17, vv52, vv61
    vfmadd.s vv61, vv18, vv53, vv61
    vfmadd.s vv61, vv19, vv54, vv61
    vfmadd.s vv61, vv20, vv56, vv61
    vfmadd.s vv61, vv21, vv57, vv61
    vfmadd.s vv61, vv22, vv58, vv61
    vfmadd.s vv61, vv23, vv59, vv61
    vfmadd.s vv61, vv24, vv60, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv33, vv61
    vfmadd.s vv61, vv1, vv34, vv61
    vfmadd.s vv61, vv2, vv35, vv61
    vfmadd.s vv61, vv3, vv36, vv61
    vfmadd.s vv61, vv4, vv31, vv61
    vfmadd.s vv61, vv5, vv39, vv61
    vfmadd.s vv61, vv6, vv40, vv61
    vfmadd.s vv61, vv7, vv41, vv61
    vfmadd.s vv61, vv8, vv42, vv61
    vfmadd.s vv61, vv9, vv37, vv61
    vfmadd.s vv61, vv10, vv45, vv61
    vfmadd.s vv61, vv11, vv46, vv61
    vfmadd.s vv61, vv12, vv47, vv61
    vfmadd.s vv61, vv13, vv48, vv61
    vfmadd.s vv61, vv14, vv43, vv61
    vfmadd.s vv61, vv15, vv51, vv61
    vfmadd.s vv61, vv16, vv52, vv61
    vfmadd.s vv61, vv17, vv53, vv61
    vfmadd.s vv61, vv18, vv54, vv61
    vfmadd.s vv61, vv19, vv49, vv61
    vfmadd.s vv61, vv20, vv57, vv61
    vfmadd.s vv61, vv21, vv58, vv61
    vfmadd.s vv61, vv22, vv59, vv61
    vfmadd.s vv61, vv23, vv60, vv61
    vfmadd.s vv61, vv24, vv55, vv61
    vsw vv61, va15
    vstop
    .align 8
VFLOAD2:
    vlw vv25, va0
    vlw vv31, va1
    vlw vv37, va2
    vlw vv43, va3
    vlw vv49, va4
    vlw vv55, va5
    vlw vv26, va6
    vlw vv32, va7
    vlw vv38, va8
    vlw vv44, va9
    vlw vv50, va10
    vlw vv56, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv27, vv61
    vfmadd.s vv61, vv1, vv28, vv61
    vfmadd.s vv61, vv2, vv29, vv61
    vfmadd.s vv61, vv3, vv30, vv61
    vfmadd.s vv61, vv4, vv25, vv61
    vfmadd.s vv61, vv5, vv33, vv61
    vfmadd.s vv61, vv6, vv34, vv61
    vfmadd.s vv61, vv7, vv35, vv61
    vfmadd.s vv61, vv8, vv36, vv61
    vfmadd.s vv61, vv9, vv31, vv61
    vfmadd.s vv61, vv10, vv39, vv61
    vfmadd.s vv61, vv11, vv40, vv61
    vfmadd.s vv61, vv12, vv41, vv61
    vfmadd.s vv61, vv13, vv42, vv61
    vfmadd.s vv61, vv14, vv37, vv61
    vfmadd.s vv61, vv15, vv45, vv61
    vfmadd.s vv61, vv16, vv46, vv61
    vfmadd.s vv61, vv17, vv47, vv61
    vfmadd.s vv61, vv18, vv48, vv61
    vfmadd.s vv61, vv19, vv43, vv61
    vfmadd.s vv61, vv20, vv51, vv61
    vfmadd.s vv61, vv21, vv52, vv61
    vfmadd.s vv61, vv22, vv53, vv61
    vfmadd.s vv61, vv23, vv54, vv61
    vfmadd.s vv61, vv24, vv49, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv28, vv61
    vfmadd.s vv61, vv1, vv29, vv61
    vfmadd.s vv61, vv2, vv30, vv61
    vfmadd.s vv61, vv3, vv25, vv61
    vfmadd.s vv61, vv4, vv26, vv61
    vfmadd.s vv61, vv5, vv34, vv61
    vfmadd.s vv61, vv6, vv35, vv61
    vfmadd.s vv61, vv7, vv36, vv61
    vfmadd.s vv61, vv8, vv31, vv61
    vfmadd.s vv61, vv9, vv32, vv61
    vfmadd.s vv61, vv10, vv40, vv61
    vfmadd.s vv61, vv11, vv41, vv61
    vfmadd.s vv61, vv12, vv42, vv61
    vfmadd.s vv61, vv13, vv37, vv61
    vfmadd.s vv61, vv14, vv38, vv61
    vfmadd.s vv61, vv15, vv46, vv61
    vfmadd.s vv61, vv16, vv47, vv61
    vfmadd.s vv61, vv17, vv48, vv61
    vfmadd.s vv61, vv18, vv43, vv61
    vfmadd.s vv61, vv19, vv44, vv61
    vfmadd.s vv61, vv20, vv52, vv61
    vfmadd.s vv61, vv21, vv53, vv61
    vfmadd.s vv61, vv22, vv54, vv61
    vfmadd.s vv61, vv23, vv49, vv61
    vfmadd.s vv61, vv24, vv50, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv33, vv61
    vfmadd.s vv61, vv1, vv34, vv61
    vfmadd.s vv61, vv2, vv35, vv61
    vfmadd.s vv61, vv3, vv36, vv61
    vfmadd.s vv61, vv4, vv31, vv61
    vfmadd.s vv61, vv5, vv39, vv61
    vfmadd.s vv61, vv6, vv40, vv61
    vfmadd.s vv61, vv7, vv41, vv61
    vfmadd.s vv61, vv8, vv42, vv61
    vfmadd.s vv61, vv9, vv37, vv61
    vfmadd.s vv61, vv10, vv45, vv61
    vfmadd.s vv61, vv11, vv46, vv61
    vfmadd.s vv61, vv12, vv47, vv61
    vfmadd.s vv61, vv13, vv48, vv61
    vfmadd.s vv61, vv14, vv43, vv61
    vfmadd.s vv61, vv15, vv51, vv61
    vfmadd.s vv61, vv16, vv52, vv61
    vfmadd.s vv61, vv17, vv53, vv61
    vfmadd.s vv61, vv18, vv54, vv61
    vfmadd.s vv61, vv19, vv49, vv61
    vfmadd.s vv61, vv20, vv57, vv61
    vfmadd.s vv61, vv21, vv58, vv61
    vfmadd.s vv61, vv22, vv59, vv61
    vfmadd.s vv61, vv23, vv60, vv61
    vfmadd.s vv61, vv24, vv55, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv34, vv61
    vfmadd.s vv61, vv1, vv35, vv61
    vfmadd.s vv61, vv2, vv36, vv61
    vfmadd.s vv61, vv3, vv31, vv61
    vfmadd.s vv61, vv4, vv32, vv61
    vfmadd.s vv61, vv5, vv40, vv61
    vfmadd.s vv61, vv6, vv41, vv61
    vfmadd.s vv61, vv7, vv42, vv61
    vfmadd.s vv61, vv8, vv37, vv61
    vfmadd.s vv61, vv9, vv38, vv61
    vfmadd.s vv61, vv10, vv46, vv61
    vfmadd.s vv61, vv11, vv47, vv61
    vfmadd.s vv61, vv12, vv48, vv61
    vfmadd.s vv61, vv13, vv43, vv61
    vfmadd.s vv61, vv14, vv44, vv61
    vfmadd.s vv61, vv15, vv52, vv61
    vfmadd.s vv61, vv16, vv53, vv61
    vfmadd.s vv61, vv17, vv54, vv61
    vfmadd.s vv61, vv18, vv49, vv61
    vfmadd.s vv61, vv19, vv50, vv61
    vfmadd.s vv61, vv20, vv58, vv61
    vfmadd.s vv61, vv21, vv59, vv61
    vfmadd.s vv61, vv22, vv60, vv61
    vfmadd.s vv61, vv23, vv55, vv61
    vfmadd.s vv61, vv24, vv56, vv61
    vsw vv61, va15
    vstop
    .align 8
VFLOAD3:
    vlw vv26, va0
    vlw vv32, va1
    vlw vv38, va2
    vlw vv44, va3
    vlw vv50, va4
    vlw vv56, va5
    vlw vv27, va6
    vlw vv33, va7
    vlw vv39, va8
    vlw vv45, va9
    vlw vv51, va10
    vlw vv57, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv28, vv61
    vfmadd.s vv61, vv1, vv29, vv61
    vfmadd.s vv61, vv2, vv30, vv61
    vfmadd.s vv61, vv3, vv25, vv61
    vfmadd.s vv61, vv4, vv26, vv61
    vfmadd.s vv61, vv5, vv34, vv61
    vfmadd.s vv61, vv6, vv35, vv61
    vfmadd.s vv61, vv7, vv36, vv61
    vfmadd.s vv61, vv8, vv31, vv61
    vfmadd.s vv61, vv9, vv32, vv61
    vfmadd.s vv61, vv10, vv40, vv61
    vfmadd.s vv61, vv11, vv41, vv61
    vfmadd.s vv61, vv12, vv42, vv61
    vfmadd.s vv61, vv13, vv37, vv61
    vfmadd.s vv61, vv14, vv38, vv61
    vfmadd.s vv61, vv15, vv46, vv61
    vfmadd.s vv61, vv16, vv47, vv61
    vfmadd.s vv61, vv17, vv48, vv61
    vfmadd.s vv61, vv18, vv43, vv61
    vfmadd.s vv61, vv19, vv44, vv61
    vfmadd.s vv61, vv20, vv52, vv61
    vfmadd.s vv61, vv21, vv53, vv61
    vfmadd.s vv61, vv22, vv54, vv61
    vfmadd.s vv61, vv23, vv49, vv61
    vfmadd.s vv61, vv24, vv50, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv29, vv61
    vfmadd.s vv61, vv1, vv30, vv61
    vfmadd.s vv61, vv2, vv25, vv61
    vfmadd.s vv61, vv3, vv26, vv61
    vfmadd.s vv61, vv4, vv27, vv61
    vfmadd.s vv61, vv5, vv35, vv61
    vfmadd.s vv61, vv6, vv36, vv61
    vfmadd.s vv61, vv7, vv31, vv61
    vfmadd.s vv61, vv8, vv32, vv61
    vfmadd.s vv61, vv9, vv33, vv61
    vfmadd.s vv61, vv10, vv41, vv61
    vfmadd.s vv61, vv11, vv42, vv61
    vfmadd.s vv61, vv12, vv37, vv61
    vfmadd.s vv61, vv13, vv38, vv61
    vfmadd.s vv61, vv14, vv39, vv61
    vfmadd.s vv61, vv15, vv47, vv61
    vfmadd.s vv61, vv16, vv48, vv61
    vfmadd.s vv61, vv17, vv43, vv61
    vfmadd.s vv61, vv18, vv44, vv61
    vfmadd.s vv61, vv19, vv45, vv61
    vfmadd.s vv61, vv20, vv53, vv61
    vfmadd.s vv61, vv21, vv54, vv61
    vfmadd.s vv61, vv22, vv49, vv61
    vfmadd.s vv61, vv23, vv50, vv61
    vfmadd.s vv61, vv24, vv51, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv34, vv61
    vfmadd.s vv61, vv1, vv35, vv61
    vfmadd.s vv61, vv2, vv36, vv61
    vfmadd.s vv61, vv3, vv31, vv61
    vfmadd.s vv61, vv4, vv32, vv61
    vfmadd.s vv61, vv5, vv40, vv61
    vfmadd.s vv61, vv6, vv41, vv61
    vfmadd.s vv61, vv7, vv42, vv61
    vfmadd.s vv61, vv8, vv37, vv61
    vfmadd.s vv61, vv9, vv38, vv61
    vfmadd.s vv61, vv10, vv46, vv61
    vfmadd.s vv61, vv11, vv47, vv61
    vfmadd.s vv61, vv12, vv48, vv61
    vfmadd.s vv61, vv13, vv43, vv61
    vfmadd.s vv61, vv14, vv44, vv61
    vfmadd.s vv61, vv15, vv52, vv61
    vfmadd.s vv61, vv16, vv53, vv61
    vfmadd.s vv61, vv17, vv54, vv61
    vfmadd.s vv61, vv18, vv49, vv61
    vfmadd.s vv61, vv19, vv50, vv61
    vfmadd.s vv61, vv20, vv58, vv61
    vfmadd.s vv61, vv21, vv59, vv61
    vfmadd.s vv61, vv22, vv60, vv61
    vfmadd.s vv61, vv23, vv55, vv61
    vfmadd.s vv61, vv24, vv56, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv35, vv61
    vfmadd.s vv61, vv1, vv36, vv61
    vfmadd.s vv61, vv2, vv31, vv61
    vfmadd.s vv61, vv3, vv32, vv61
    vfmadd.s vv61, vv4, vv33, vv61
    vfmadd.s vv61, vv5, vv41, vv61
    vfmadd.s vv61, vv6, vv42, vv61
    vfmadd.s vv61, vv7, vv37, vv61
    vfmadd.s vv61, vv8, vv38, vv61
    vfmadd.s vv61, vv9, vv39, vv61
    vfmadd.s vv61, vv10, vv47, vv61
    vfmadd.s vv61, vv11, vv48, vv61
    vfmadd.s vv61, vv12, vv43, vv61
    vfmadd.s vv61, vv13, vv44, vv61
    vfmadd.s vv61, vv14, vv45, vv61
    vfmadd.s vv61, vv15, vv53, vv61
    vfmadd.s vv61, vv16, vv54, vv61
    vfmadd.s vv61, vv17, vv49, vv61
    vfmadd.s vv61, vv18, vv50, vv61
    vfmadd.s vv61, vv19, vv51, vv61
    vfmadd.s vv61, vv20, vv59, vv61
    vfmadd.s vv61, vv21, vv60, vv61
    vfmadd.s vv61, vv22, vv55, vv61
    vfmadd.s vv61, vv23, vv56, vv61
    vfmadd.s vv61, vv24, vv57, vv61
    vsw vv61, va15
    vstop
    .align 8
VFLOAD4:
    vlw vv27, va0
    vlw vv33, va1
    vlw vv39, va2
    vlw vv45, va3
    vlw vv51, va4
    vlw vv57, va5
    vlw vv28, va6
    vlw vv34, va7
    vlw vv40, va8
    vlw vv46, va9
    vlw vv52, va10
    vlw vv58, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv29, vv61
    vfmadd.s vv61, vv1, vv30, vv61
    vfmadd.s vv61, vv2, vv25, vv61
    vfmadd.s vv61, vv3, vv26, vv61
    vfmadd.s vv61, vv4, vv27, vv61
    vfmadd.s vv61, vv5, vv35, vv61
    vfmadd.s vv61, vv6, vv36, vv61
    vfmadd.s vv61, vv7, vv31, vv61
    vfmadd.s vv61, vv8, vv32, vv61
    vfmadd.s vv61, vv9, vv33, vv61
    vfmadd.s vv61, vv10, vv41, vv61
    vfmadd.s vv61, vv11, vv42, vv61
    vfmadd.s vv61, vv12, vv37, vv61
    vfmadd.s vv61, vv13, vv38, vv61
    vfmadd.s vv61, vv14, vv39, vv61
    vfmadd.s vv61, vv15, vv47, vv61
    vfmadd.s vv61, vv16, vv48, vv61
    vfmadd.s vv61, vv17, vv43, vv61
    vfmadd.s vv61, vv18, vv44, vv61
    vfmadd.s vv61, vv19, vv45, vv61
    vfmadd.s vv61, vv20, vv53, vv61
    vfmadd.s vv61, vv21, vv54, vv61
    vfmadd.s vv61, vv22, vv49, vv61
    vfmadd.s vv61, vv23, vv50, vv61
    vfmadd.s vv61, vv24, vv51, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv30, vv61
    vfmadd.s vv61, vv1, vv25, vv61
    vfmadd.s vv61, vv2, vv26, vv61
    vfmadd.s vv61, vv3, vv27, vv61
    vfmadd.s vv61, vv4, vv28, vv61
    vfmadd.s vv61, vv5, vv36, vv61
    vfmadd.s vv61, vv6, vv31, vv61
    vfmadd.s vv61, vv7, vv32, vv61
    vfmadd.s vv61, vv8, vv33, vv61
    vfmadd.s vv61, vv9, vv34, vv61
    vfmadd.s vv61, vv10, vv42, vv61
    vfmadd.s vv61, vv11, vv37, vv61
    vfmadd.s vv61, vv12, vv38, vv61
    vfmadd.s vv61, vv13, vv39, vv61
    vfmadd.s vv61, vv14, vv40, vv61
    vfmadd.s vv61, vv15, vv48, vv61
    vfmadd.s vv61, vv16, vv43, vv61
    vfmadd.s vv61, vv17, vv44, vv61
    vfmadd.s vv61, vv18, vv45, vv61
    vfmadd.s vv61, vv19, vv46, vv61
    vfmadd.s vv61, vv20, vv54, vv61
    vfmadd.s vv61, vv21, vv49, vv61
    vfmadd.s vv61, vv22, vv50, vv61
    vfmadd.s vv61, vv23, vv51, vv61
    vfmadd.s vv61, vv24, vv52, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv35, vv61
    vfmadd.s vv61, vv1, vv36, vv61
    vfmadd.s vv61, vv2, vv31, vv61
    vfmadd.s vv61, vv3, vv32, vv61
    vfmadd.s vv61, vv4, vv33, vv61
    vfmadd.s vv61, vv5, vv41, vv61
    vfmadd.s vv61, vv6, vv42, vv61
    vfmadd.s vv61, vv7, vv37, vv61
    vfmadd.s vv61, vv8, vv38, vv61
    vfmadd.s vv61, vv9, vv39, vv61
    vfmadd.s vv61, vv10, vv47, vv61
    vfmadd.s vv61, vv11, vv48, vv61
    vfmadd.s vv61, vv12, vv43, vv61
    vfmadd.s vv61, vv13, vv44, vv61
    vfmadd.s vv61, vv14, vv45, vv61
    vfmadd.s vv61, vv15, vv53, vv61
    vfmadd.s vv61, vv16, vv54, vv61
    vfmadd.s vv61, vv17, vv49, vv61
    vfmadd.s vv61, vv18, vv50, vv61
    vfmadd.s vv61, vv19, vv51, vv61
    vfmadd.s vv61, vv20, vv59, vv61
    vfmadd.s vv61, vv21, vv60, vv61
    vfmadd.s vv61, vv22, vv55, vv61
    vfmadd.s vv61, vv23, vv56, vv61
    vfmadd.s vv61, vv24, vv57, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv36, vv61
    vfmadd.s vv61, vv1, vv31, vv61
    vfmadd.s vv61, vv2, vv32, vv61
    vfmadd.s vv61, vv3, vv33, vv61
    vfmadd.s vv61, vv4, vv34, vv61
    vfmadd.s vv61, vv5, vv42, vv61
    vfmadd.s vv61, vv6, vv37, vv61
    vfmadd.s vv61, vv7, vv38, vv61
    vfmadd.s vv61, vv8, vv39, vv61
    vfmadd.s vv61, vv9, vv40, vv61
    vfmadd.s vv61, vv10, vv48, vv61
    vfmadd.s vv61, vv11, vv43, vv61
    vfmadd.s vv61, vv12, vv44, vv61
    vfmadd.s vv61, vv13, vv45, vv61
    vfmadd.s vv61, vv14, vv46, vv61
    vfmadd.s vv61, vv15, vv54, vv61
    vfmadd.s vv61, vv16, vv49, vv61
    vfmadd.s vv61, vv17, vv50, vv61
    vfmadd.s vv61, vv18, vv51, vv61
    vfmadd.s vv61, vv19, vv52, vv61
    vfmadd.s vv61, vv20, vv60, vv61
    vfmadd.s vv61, vv21, vv55, vv61
    vfmadd.s vv61, vv22, vv56, vv61
    vfmadd.s vv61, vv23, vv57, vv61
    vfmadd.s vv61, vv24, vv58, vv61
    vsw vv61, va15
    vstop
    .align 8
VFLOAD5:
    vlw vv28, va0
    vlw vv34, va1
    vlw vv40, va2
    vlw vv46, va3
    vlw vv52, va4
    vlw vv58, va5
    vlw vv29, va6
    vlw vv35, va7
    vlw vv41, va8
    vlw vv47, va9
    vlw vv53, va10
    vlw vv59, va11
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv30, vv61
    vfmadd.s vv61, vv1, vv25, vv61
    vfmadd.s vv61, vv2, vv26, vv61
    vfmadd.s vv61, vv3, vv27, vv61
    vfmadd.s vv61, vv4, vv28, vv61
    vfmadd.s vv61, vv5, vv36, vv61
    vfmadd.s vv61, vv6, vv31, vv61
    vfmadd.s vv61, vv7, vv32, vv61
    vfmadd.s vv61, vv8, vv33, vv61
    vfmadd.s vv61, vv9, vv34, vv61
    vfmadd.s vv61, vv10, vv42, vv61
    vfmadd.s vv61, vv11, vv37, vv61
    vfmadd.s vv61, vv12, vv38, vv61
    vfmadd.s vv61, vv13, vv39, vv61
    vfmadd.s vv61, vv14, vv40, vv61
    vfmadd.s vv61, vv15, vv48, vv61
    vfmadd.s vv61, vv16, vv43, vv61
    vfmadd.s vv61, vv17, vv44, vv61
    vfmadd.s vv61, vv18, vv45, vv61
    vfmadd.s vv61, vv19, vv46, vv61
    vfmadd.s vv61, vv20, vv54, vv61
    vfmadd.s vv61, vv21, vv49, vv61
    vfmadd.s vv61, vv22, vv50, vv61
    vfmadd.s vv61, vv23, vv51, vv61
    vfmadd.s vv61, vv24, vv52, vv61
    vsw vv61, va12
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv25, vv61
    vfmadd.s vv61, vv1, vv26, vv61
    vfmadd.s vv61, vv2, vv27, vv61
    vfmadd.s vv61, vv3, vv28, vv61
    vfmadd.s vv61, vv4, vv29, vv61
    vfmadd.s vv61, vv5, vv31, vv61
    vfmadd.s vv61, vv6, vv32, vv61
    vfmadd.s vv61, vv7, vv33, vv61
    vfmadd.s vv61, vv8, vv34, vv61
    vfmadd.s vv61, vv9, vv35, vv61
    vfmadd.s vv61, vv10, vv37, vv61
    vfmadd.s vv61, vv11, vv38, vv61
    vfmadd.s vv61, vv12, vv39, vv61
    vfmadd.s vv61, vv13, vv40, vv61
    vfmadd.s vv61, vv14, vv41, vv61
    vfmadd.s vv61, vv15, vv43, vv61
    vfmadd.s vv61, vv16, vv44, vv61
    vfmadd.s vv61, vv17, vv45, vv61
    vfmadd.s vv61, vv18, vv46, vv61
    vfmadd.s vv61, vv19, vv47, vv61
    vfmadd.s vv61, vv20, vv49, vv61
    vfmadd.s vv61, vv21, vv50, vv61
    vfmadd.s vv61, vv22, vv51, vv61
    vfmadd.s vv61, vv23, vv52, vv61
    vfmadd.s vv61, vv24, vv53, vv61
    vsw vv61, va13
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv36, vv61
    vfmadd.s vv61, vv1, vv31, vv61
    vfmadd.s vv61, vv2, vv32, vv61
    vfmadd.s vv61, vv3, vv33, vv61
    vfmadd.s vv61, vv4, vv34, vv61
    vfmadd.s vv61, vv5, vv42, vv61
    vfmadd.s vv61, vv6, vv37, vv61
    vfmadd.s vv61, vv7, vv38, vv61
    vfmadd.s vv61, vv8, vv39, vv61
    vfmadd.s vv61, vv9, vv40, vv61
    vfmadd.s vv61, vv10, vv48, vv61
    vfmadd.s vv61, vv11, vv43, vv61
    vfmadd.s vv61, vv12, vv44, vv61
    vfmadd.s vv61, vv13, vv45, vv61
    vfmadd.s vv61, vv14, vv46, vv61
    vfmadd.s vv61, vv15, vv54, vv61
    vfmadd.s vv61, vv16, vv49, vv61
    vfmadd.s vv61, vv17, vv50, vv61
    vfmadd.s vv61, vv18, vv51, vv61
    vfmadd.s vv61, vv19, vv52, vv61
    vfmadd.s vv61, vv20, vv60, vv61
    vfmadd.s vv61, vv21, vv55, vv61
    vfmadd.s vv61, vv22, vv56, vv61
    vfmadd.s vv61, vv23, vv57, vv61
    vfmadd.s vv61, vv24, vv58, vv61
    vsw vv61, va14
    vadd vv61, vs0, vs0
    vfmadd.s vv61, vv0, vv31, vv61
    vfmadd.s vv61, vv1, vv32, vv61
    vfmadd.s vv61, vv2, vv33, vv61
    vfmadd.s vv61, vv3, vv34, vv61
    vfmadd.s vv61, vv4, vv35, vv61
    vfmadd.s vv61, vv5, vv37, vv61
    vfmadd.s vv61, vv6, vv38, vv61
    vfmadd.s vv61, vv7, vv39, vv61
    vfmadd.s vv61, vv8, vv40, vv61
    vfmadd.s vv61, vv9, vv41, vv61
    vfmadd.s vv61, vv10, vv43, vv61
    vfmadd.s vv61, vv11, vv44, vv61
    vfmadd.s vv61, vv12, vv45, vv61
    vfmadd.s vv61, vv13, vv46, vv61
    vfmadd.s vv61, vv14, vv47, vv61
    vfmadd.s vv61, vv15, vv49, vv61
    vfmadd.s vv61, vv16, vv50, vv61
    vfmadd.s vv61, vv17, vv51, vv61
    vfmadd.s vv61, vv18, vv52, vv61
    vfmadd.s vv61, vv19, vv53, vv61
    vfmadd.s vv61, vv20, vv55, vv61
    vfmadd.s vv61, vv21, vv56, vv61
    vfmadd.s vv61, vv22, vv57, vv61
    vfmadd.s vv61, vv23, vv58, vv61
    vfmadd.s vv61, vv24, vv59, vv61
    vsw vv61, va15
    vstop
    .align 8
VFINIT:
    vlw vv25, va0
    vlw vv26, va1
    vlw vv27, va2
    vlw vv28, va3
    vlw vv31, va4
    vlw vv32, va5
    vlw vv33, va6
    vlw vv34, va7
    vlw vv37, va8
    vlw vv38, va9
    vlw vv39, va10
    vlw vv40, va11
    vlw vv43, va12
    vlw vv44, va13
    vlw vv45, va14
    vlw vv46, va15
    vlw vv49, va16
    vlw vv50, va17
    vlw vv51, va18
    vlw vv52, va19
    vlw vv55, va20
    vlw vv56, va21
    vlw vv57, va22
    vlw vv58, va23
    vstop
    .align 8
VFLOADKERN:
    vpset vp0
    vlw vv0, va0
    vlw vv1, va1
    vlw vv2, va2
    vlw vv3, va3
    vlw vv4, va4
    vlw vv5, va5
    vlw vv6, va6
    vlw vv7, va7
    vlw vv8, va8
    vlw vv9, va9
    vlw vv10, va10
    vlw vv11, va11
    vlw vv12, va12
    vlw vv13, va13
    vlw vv14, va14
    vlw vv15, va15
    vlw vv16, va16
    vlw vv17, va17
    vlw vv18, va18
    vlw vv19, va19
    vlw vv20, va20
    vlw vv21, va21
    vlw vv22, va22
    vlw vv23, va23
    vlw vv24, va24
    vstop
