li s0, 0x100 # array starting at s0x100, s0x104, s0x108 ....
li t0, 0 # index count
li t1, 0 # sum 
li s1, 10

LOOP:
beq t0, s1, End # index == len
slli t2, t0, 2 # offset = index * 4
add t3, s0, t2  # base index + offset 
sw t0, 0(t3)  # value at index into t4
# add t1, t1, t4
addi t0, t0, 1 # increment
j LOOP







End: