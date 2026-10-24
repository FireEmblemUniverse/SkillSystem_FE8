.thumb
.align


.global ExpLoopMisc
.type ExpLoopMisc, %function
ExpLoopMisc:

@hook at 802C6CC using r0
@r1 = address to store things to
@let's just push a ton of stuff

push {r1-r7}

@r0 = exp value
mov r4,#10 @base exp value
ldr r5,=#0x203A4EC @attacker
ldr r6,=#0x203A56C @defender

ldr r7,=EXPCalcFunctions
LoopStart1:
ldr r3,[r7]
cmp r3, #0
beq LoopExit1
mov lr,r3

mov r0,r4
mov r1,r5
mov r2,r6
.short 0xF800
mov r4,r0

add r7,#4
b LoopStart1

LoopExit1:
mov r0,r4
cmp r0,#100
ble ApplyExp
mov r0,#100

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

