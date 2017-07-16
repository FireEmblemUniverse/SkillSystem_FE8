@Rally Check
@true if unit has any rally skill AND there is a friendly unit in range

.equ SkillTester, RallySkillList+4
.equ AuraSkillCheck, SkillTester+4
.equ MaxRange, 2
.thumb
.org 0
push {r4-r7,lr}
ldr r0,=0x3004e50
ldr r4,[r0] @save active unit in r4
ldr r1,[r4,#0xc]
mov r0, #0x40 @has not moved...
and r0,r1
cmp r0,#0
bne False

@check if active unit has any rally skills
ldr r5, RallySkillList

LoopStart:
ldrb r1, [r5]
cmp r1, #0 @end of list
beq False
mov r0, r4 @test
ldr r2, SkillTester
mov lr, r2
.short 0xf800 @test if unit has the skill
cmp r0, #0
bne HasRally
add r5, #1
b LoopStart

HasRally:
@now check if there is an ally in range
mov r1, #0 @always true
mov r2, #0 @are on the same side
mov r3, #MaxRange
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @r0 is unit
.short 0xf800
cmp r0, #0
beq False

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
RallySkillList:
@POIN RallySkillList
@POIN SkillTester
@POIN AuraSkillCheck
