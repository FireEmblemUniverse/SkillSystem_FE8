@Blue Flame: Attack +2. If adjacent to an ally, Attack +4.
.equ BlueFlameID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, BlueFlameID
mov r2, #0 @can_trade
mov r3, #1 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x5A    @Move to the attacker's Atk.
ldrh    r3,[r0]     @Load the attacker's Atk into r3.
add     r3,#2    @add 2 to the attacker's Atk.
strh    r3,[r0]     @Store attacker Atk.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD BlueFlameID
