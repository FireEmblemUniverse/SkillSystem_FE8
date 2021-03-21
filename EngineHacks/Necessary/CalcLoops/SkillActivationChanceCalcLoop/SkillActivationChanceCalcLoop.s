.thumb
.align

.global SkillActivationChanceCalcLoopFunc
.type SkillActivationChanceCalcLoopFunc, %function


SkillActivationChanceCalcLoopFunc: @ r0 is chance, r1 is user
push {r4-r6}
mov r4,r0 @r4 = chance
mov r5,r1 @r5 = user

cmp r1,#0
beq GoBack

ldr r6,=SkillActivationChanceCalcLoop
LoopStart:
ldr r0,[r6]
cmp r0,#0
beq GoBack
mov r14,r0
mov r0,r4
mov r1,r5
.short 0xF800
mov r4,r0
add r6,#4
b LoopStart

GoBack:
mov r0,r4
mov r1,#0
lsl r0,r0,#16
lsr r3,r0,#16
lsl r1,r1,#24
lsl r2,r1,#24
ldr r0,=#0x203A4D4
ldrh r1,[r0]

pop {r4-r6}
ldr r0,=#0x802A53B
bx r0

.ltorg
.align

