.thumb
.align 4

.equ ActiveUnit,0x3004E50

push {r4,r14}

@Check for Cantoing
ldr r4,=ActiveUnit
ldr r2,[r4]
ldr r0,[r2,#0x0C]
mov r1,#0x40
and r0,r1
cmp r0,#0
bne ReturnFalse

@Check for being the right person

ldr r1,[r4]
ldr r1,[r1]
ldrb r1,[r1,#4]

ldr r3,CanSeizeList
LoopStart:
ldrb r2,[r3]
cmp r2,#0
beq ReturnFalse
cmp r2,r1
beq IsRightPerson
add r3,#1
b LoopStart

IsRightPerson:


@Check for being on seize point
ldr r1,[r4]
mov r0,#0x10
ldsb r0,[r1,r0]
ldrb r1,[r1,#0x11]
lsl r1,r1,#0x18
asr r1,r1,#0x18
ldr r3,=#0x8084078
mov r14,r3
.short 0xF800
mov r1,#0x03
cmp r0,#0x11
bne ReturnFalse

mov r0,#1
b GoBack
ReturnFalse:
mov r0,#3
GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align

CanSeizeList:
@POIN CanSeizeList
