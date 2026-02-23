li x10, 5
# Call ntri 
jal x1, ntri
# Move result to x11
add x11, x10, x0
li x10, 1
ecall
# Jump to exit 
j exit

# Recursive triangular function
ntri:
    # Allocate bytes on stack
    addi sp, sp, -8
    # Save return address
    sw x1, 4(sp)
    # Save input value
    sw x10, 0(sp)
    # Calculate x10 - 1 and store in x5
    addi x5, x10, -1
    # If x5 > 0, continue recursion
    bgt x5, x0, L1
    # Base case: if num <= 1, return 1
    addi x10, x0, 1
    # Deallocate  bytes from stac
    addi sp, sp, 8
    # Return
    jalr x0, 0(x1)

# Recursive case 
L1:
    # Decrement input by 1
    addi x10, x10, -1
    # call ntri recursively
    jal x1, ntri
    # Save result in x6
    addi x6, x10, 0
    # Load original input value from stack
    lw x10, 0(sp)
    # Load return address from stack
    lw x1, 4(sp)
    # Deallocate bytes from stack
    addi sp, sp, 8
    add x10, x10, x6
    # Return
    jalr x0, 0(x1)
# Exit label
exit:
