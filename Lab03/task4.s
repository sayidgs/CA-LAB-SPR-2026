# String copy function
strcpy:
    # Save register on stack
    addi x2, x2, -4
    sw x19, 0(x2)
    li x19, 0

# Copy loop
loop:
    # Calculate addresses
    add x5, x10, x19
    add x6, x11, x19
    # Load and store bytes
    lbu x7, 0(x6)
    sb x7, 0(x5)
    # Check for null terminator
    beq x7, x0, done
    addi x19, x19, 1
    jal x0, loop

# Cleanup
done:
    lw x19, 0(x2)
    addi x2, x2, 4
    jalr x0, 0(x1)