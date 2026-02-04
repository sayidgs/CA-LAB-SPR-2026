strcpy:
    addi x2, x2, -4          # make space on stack (sp = x2)
    sw   x19, 0(x2)          # save x19

    li   x19, 0              # i = 0

loop:
    add  x5, x10, x19        # x5 = x10 + i   (dest addr)
    add  x6, x11, x19        # x6 = x11 + i   (src addr)
    lbu  x7, 0(x6)           # x7 = y[i]
    sb   x7, 0(x5)           # x[i] = x7
    beq  x7, x0, done        # if copied byte == '\0' → exit
    addi x19, x19, 1         # i = i + 1
    jal  x0, loop            # unconditional jump back to loop

done:
    lw   x19, 0(x2)          # restore x19
    addi x2, x2, 4           # restore stack (sp = x2)
    jalr x0, 0(x1)           # return (ra = x1)