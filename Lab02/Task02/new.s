
li x20, 3
li x22, 1
li x23, 3

li x2,1
li x3,2
li x4,3
li x5,4

beq, x20, x2, CASE1
beq, x20, x3, CASE2
beq, x20, x4, CASE3
beq, x20, x5, CASE4
j default


CASE1:
add x21, x22, x23
j End
CASE2:
sub x21, x23, x22
j End
CASE3:
slli x21, x22, 1
j End
CASE4:
srli x21, x22, 1
default:
li x21, 0
j End

End:
li x10, 5


# li x20, 0 # i=0
# li x21, 10 # b=10
# LOOP:
# beq x20, x21, EXIT # if i == b
#     # a[i] = i
# add x20, 1 # i+=1
# j LOOP

# EXIT:
