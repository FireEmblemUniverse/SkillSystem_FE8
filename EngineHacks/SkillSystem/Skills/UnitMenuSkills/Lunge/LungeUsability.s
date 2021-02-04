@Lunge Check
@true if unit has Lunge skill AND attack is available
@NOTE does not check terrain! 

.equ LungeID, SkillTester+4
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

@check if active unit has Lunge
mov r0, r4 @test
ldr r1, LungeID
ldr r2, SkillTester
mov lr, r2
.short 0xf800 @test if unit has the skill
cmp r0, #0
bne HasLunge
b False

HasLunge:
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
@WORD LungeID
