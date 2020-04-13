.thumb
.align


.global ParagonMisc
.type ParagonMisc, %function
ParagonMisc:

@hook at 802C6CC using r0
@r1 = address to store things to
@let's just push a ton of stuff

push {r1-r7}

ldr r0,=SkillTester
mov r14,r0
ldr r1,=ParagonIDLink
ldrb r1,[r1]
mov r0,r4
.short 0xF800
cmp r0,#0
beq NormalExp
mov r0,#20
b ApplyExp

NormalExp:
mov r0,#10

ApplyExp:
pop {r1-r7}
strb r0,[r1]

@the rest of the func we hooked into
ldrb r1,[r4,#9]
add r1,r0
strb r1,[r4,#9]
ldr r0,=#0x802BA28
mov r14,r0
mov r0,r4
.short 0xF800
pop {r4}
pop {r0}
bx r0

.ltorg
.align



