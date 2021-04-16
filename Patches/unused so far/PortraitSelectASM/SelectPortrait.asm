
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.thumb
.global PortraitSelection
.type PortraitSelection, %function
PortraitSelection:
push { r3, r6, r7 }
ldrb r4, [ r0 ]
ldrb r0, [ r0, #0x1 ]
lsl	r0, #0x8
add	r4, r0
ldr	r0, =#0xFFFF
cmp	r4, r0
beq	CurrentChar

ldr r0, =PortraitSelectionTable
sub r0, r0, #12
mov r6, r0
BeginLoop:
add r6, r6, #12
ldrh r1, [ r6, #4 ]
cmp r1, #0x00
beq End2
cmp r1, r4
bne BeginLoop

@ If I'm here, then I have the entry in the table I want.
ldr r7, [ r6 ] @ Load the event ID list
StartEventIDLoop:
ldrb r0, [ r7 ]
cmp r0, #0x00
beq TruePortrait @ If it's the end of the list, all conditions work.
blh #0x08083DA8, r1 @ Check event ID
ldrb r1, [ r7, #0x01 ]
add r7, r7, #0x02
cmp r0, r1
beq StartEventIDLoop @ If this event ID matches what is specified in the installer, check the next one.
@ If I've fallen through, the conditions don't match.
@ FalsePortrait:
ldrh r0, [ r6, #8 ]
cmp r0, #0x00
beq BeginLoop @ If a 0 is specified, try to find another entry
b End

TruePortrait:
ldrh r0, [ r6, #6 ]
cmp r0, #0x00
beq BeginLoop @ If a 0 portrait is specified, try to find another entry
@ b End

End:
ldr r2, =#0x100
add r4, r0, r2
End2:
pop { r3, r6, r7 }
ldr	r0, =#0x80078C1
bx r0

CurrentChar:
ldr	r0, =#0x3004E50
ldr	r0, [ r0 ]
blh #0x080192B8, r2
pop { r3, r6, r7 }
ldr r2, =#0x080078AF
bx r2
