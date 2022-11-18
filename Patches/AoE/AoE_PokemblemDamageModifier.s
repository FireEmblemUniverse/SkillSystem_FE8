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
@lsr r1, r4, #2 @ 1/4 
bl CheckDifficulty
ldrb r1, [r5, #8] @ lvl 
cmp r1, #50 
ble NoCap 
mov r1, #50 
NoCap:
cmp r0, #0 
beq Easy 
cmp r0, #1 
beq Difficult 
cmp r0, #2 
beq Lunatic 
b Easy 
Difficult: 
mov r0, r4 
mul r0, r1 
mov r1, #100 
swi 6 
lsr r0, #2 @ 87.5% @ 65% compared with normal attacks at worst (vs 75%)
sub r4, r0 
b Easy 
Lunatic: 
mov r0, r4 
mul r0, r1 
mov r1, #100 
swi 6 
mov r1, r0 
lsl r1, #1 
add r0, r1 @ 3x 
lsr r0, #2 @ 1 - (50% * 75%) or 62.5% (47% at worst vs 50%)
sub r4, r0 
b Easy 

Easy:
mov r0, r4 
@sub r0, r1 @ 3/4 
pop {r4-r6}
pop {r1}
bx r1 


.ltorg 
.align 





