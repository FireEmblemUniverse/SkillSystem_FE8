.thumb
.equ StrID, SkillTester+4
@str+2, hook at 80191c0 with jumptohack
mov r1, r0
mov r0, #0x14
ldrsb r0,[r4,r0]
add r2,r0,r1
@check for skill
mov r0, r4
ldr r1, StrID
mov r4, r2 @save str value
ldr r2, SkillTester
mov lr, r2
.short 0xf800
cmp r0, #0
beq Return
sub r4, #2
Return:
mov r0, r4
pop {r4}
pop {r1}
bx r1

.align
SkillTester:
@POIN SkillTester
@WORD strID
