li s0, 0x100 # array starting at s0x100, s0x104, s0x108 ....
li t0, 0 # index count
li s1, 5

LOOP:
beq t0, s1, End # index == len
slli t2, t0, 2 # offset = index * 4
add t3, s0, t2  # base index + offset 
sw t0, 0(t3)  # value at index into list at address t3
addi t0, t0, 1 # increment
j LOOP

End:
li s2, 2
jal ra, swap
j end



swap:
    slli t2, s2, 2
    add t3, s0, t2
    lw t5, 0(t3)
    lw t6, 0(s0)
    sw t6, 0(t3)
    sw t5, 0(s0)
    jalr x0, 0(x1) 


end: