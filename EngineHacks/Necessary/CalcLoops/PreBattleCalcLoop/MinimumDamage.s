.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global MinimumDamage
	.type   MinimumDamage, function

MinimumDamage:
push {r4-r7,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 

mov r3, #0x5A @ Atk 
ldrh r0, [r4, r3]
mov r2, #0x5C @ Def/Res  
ldrh r1, [r5, r2] @ Def 
cmp r0, r1 
bgt GoBack 
sub r1, r0 @ Diff 
add r1, #1 @ Minimum damage as 1 
add r0, r1 
strh r0, [r4, r3] @ Store 

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.align
