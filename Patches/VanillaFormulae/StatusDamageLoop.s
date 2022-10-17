.thumb 

.type StatusDamageLoop, %function 
.global StatusDamageLoop
StatusDamageLoop: 
push {lr} 

mov r0, r2 @ unit struct 
add r0, #0x30 
ldrb r3, [r0] 
mov r1, #0xF 
and r3, r1 

ldr r1, =PoisonStatusID_Link
ldrb r0, [r1] 
cmp r0, r3 
beq ReturnTrue

ldr r1, =TrappedStatusID_Link 
ldrb r0, [r1] 
cmp r0, r3 
beq ReturnTrue 

ldr r1, =BurnStatusID_Link
ldrb r0, [r1] 
cmp r0, r3 
beq ReturnTrue 
b ReturnFalse 
ReturnTrue: 
mov r0, #1 
b Exit 

ReturnFalse:
mov r0, #0 
Exit:
cmp r0, #0 



pop {r3}
bx r3 
.ltorg 
