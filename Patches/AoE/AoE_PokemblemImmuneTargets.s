
@ unit IDs 0xE0 - 0xEF and 0xD5 and 0xD6 are not damaged by aoe
.thumb 
mov r3, r0 @ target 
ldr r0, [r3] 
ldrb r0, [r0, #4] @ Unit ID 
cmp r0, #0xD5
beq RetTrue 
cmp r0, #0xD6 
beq RetTrue 
cmp r0, #0xE0 
blt RetFalse
cmp r0, #0xF0
bge RetFalse
RetTrue: 
mov r0, #1 
b Exit 
RetFalse:
mov r0, #0 
Exit:

bx lr 
