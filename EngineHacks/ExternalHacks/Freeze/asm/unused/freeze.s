.thumb
@replaces 8018d50 (use jumpToHack there)
@0x8 bytes)

mov r0, #0x30
ldrb r0, [r2,r0] @status
mov r1, #0xF
and r0, r1
cmp r0, #0x9
bne NotFrozen
ldr r0, FrozenMovementTable
b MoveFound

NotFrozen:
ldr r0, [r2, #0xC]
mov r1, #0x80
lsl r1, #4 @bit 0x800 'in ballista'
and r0, r1
cmp r0, #0
beq NotBallista
ldr r0, =0x880bc18 @ballista movement

MoveFound:
ldr r1, =0x8018d8a+1 @return with movement found
bx r1
NotBallista:
ldr r1, =0x8018d64+1 @return for normal
bx r1

.ltorg
FrozenMovementTable:
@POIN table of 0xFF 104 times
