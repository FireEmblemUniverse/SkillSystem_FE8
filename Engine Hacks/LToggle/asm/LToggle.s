.thumb
.org 0
@goes at dae48 and branch becomes ae f0 a9 f9

ldr r1,=0x858791c
ldr r1, [r1]
ldrh r1,[r1,#4]
mov r2,#0x80
lsl r2,#2
and r1,r2
cmp r1,#0
beq Return
cmp r0,#1
beq Anim
mov r0,#1
b Return
Anim:
mov r0,#3
Return:
pop {r1}
bx r1

@fe7 notes: 202bc3a is option byte
@change the IO pointer to 8b857f8
@802a430 is the function, branch at 802a48a (a6f051fc)
@going to try d0d30 wish me luck
