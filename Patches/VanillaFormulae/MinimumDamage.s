.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global MinimumDamage2
	.type   MinimumDamage2, function

MinimumDamage2:
push {r4-r5,lr}
mov r4, r0
mov r5, r1
b Start 

.align 
	.global MinimumDamage
	.type   MinimumDamage, function

MinimumDamage:
push {r4-r5,lr}
mov r4, r0
mov r5, r1
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 

mov r2, #0x4C 
ldr r2, [r4, r2] @ weapon ability word 
mov r3, #0x80 
lsl r3, #0xA @ Luna weapon bit 
and r2, r3 
cmp r2, #0 
bne CheckDfdr @ If the weapon negates defense, we leave it up to MinimumDamage2 function, which is identical except it occurs right after negating defense. 

mov r2, #0x4C 
ldr r2, [r5, r2] @ weapon ability word 
mov r3, #0x80 
lsl r3, #0xA @ Luna weapon bit 
and r2, r3 
cmp r2, #0 
bne GoBack @ If the weapon negates defense, we leave it up to MinimumDamage2 function, which is identical except it occurs right after negating defense. 

mov r3, #0x5C @ Def
ldsh r0, [r5, r3]
cmp r0, #0 
beq CheckDfdr
mov r2, #0x5A @ Att 
ldsh r1, [r4, r2] @ Att
cmp r0, r1 
blt CheckDfdr
add r0, #1
strh r0, [r4, r2] @ Store 


b GoBack 


Start:



mov r3, #0x5C @ Def
ldsh r0, [r5, r3]
cmp r0, #0 
beq CheckDfdr
mov r2, #0x5A @ Att 
ldsh r1, [r4, r2] @ Att
cmp r0, r1 
blt CheckDfdr
add r0, #1
strh r0, [r4, r2] @ Store 


b GoBack 


CheckDfdr:
mov r3, #0x5C @ Def
ldsh r0, [r4, r3]
cmp r0, #0 
beq GoBack 
mov r2, #0x5A @ Att
ldsh r1, [r5, r2] @ Att 
@cmp r1, #0 
@beq GoBack
cmp r0, r1 
blt GoBack 
add r0, #1 
strh r0, [r5, r2] @ Store 
b GoBack 




GoBack:
mov r0, r4
mov r1, r5
pop {r4-r5}
pop {r3}
bx r3

.align
