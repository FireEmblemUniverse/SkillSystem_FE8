.thumb 

ldrb r2, [r4, #0x0B] 
lsr r2, #6 
mov r3, #0x28 @ boon  
cmp r2, #0 
beq Skip 
mov r3, #0x18 @ enemies for only 1 turn 
Skip: 
mov r2, #0x30
add r2, r4
strb r3, [r2] 

mov r3, #0x80 
lsl r3, #0x11 
ldr r2, [r4, #0xC] 
orr r3, r2 
ldr r2, =0x8b3004D
bx r2 
.ltorg 


