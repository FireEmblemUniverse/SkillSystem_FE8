.thumb 
.global IsUnitOnField 
.type IsUnitOnField, %function 
IsUnitOnField: 
cmp r0, #0 
beq RetFalse 
ldr r1, [r0] 
cmp r1, #0 
beq RetFalse 
ldrb r1, [r1, #4] @ unit id 
cmp r1, #0 
beq RetFalse
ldr r1, [r0, #0x0C] 
ldr r2, =0x1000C @ escaped, undeployed, dead 
tst r1, r2 
bne RetFalse
RetTrue: 
mov r0, #1 
b Exit_IsUnitOnField 
RetFalse: 
mov r0, #0 
Exit_IsUnitOnField: 
bx lr 
.ltorg 
