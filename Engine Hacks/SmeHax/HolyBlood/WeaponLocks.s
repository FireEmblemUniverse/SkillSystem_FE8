.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ HolyBloodLocks,BloodGetter+4

push {r4-r7,r14}

mov r4,r0 @r4 = character pointer
mov r5,r1 @r5 = item halfword
mov r6,r2 @r6 = rank

mov r0,#0xFF
and r5,r0

ldr r0,[r4]
ldrb r0,[r0,#4]
blh BloodGetter,r1
cmp r0,#0
beq RetTrue
cmp r1,#0
beq RetFalse
ldrb r0,[r0,#0xC]
mov r3,r0 @r3=holy blood ID

ldr r7,HolyBloodLocks

LoopStart:
ldrb r0,[r7]
cmp r0,#0xFF
beq RetTrue
cmp r0,r5
bne RestartLoop
ldrb r0,[r7,#1]
cmp r0,r3
bne RetFalse
RestartLoop:
add r7,#1
b LoopStart

RetFalse:
mov r0,#0
b GoBack

RetTrue:
mov r0,#1

GoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align
BloodGetter:
@POIN BloodGetter
