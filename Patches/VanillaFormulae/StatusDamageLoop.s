.thumb 

.type StatusDamageLoop, %function 
.global StatusDamageLoop
StatusDamageLoop: 
push {lr} 

mov r0, r2 @ unit struct 
add r0, #0x30 
ldrb r3, [r0] 

ldr r1, =PoisonStatusID_Link
ldrb r0, [r1] 

ldr r1, =TrappedStatusID_Link 
ldrb r1, [r1] 
orr r0, r1 
ldr r1, =BurnStatusID_Link
ldrb r1, [r1] 
orr r0, r1 

tst r0, r3
beq ReturnFalse
mov r0, #1 
b Exit 

ReturnFalse:
mov r0, #0 
Exit:
cmp r0, #0 



pop {r3}
bx r3 
.ltorg 
