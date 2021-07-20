.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global Piercing
	.type   Piercing, function

Piercing:
push {r4-r7,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1


mov r0, r4
ldr r1, =PiercingID @ Afaik no need to lsl lsr this because SkillTester just loads the byte 
blh SkillTester 
cmp r0, #0
beq GoBack

mov r1, #0x5C		
ldrh r0, [r5, r1] 	
lsr r0, #1 @ Halve enemy defense/res 
add r0, #1 @ nice rounding 
mov r1, #0x5A 
ldrh r2, [r4, r1]
add r0, r2  
cmp r0, #128
blt DontCap
mov r0, #127 @ Max dmg 

DontCap:
strh r0, [r4, r1]	@ store back in 

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.align


