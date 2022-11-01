
@ unit IDs 0xD1 - 0xEF are not damaged by aoe
.thumb 
mov r3, r0 @ target 
ldr r0, [r3] 
ldrb r0, [r0, #4] @ Unit ID 
cmp r0, #0xD1
blt RetFalse
cmp r0, #0xF0
bge RetFalse
mov r0, #1 
b Exit 
RetFalse:
mov r0, #0 
Exit:

bx lr 
