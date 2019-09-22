.thumb
.align
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

@hook at 0x72794
@r0 = char ID

ldr r3,ChangingBGMList
LoopStart:
ldrb r1,[r3]
cmp r1,#0xFF
beq LoopUnsuccessful
cmp r0,r1
beq LoopSuccessful
add r3,#2
b LoopStart

LoopUnsuccessful:
ldr r1,=#0x80727B5
bx r1

LoopSuccessful:
push {r3}
blh #0x8084635,r0 @returns 1 or 0 based on the status of eid 0x82
lsl r0,r0,#18
asr r0,r0,#18
cmp r0,#1
bne SetEventID
mov r1,#0x80
lsl r1,r1,#1
pop {r0}
ldrb r0,[r0,#1]
blh #0x8071A55,r2 @plays the song and then returns here
pop {r4-r7}
pop {r0}
bx r0


SetEventID:
pop {r0}
blh #0x8084629,r0
b LoopUnsuccessful



.ltorg
.align

ChangingBGMList:
@POIN ChangingBGMList
