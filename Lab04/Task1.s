li x10, 4 # 
jal x1, fact
li x10, 1
addi x11, x8, 0 
ecall
j exit
fact:
	addi x8, x10, 0
	li x29, 2
Loop:
	addi x2, x2, -4
    addi x10, x10, -1
    mul x8, x8, x10
    sw x8, 0(x2)
    addi x2, x2, 4
    bge x10, x29, Loop
    jalr x0, 0(x1)
exit: