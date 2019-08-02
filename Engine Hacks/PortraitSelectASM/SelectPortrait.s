
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.thumb
.global PortraitSelection
.type PortraitSelection, %function
PortraitSelection: @ r0 = this control code. Modified to fit the MugLoadCalcLoop. - Snek
push { r4, r6, r7, lr }
mov r4, r0
ldr r6, =PortraitSelectionTable
sub r6, r6, #12
BeginLoop:
add r6, r6, #12
ldrh r1, [ r6, #4 ]
cmp r1, #0x00
beq NoneFound
cmp r1, r4
bne BeginLoop

@ If I'm here, then I have the entry in the table I want.
ldr r7, [ r6 ] @ Load the event ID list.
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
beq BeginLoop @ If a 0 is specified, try to find another entry.
b MugFound

TruePortrait:
ldrh r0, [ r6, #6 ]
cmp r0, #0x00
beq BeginLoop @ If a 0 portrait is specified, try to find another entry.

MugFound: @ End:
pop { r4, r6, r7 }
pop { r1 }
bx r1

NoneFound:
mov r0, #0x00 @ Return 0 if no mug was found for this control code.
b MugFound
