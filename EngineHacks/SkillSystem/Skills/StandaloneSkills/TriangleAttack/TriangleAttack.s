.thumb
.equ TriangleAttackID, SkillTester+4
.equ TrueReturnPoint, 0x802B593
.equ FalseReturnPoint, 0x802B5ED

@push {r4-r7, lr}
@mov r4, r0 @attacker
@mov r5, r1 @defender

push {r2-r3}

ldr r0, SkillTester
mov lr, r0
mov r0, r2 @attacker
ldr r1, TriangleAttackID
.short 0xf800
cmp r0, #0
beq RetFalse

RetTrue:
ldr r0,=TrueReturnPoint
b GoBack

RetFalse:
ldr r0,=FalseReturnPoint

GoBack:
pop {r2-r3}
bx r0

.ltorg
.align

SkillTester:
@Poin SkillTester
@WORD TriangleAttackID
