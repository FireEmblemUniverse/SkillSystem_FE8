.thumb
.align

.global RightfulKing
.type RightfulKing, %function


RightfulKing: @r0 = activation chance, r1 = unit ptr; return updated activation chance
push {r4-r5,r14}
mov r4,r0
mov r5,r1

ldr r0,=SkillTester
mov r14,r0
mov r0,r5
ldr r1,=RightfulKingIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq GoBack

add	r4,#10

GoBack:
mov r0,r4
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align
