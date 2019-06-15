@Spur Def: adjacent allies gain +4 defense in combat.
.equ GentilhommeID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckGender:
@is the attacker male?
ldr r0, [r4] @char
ldr r0, [r0, #0x28] @char abilities
ldr r1, [r4,#4] @class
ldr r1, [r1,#0x28] @class abilities
orr r0, r1
mov r1, #0x40
lsl r1, #8 @0x4000 IsFemale
tst r0, r1
beq Done @skip if male

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, GentilhommeID
mov r2, #0 @can_trade
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq Done

@ mov r0, r5
@ add     r0,#0x5A    @Move to the defender's damage.
@ ldrh    r3,[r0]     @Load the defender's damage into r3.
@ sub     r3,#2    @Subtract 4 from the defender's damage.
@ strh    r3,[r0]     @Store defender avoid.

@testing
mov r0, r4
add r0, #0x5c @attacker defense
ldrh r3, [r0]
add r3, #2
strh r3, [r0]

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD GentilhommeID
