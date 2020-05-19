.thumb
.align

@these use dmp/ea literals so they can be used repeatedly

.equ SkillID, SkillTester+4

CombatArtUsability:
@true if unit has skill AND attack is available

push {r4-r7,lr}
ldr r0,=0x3004e50
ldr r4,[r0] @save active unit in r4
ldr r1,[r4,#0xc]
mov r0, #0x40 @has not moved...
and r0,r1
cmp r0,#0
bne False

@check if active unit has skill
mov r0, r4 @test
ldr r1, SkillID
ldr r2, SkillTester
mov lr, r2
.short 0xf800 @test if unit has the skill
cmp r0, #0
bne HasSkill
b False

HasSkill:
@now check if can attack
ldr r0, =0x80249ac @attack usability
mov lr, r0
.short 0xf800
cmp r0, #1
bne False

True:
mov r0,#1
b End

False:
mov r0,#3
End:
pop {r4-r7}
pop {r1}
bx r1

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD GambleID


