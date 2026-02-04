addi x5, x0, 5 
addi x6, x0, 2 
addi x10, x0, 0x100 
addi x7, x0, 0 

Loop1: 
    bge x7, x5, Exit1 
    li x6, 2 
    li x29, 0 
 
Loop2: 
    bge x29, x6, Exit2  
    slli x21, x29, 2 
    add x19, x10, x21
    add x20, x29, x7 
    sw x20, 0(x19) 
    addi x29, x29, 1 
    beq x0, x0, Loop2 

Exit2: 
    addi x7, x7, 1 
    beq x0, x0, Loop1 

Exit1:
    j end 
end: 
    j end

# # Initialization
# li x10, 0x1000      # Base address for D
# li x5, 5            # a = 5
# li x6, 3            # b = 3
# li x7, 0            # i = 0

# outer_loop:
#     # Check if i < a
#     slt t0, x7, x5      # t0 = 1 if (i < a), else 0
#     beq t0, x0, end     # If t0 == 0 (meaning i >= a), exit
    
#     li x29, 0           # j = 0 (Reset j for every new i)

# inner_loop:
#     # Check if j < b
#     slt t1, x29, x6     # t1 = 1 if (j < b), else 0
#     beq t1, x0, next_i  # If t1 == 0 (meaning j >= b), go to increment i
    
#     # Logic: D[4 * j] = i + j
#     add x30, x7, x29    # x30 = i + j
    
#     # Calculate offset: (4 * j) * 4 bytes = 16 * j
#     slli x31, x29, 4    # Corrected: slli (Shift Left by 4 is multiply by 16)
#     add x31, x31, x10   # Base + Offset
#     sw x30, 0(x31)      # Store result in memory
    
#     addi x29, x29, 1    # j++
#     j inner_loop

# next_i:
#     addi x7, x7, 1      # i++
#     j outer_loop

# end: