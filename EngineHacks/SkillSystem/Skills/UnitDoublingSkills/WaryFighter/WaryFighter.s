.thumb
.align

.global WaryFighter
.type WaryFighter, %function

WaryFighter:
push {r4-r5,r14}
mov r4,r0
mov r5,r1

ldr r0,=SkillTester
mov r14,r0
mov r0,r4
ldr r1,=WaryFighterIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq RetFalse

ldr r0,=SkillTester
mov r14,r0
mov r0,r5
ldr r1,=WaryFighterIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#1
beq RetFalse

mov r0,#2
b GoBack

RetFalse:
mov r0,#0

GoBack:
pop {r4-r5}
pop {r1}
bx r1


.ltorg
.align
