.thumb
push {lr}
cmp r0, #0 
beq Exit 
ldr r2, =0x8005754 
ldr r2, [r2] @ gpFaceProcs 
add r1, r0 
add r1, #0x40 
ldrb r1, [r1] 
lsl r1, #2 
add r1, r2 
mov r2, #0 
str r2, [r1] 
ldr r3, =0x8002D6C 
mov lr, r3 
.short 0xf800 
Exit: 
pop {r0} 
bx r0 
.ltorg 



