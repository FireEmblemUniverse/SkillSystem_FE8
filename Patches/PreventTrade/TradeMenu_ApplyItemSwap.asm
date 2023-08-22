.thumb 
@.org 0x2D72C  
@ inline! do not edit unless you know what you are doing 
push {r4-r6, lr} 
mov r4, r0 
add r0, #0x41 
ldrb r1, [r0] 
lsl r1, #2 
mov r3, r4 
add r3, #0x2c 
add r1, r3 
add r0, #1 
ldrb r2, [r0] 
lsl r2, #1 
add r2, #0x1e 
ldr r5, [r1] @ unitA 
add r2, r5 @ unitA+item offset 
mov r0, r4 
add r0, #0x43 
ldrb r0, [r0] 
lsl r0, #2 
add r3, r0 
mov r0, r4 
add r0, #0x44 
ldrb r0, [r0] 
lsl r0, #1 
add r0, #0x1e 
ldr r6, [r3] 
add r1, r6, r0 
.ltorg 








