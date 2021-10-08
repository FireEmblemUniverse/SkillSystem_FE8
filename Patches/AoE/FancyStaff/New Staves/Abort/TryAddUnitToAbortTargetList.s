.equ gUnitSubject, 0x2033F3C
.equ AreUnitsAllied, 0x8024D8C
.equ AddTarget, 0x804F8BC

.macro blh to, reg=r3
ldr \reg, =\to
mov lr, \reg
.short 0xF800
.endm

.thumb

push {r4,lr}

mov r4, r0
ldr r0, =gUnitSubject
ldr r0, [r0]
ldrb r0, [r0, #0xB]
lsl r0, #0x18
asr r0, #0x18
mov r1, #0xB
ldsb r1, [r4,r1]
blh AreUnitsAllied
lsl r0, #0x18
cmp r0, #0x0
bne End

mov r0, #0x10
ldsb r0, [r4, r0]
mov r1, #0x11
ldsb r1, [r4, r1]
mov r2, #0xB
ldsb r2, [r4, r2]
mov r3, #0x0
blh AddTarget

End:
pop {r4}
pop {r0}
bx r0
