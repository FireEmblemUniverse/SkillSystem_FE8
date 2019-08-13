.thumb
.align 4

push {r4,r14}

@Check for flag 0x22 to be set
@ldr r0,TempFlag
@ldrb r0,[r0]
@mov r1,#2
@tst r0,r1
@beq ReturnFalse

@Check for Cantoing
ldr r4,=0x03004E50
ldr r2,[r4]
ldr r0,[r2,#0x0C]
mov r1,#0x40
and r0,r1
cmp r0,#0
bne ReturnFalse

@Check for being lord
ldr r0,[r4]
ldr r0,[r0]
ldr r0,[r0,#40]
lsl r0,r0,#16
lsr r0,r0,#24
mov r1,#0x20
and r0,r1
cmp r0,#0x20
beq ReturnFalse


@Check for being on escape point
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
cmp r0,#0x13
bne ReturnFalse

@Check for rescuing
ldr r0,[r4]
ldrb r0,[r0,#0xC]
mov r1,#0x10
and r0,r1
cmp r0,#0x10
beq ReturnFalse


mov r0,#1
b GoBack
ReturnFalse:
mov r0,#3
GoBack:
pop {r4}
pop {r1}
bx r1

.align 4
.ltorg
TempFlag:
.long 0x03005274

@praise teq
