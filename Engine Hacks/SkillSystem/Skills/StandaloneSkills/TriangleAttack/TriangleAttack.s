.thumb
.align

.global TriangleAttackSkill1
.type TriangleAttackSkill1, %function

.global TriangleAttackSkill2
.type TriangleAttackSkill2, %function


TriangleAttackSkill1: @r3 hook at 2B57C
mov r3,r1 @preserving initial function
push {r2,r3}
@r2 contains unit struct
mov r0,r2
ldr r1,=TriangleAttackIDLink
ldrb r1,[r1]
bl SkillTester
cmp r0,#0
beq TriAttack1_RetFalse

ldr r0,=#0x802B593 @continue function
b TriAttack1_GoBack

TriAttack1_RetFalse:
ldr r0,=#0x802B5ED @end function

TriAttack1_GoBack:
pop {r2,r3}
bx r0

.ltorg
.align


TriangleAttackSkill2: @r3 hook at 2B16C
@r2 contains unit struct
mov r0,r2
ldr r1,=TriangleAttackIDLink
ldrb r1,[r1]
bl SkillTester
cmp r0,#0
beq TriAttack2_RetFalse

ldr r0,=#0x802B179 @continue check
b TriAttack2_GoBack

TriAttack2_RetFalse:
ldr r0,=#0x802B19D @exit check

TriAttack2_GoBack:
mov r3,#0 @this is dumb but makes things work
bx r0

.ltorg
.align


