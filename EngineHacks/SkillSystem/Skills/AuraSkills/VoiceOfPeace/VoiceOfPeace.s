@Spur Def: adjacent allies gain +4 defense in combat.
.equ VoiceOfPeaceID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the attacker
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, VoiceOfPeaceID
mov r2, #3 @are_enemies
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x5A    @Move to the attacker's damage.
ldrh    r3,[r0]     @Load the attacker's damage into r3.
sub     r3,#2    @Subtract 2 from the attacker's damage.
strh    r3,[r0]     @Store attacker dmg.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD VoiceOfPeaceID
