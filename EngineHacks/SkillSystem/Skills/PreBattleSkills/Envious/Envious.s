.thumb
.equ EnviousID, SkillTester+4
.equ AttractiveID, EnviousID+4
.equ CharmingID, AttractiveID+4

push {r4-r7, lr}
mov r4, r0 @attacker
mov r5, r1 @defendker

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, EnviousID
.short 0xf800
cmp r0, #0
beq GoBack

@does our opponent have either skill?

ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, AttractiveID
.short 0xf800
cmp r0, #0
bne ActivateSkill

ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, CharmingID
.short 0xf800
cmp r0, #0
beq GoBack

ActivateSkill:

@+15 crit

mov r0,r4
add r0,#0x66
ldrh r1,[r0]
add r1,#15
strh r1,[r0]

GoBack:
pop {r4-r7, r15}
.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD EnviousID
@WORD AttractiveID
@WORD CharmingID
