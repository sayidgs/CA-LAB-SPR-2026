#No. of terms
li x1, 7
#1st term
li x4, 1
#Comomnt ratio
li x3, 3
#Sum 
li x5, 0

loop:
    # Check if n == 0, then exit loop
    beq x1, x0, end
    
    #Add in sum
    add x5, x5, x4
    # Allocate 4 bytes on stack for storing
    addi sp, sp, -4
    # Push on stack
    sw x4, 0(sp)
    
    #Calc next term
    mul x4, x4, x3
    # Decrement counter
    addi x1, x1, -1
    j loop

end:
    j end
