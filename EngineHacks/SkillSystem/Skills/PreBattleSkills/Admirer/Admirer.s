.thumb
.equ AdmirerID, SkillTester+4
.equ AuraSkillCheck, AdmirerID+4
.equ AttractiveID, AuraSkillCheck+4

push {r4-r7, lr}
mov r4, r0 @attacker
mov r5, r1 @defendker

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, AdmirerID
.short 0xf800
cmp r0, #0
beq GoBack

@if we have Admirer, check for people with Attractive
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, AttractiveID
mov r2, #4 @all units
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq GoBack

@+2 Attack and +20 Hit

mov r0,r4
add r0,#0x5A
ldrh r1,[r0]
add r1,#2
strh r1,[r0]

mov r0,r4
add r0,#0x60
ldrh r1,[r0]
add r1,#20
strh r1,[r0]


GoBack:
pop {r4-r7, r15}
.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD AdmirerID
@POIN AuraSkillCheck
@WORD AttractiveID
