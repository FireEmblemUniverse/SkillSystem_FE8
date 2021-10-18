.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global ScaledBackFunc
	.type   ScaledBackFunc, function

ScaledBackFunc:
push {r4-r5,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1


ldr r0,[r4,#4]
ldrb r0, [r0, #4] @ class id 
ldr r1, =MagikarpID
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
bne SkipAtkr
mov r1, #0x5a 
ldrh r0, [r4, r1] 
lsr r0, #1 @ half dmg 
strh r0, [r4, r1] 
SkipAtkr: 
ldr r0,[r5,#4]
ldrb r0, [r0, #4] @ class id 
ldr r1, =MagikarpID
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
bne SkipDfdr
mov r1, #0x5a 
ldrh r0, [r5, r1] 
lsr r0, #1 @ half dmg 
strh r0, [r5, r1] 
SkipDfdr: 

pop {r4-r5} 
pop {r0} 
bx r0 

.align 




