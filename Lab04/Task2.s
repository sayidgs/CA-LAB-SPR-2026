li x10, 6
jal x1,fact
add x11,x10,x0
sw x10, 0(sp)
li x10,1
ecall
j exit
fact:
    addi sp, sp, -8
    sw x1,4(sp)
    sw x10,0(sp)
    addi x5,x10,-1
    bge x5, x0, L1
    addi x10,x0, 0
    addi sp,sp,8
    jalr x0, 0(x1)
L1:
    addi x10, x10, -1
    jal x1,fact
    addi x6,x10,0
    lw x10,0(sp)
    lw x1, 4(sp)
    addi sp,sp,8
    add x10,x10,x6
    jalr x0,0(x1)
exit: