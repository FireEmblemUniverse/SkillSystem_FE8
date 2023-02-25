@Divinely Inspiring: adjacent allies do +3 damage and take -1 damage in combat.
.equ DivinelyInspiringID, AuraSkillCheck+4
.thumb
push {r4-r7,lr} @battle loop
mov r4, r0 @attacker
mov r5, r1 @defender

CheckSkill:
@skill check and conditional
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, DivinelyInspiringID
mov r2, #0 @units are of same allegiance
mov r3, #1 @max range of receiving bonus
.short 0xf800
cmp r0, #0
beq Done

@testing
mov r0, r4
add r0, #0x5c @attacker defense
ldrh r3, [r0]
add r3, #1 @add 1
strh r3, [r0]

mov r0, r4
add r0, #0x5A @attacker's damage.
ldrh r3, [r0]
add r3, #3    @add 3
strh r3, [r0]

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN NewAuraSkillCheck
@ WORD DivinelyInspiringID
