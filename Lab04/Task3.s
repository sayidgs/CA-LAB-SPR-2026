arr: .word 7, 2, 9, 4, 1 

# Initialize registers
la a0, arr          # a0 = base address of array
li a1, 5            # a1 = array size (n = 5)
li t0, 0            # t0 = outer loop counter (i = 0)

# Outer loop: iterate n times
outerloop: 
    bge t0, a1, done    # if i >= n, exit outer loop
    li t1, 0            # t1 = inner loop counter (j = 0)

# Inner loop: compare adjacent elements
innerloop: 
    # Calculate upper limit: n - 1 - i
    addi t2, a1, -1     # t2 = n - 1
    sub t2, t2, t0      # t2 = n - 1 - i (boundary for comparisons)
    bge t1, t2, next_i  # if j >= n-1-i, move to next outer iteration
    
    # Load current element arr[j]
    slli t3, t1, 2      # t3 = j * 4 (byte offset)
    add t4, a0, t3      # t4 = address of arr[j]
    lw t5, 0(t4)        # t5 = arr[j]
    
    # Load next element arr[j+1]
    addi t6, t4, 4      # t6 = address of arr[j+1]
    lw x6, 0(t6)        # x6 = arr[j+1]
    
    # Compare and swap if needed
    bge t5, x6, no_swap  # if arr[j] >= arr[j+1], skip swap
    sw x6, 0(t4)        # arr[j] = arr[j+1]
    sw t5, 0(t6)        # arr[j+1] = arr[j]
    
no_swap: 
    addi t1, t1, 1      # j++
    j innerloop         # continue inner loop

next_i: 
    addi t0, t0, 1      # i++
    j outerloop         # continue outer loop

done: 
    # Exit program
    li a7, 10           # syscall code for exit
    ecall               # invoke syscall 