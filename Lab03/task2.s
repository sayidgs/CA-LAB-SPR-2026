addi x10, x0, 10
addi x11, x0, 20
addi x12, x0, 30
addi x13, x0, 40

li x5, 0x100

jal x1, leaf_example
j end



swap:
    addi, x19, x10, x11
    add, x18, x12, x13
    sub x20, x18, x19 #x20 =x19 -  x18
    addi, x5, x20, 0
    jalr x0, 0(x1)

end:

    