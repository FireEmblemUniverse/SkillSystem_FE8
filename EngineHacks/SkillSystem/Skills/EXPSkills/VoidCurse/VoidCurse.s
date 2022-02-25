.thumb
.align

.equ VoidCurseID, SkillTester+4

@ This is called once per battle struct by the EXPCalcLoop.
@ r0 = current EXP, r1 = this battle struct, r2 = enemy battle struct. Return modified EXP.

push {r4,r14}
mov r4, r0
mov r0, r2
ldr r1, VoidCurseID
ldr r2, SkillTester
mov lr, r2
.short  0xF800
cmp r0, #0
beq GoBack

@zero exp if other person has this skill
mov r4,#0

GoBack:
mov r0, r4
pop {r4}
pop {r1}
bx r1

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD VoidCurseID
