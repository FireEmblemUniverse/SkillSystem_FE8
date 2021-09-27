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
push {r4-r5,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1


mov r3, #0x5A @ Atk 
ldrh r0, [r5, r3]
cmp r0, #0 
beq CheckAttacker 
mov r2, #0x5C @ Def/Res  
ldrh r1, [r4, r2] @ Def 
cmp r1, #0 
beq CheckAttacker 
cmp r0, r1 
bgt CheckAttacker 
sub r0, #1 
strh r0, [r4, r2] @ Store 
b GoBack 


CheckAttacker:
mov r3, #0x5A @ Atk 
ldrh r0, [r4, r3]
cmp r0, #0 
beq GoBack 
mov r2, #0x5C @ Def/Res  
ldrh r1, [r5, r2] @ Def 
cmp r1, #0 
beq GoBack
cmp r0, r1 
bgt GoBack 
sub r0, #1 
strh r0, [r5, r2] @ Store 
b GoBack 




GoBack:
mov r0, r4
mov r1, r5
pop {r4-r5}
pop {r3}
bx r3

.align
