@Infiltrator: If adjacent to 2 or more enemies, gain +3 attack and +15% hit
.thumb
.equ AuraSkillCheck, SkillTester+4
.equ InfiltratorID, AuraSkillCheck+4
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@has Infiltrator
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, InfiltratorID
.short 0xf800
cmp r0, #0
beq Done

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
mov r1, #0x0
mov r2, #3 @Enemy
mov r3, #2 @range
.short 0xf800
cmp r0, #2
blt Done

Next:
mov r0, #0x5A
ldrh r3, [r4,r0]
add r3, #3
strh r3, [r4,r0]

mov r0, #0x60
ldrh r3, [r4,r0]
add r3, #15
strh r3, [r4,r0]


Done:
pop {r4-r7, r15}
bx r0
.align
.ltorg
SkillTester:
@Poin SkillTester
@ POIN AuraSkillCheck
@ WORD InfiltratorID
