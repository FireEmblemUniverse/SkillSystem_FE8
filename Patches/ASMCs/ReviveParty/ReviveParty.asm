.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb
	.equ GetUnit, 0x8019430

.type ReviveParty_ASMC, %function 
.global ReviveParty_ASMC 
ReviveParty_ASMC: 
	push {r4, lr}	

mov r4,#1 @ deployment id
LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
mov r2,#0x4 @ dead
tst r1,r2
bne NextUnit
@ if you got here, unit exists and is not dead, so go ham


mov r2, #0x9 @ undeployed / hide 
bic r1, r2 
str r1, [r0, #0x0C] 
ldrb r1, [r0, #0x12] @ max hp 
strb r1, [r0, #0x13] @ current hp 


NextUnit:
add r4,#1
cmp r4,#0x6
ble LoopThroughUnits
b End 




End: 

pop {r4}
pop {r0}
bx r0

.ltorg











