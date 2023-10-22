.thumb 
.equ gActionData, 0x203A958 
.type NewSupplyEffect, %function 
.global NewSupplyEffect 
NewSupplyEffect: 
push {lr} 
ldr r1, =gActionData 
ldrb r0, [r1, #0x11] 
cmp r0, #0 
beq Skip2 
b Skip 
cmp r0, #0x1C 
beq Skip 
cmp r0, #0x1D 
beq Skip 
cmp r0, #0x1F
beq Skip
cmp r0, #0x1E 
beq Skip 
mov r0, #0x0 
strb r0, [r1, #0x11] 
b Skip2 
Skip: 
mov r0, #0x1E 
strb r0, [r1, #0x11] 
Skip2: 
ldr r0, =0x3004E50 @ gCurrentUnit 
ldr r0, [r0] 
mov r1, #0 
ldr r3, =0x809EB38 
mov lr, r3 
.short 0xf800 
mov r0, #0x17 
pop {r1} 
bx r1 
.ltorg 

.global WithdrawItemSupplyAction
.type WithdrawItemSupplyAction, %function 
WithdrawItemSupplyAction: 
push {lr} 
mov r0, #5 
ldr r3, =0x8001FAC 
mov lr, r3 
.short 0xf800 
b FinishUp 

.global DepositItemSupplyAction
.type DepositItemSupplyAction, %function 
DepositItemSupplyAction: 
push {lr} 
ldr r0, [r5, #0x2C] 
ldr r3, =0x80179D8 
mov lr, r3 
.short 0xf800 
mov r4, r0 

FinishUp: 
ldr r1, =gActionData 
ldrb r0, [r1, #0x11] 
cmp r0, #0x1C 
beq Store1E
cmp r0, #0x1D 
beq Store1E
cmp r0, #0x1F
beq Store1E
cmp r0, #0x1E 
beq Store1E
mov r0, #0 
strb r0, [r1, #0x11] 
pop {r0} 
bx r0 
.ltorg 
@ 1E because it won't try and open the UM afterwards when on ice ? 
Store1E: @ [203A958+0x11]!!
mov r0, #0x1E  
strb r0, [r1, #0x11] 
pop {r0} 
bx r0 
.ltorg 
