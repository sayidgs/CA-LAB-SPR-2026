# Initialize registers for geometric series
li x1, 7            # x1 = n (number of terms = 7)
li x4, 1            # x4 = current term (starts at 1)
li x3, 3            # x3 = common ratio (3)

# Main loop: generate and store series terms
loop: 
    beq x1, x0, end     # if n == 0, exit loop
    
    # Store current term on stack
    addi sp, sp, -4     # allocate 4 bytes on stack
    sw x4, 0(sp)        # push current term onto stack
    
    # Calculate next term by multiplying by ratio
    mul x4, x4, x3      # current_term = current_term * common_ratio
    
    # Decrement counter and continue
    addi x1, x1, -1     # n--
    j loop              # continue loop

# Program end
end: 
    j end               # infinite loop (halt) 