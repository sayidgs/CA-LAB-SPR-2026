
li x10, 4 
# Call factorial
jal x1, fact
li x10, 1
# Move result from x8 to x11 for output
addi x11, x8, 0 
ecall
# Jump to exit
j exit

# Factorial function
fact:
    # Initialize x8 with input
    addi x8, x10, 0
    # Set x29 to loop termination condition
    li x29, 2
# Main loop
Loop:
    # space on stack
    addi x2, x2, -4
    # Decrement counter
    addi x10, x10, -1
    # Multiply current result by counter
    mul x8, x8, x10
    # Store intermediate result on stack
    sw x8, 0(x2)
    # Deallocate stack space
    addi x2, x2, 4
    # Continue if x10 >= 2
    bge x10, x29, Loop
    # Return
    jalr x0, 0(x1)
# Exit
exit:
