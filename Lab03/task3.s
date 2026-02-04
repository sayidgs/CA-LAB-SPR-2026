# Set up array values
li x10, 0x100
li x11, 6
li x5, 10
li x28, 4

# Calculate offset and store values
slli x6, x11, 2
add x7, x10, x6
sw x5, 0(x7)
addi x7, x7, 4
sw x28, 0(x7)
jal x1, swap
j exit

# Swap array elements
swap:
    # Setup stack
    li x2, 0x200
    addi x2, x2, -16
    lw x18, 0(x2)
    # Calculate indices
    slli x19, x11, 2
    add x10, x19, x10
    # Load values
    lw x18, 0(x10)
    addi x20, x10, 4
    lw x21, 0(x20)
    # Perform swap
    sw x21, 0(x10)
    sw x18, 0(x20)
    # Save to stack
    sw x18, 0(x2)
    sw x19, 4(x2)
    sw x20, 8(x2)
    sw x21, 12(x2)
    addi x2, x2, 16
    jalr x0, 0(x1)

exit: