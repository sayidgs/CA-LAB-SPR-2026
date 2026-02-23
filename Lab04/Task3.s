# Populate the array in memory
li a0, 0x10000000   
li a1, 6         

# arr = [7, 5, 9, 15, 1, 10]
li t0, 7
sw t0, 0(a0)         #arr[0] = 7
li t0, 5
sw t0, 4(a0)         #arr[1] = 5
li t0, 9
sw t0, 8(a0)         #arr[2] = 9
li t0, 15
sw t0, 12(a0)        #arr[3] = 15
li t0, 1
sw t0, 16(a0)        #arr[4] = 1
li t0, 10
sw t0, 20(a0)        #arr[5] = 10

#Main Program
li t0, 0             # outer loop counter

outerloop: 
    bge t0, a1, done    # if i >= n, exit outer loop
    li t1, 0            # t1 = inner loop counter (j)

innerloop: 
    # Calculate upper limit
    addi t2, a1, -1     # t2 = n - 1
    sub t2, t2, t0      # t2 = n - 1 - i
    bge t1, t2, next_i  # if true, move to next outer iteration
    
    # Load current element
    slli t3, t1, 2      # offset calc
    add t4, a0, t3      # address of current element
    lw t5, 0(t4)        # current element t5 = arr[j]
    
    # Load next element
    addi t6, t4, 4      # address of next element
    lw a2, 0(t6)        # next element a2 = arr[j+1]

    # Compare and swap
    ble t5, a2, no_swap # Check condition
    sw a2, 0(t4)        # Swap once
    sw t5, 0(t6)        # Swap again
    
no_swap: 
    addi t1, t1, 1      # increment inner loop counter
    j innerloop         

next_i: 
    addi t0, t0, 1      # increment outer loop counter
    j outerloop         

done: 
