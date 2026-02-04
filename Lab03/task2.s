# Initialize variables
li x10, 3
li x11, 5
li x12, 8
li x13, 4

jal x1, leaf_example
li x10, 1
ecall
j exit

# Calculate sum and difference
leaf_example:
    # Setup stack
    li x2, 0x100
    addi x2, x2, -12
    lw x20, 8(x2)
    # Add pairs
    add x18, x10, x11
    add x19, x13, x12
    # Store on stack
    sw x18, 0(x2)
    sw x19, 4(x2)
    # Compute difference
    sub x20, x18, x19
    sw x20, 8(x2)
    # Restore result
    addi x11, x20, 0
    addi x2, x2, 12
    jalr x0, 0(x1)

exit: