.thumb
.align 4

push {r4,r14}

@don't run unless this event ID bit is set
ldr r0,=#0x03005274
mov r2,r0
ldrb r0,[r0]
mov r1,#0x4
tst r0,r1
beq GoBack


@the event calls
@mov r0,#0x23
@ldr r3,=#0x8083DA8
@mov r14,r3
@.short 0xF800
@cmp r0,#1
@bne GoBack

@mov r0,#0x23
@ldr r3,=#0x8083D94
@mov r14,r3
@.short 0xF800

@get active unit's action bitfield
ldr r0,=#0x3004E50
ldr r0,[r0]
mov r2,r0
ldrb r0,[r0,#0xC]

@set bit 0x1 (don't show)
@mov r1,#0x1
@orr r0,r1

@set bit 0x2 (unselectable)
mov r1,#0x2
orr r0,r1

@set bit 0x8 (undeployed)
mov r1,#0x8
orr r0,r1

@write edited byte back
strb r0,[r2,#0xC]

GoBack:
pop {r4}
pop {r0}
bx r0


.ltorg
.align 4
ActiveUnit:
.long 

@praise leonarth
