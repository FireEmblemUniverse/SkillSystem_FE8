.thumb 
.equ gActionData, 0x203A958 
.type NewSupplyEffect, %function 
.global NewSupplyEffect 
NewSupplyEffect: 
push {lr} 
ldr r1, =gActionData 
ldrb r0, [r1, #0x11] 

cmp r0, #0x1F
beq StoreNothing
cmp r0, #0x1E 
beq StoreNothing 

@cmp r0, #0 
@beq Skip2 
b Skip 
cmp r0, #0x1C 
beq Skip 
cmp r0, #0x1D 
beq Skip 

ldrb r2, [r1, #0x10] @ squares moved 
cmp r2, #0 
bne Skip 
mov r0, #0x0 
strb r0, [r1, #0x11] 
b StoreNothing 
Skip: 
mov r0, #0x1D 
strb r0, [r1, #0x11] 



StoreNothing: 
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
cmp r0, #0x1F
beq StoreNothing2
cmp r0, #0x1E 
beq StoreNothing2
b StoreNothing2 
@cmp r0, #0x1C 
@beq Store1E
@cmp r0, #0x1D 
@beq Store1E

ldrb r2, [r1, #0x10] @ squares moved 
cmp r2, #0 
bne Store1C 
mov r0, #0 
strb r0, [r1, #0x11] 
pop {r0} 
bx r0 
.ltorg 
@ 1C 
Store1C: @ [203A958+0x11]!!
mov r0, #0x1D  
strb r0, [r1, #0x11] 

StoreNothing2: 

@this makes the unit action end if B is pressed
@ldr	r0,=#0x202BCB0
@add	r0,#0x3D
@mov	r1,#1
@strb	r1,[r0]

pop {r0} 
bx r0 
.ltorg 
