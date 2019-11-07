.thumb
.align

.equ WhitePoolID,AuraSkillCheck+4
@atk+5 and hit+5 to adjacent allies

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, WhitePoolID
mov r2, #0 @can_trade
mov r3, #1 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x5A    @Move to the attacker's damage.
ldrh    r3,[r0]     @Load the attacker's damage into r3.
add     r3,#5    	@Add 5 damage.
strh    r3,[r0]     @Store dmg.

add		r0,#4		@Move to the attacker's AS.
ldrh	r3,[r0]		@Load the attacker's AS into r3.
add		r3,#5		@Add 5 AS.
strh	r3,[r0]		@Store AS.


Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD WhitePoolID

