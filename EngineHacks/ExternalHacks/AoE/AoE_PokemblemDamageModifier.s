.thumb 

	.equ Check_Effectiveness, 	0x08016BEC

push {r4-r6, lr}
mov r4, r0 @ damage to deal 
mov r5, r1 @ target  
mov r6, r2 @ AoE entry weapon 
cmp r2, #0 
beq Neutral @ if no weapon, then neutral 
mov r1, #0xA @ pretend durability 
lsl r1, #8 

mov r0, r6 
orr r0, r1 @ weapon
mov r1, r5 @ target 
ldr		r2,=Check_Effectiveness
mov		r14,r2
.short	0xF800
@ super effective 
cmp r0, #4 
beq Effective 
cmp r0, #7 
beq Ineffective
cmp r0, #9
beq Neutral
cmp r0, #7
beq Ineffective
cmp r0, #2
beq Ineffective
cmp r0, #1
beq Immune
b Neutral


Effective:
lsl r4, #1 
b Neutral

Ineffective:
lsr r4, #1 
b Neutral

Immune: 
mov r4, #0 
b Neutral


Neutral:
@ modify to be 3/4 of damage 
lsr r1, r4, #2 @ 1/4 
mov r0, r4 
sub r0, r1 @ 3/4 
pop {r4-r6}
pop {r1}
bx r1 


.ltorg 
.align 





