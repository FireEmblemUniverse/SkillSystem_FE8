.thumb
.equ CulturedID, SkillTester+4
.equ NiceThighsID, CulturedID+4

push {r4-r7, lr}
mov r4, r0 @attacker
mov r5, r1 @defender

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CulturedID
.short 0xf800
cmp r0, #0
beq GoBack

@Cultured: -50 hit if opponent has Nice Thighs

ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, NiceThighsID
.short 0xf800
cmp r0, #1
bne GoBack

mov r0,r4
add r0,#0x60
ldrh r1,[r0]
sub r1,#50
strh r1,[r0]

GoBack:
pop {r4-r7, r15}

.align
.ltorg

SkillTester:
@Poin SkillTester
@WORD CulturedID
@WORD DebuffTable
@WORD CulturedBit
@WORD 8 //size of debuff table entry
@WORD NiceThighsID
