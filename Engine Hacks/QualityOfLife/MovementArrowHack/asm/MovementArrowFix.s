.thumb
.org 0

@if r0=r4, do not update
@but also, if cursor location has a unit on it, do not update
@801d5a8 takes coords in r0 and r1, returns true or false for if you can move there

cmp r0,r4
beq NoUpdate

@check cursor square
ldr r1, CursorLoc
ldrb r0, [r1]
ldrb r1, [r1,#2]
ldr r3, CheckFree
bl goto_r3
cmp r0,#0
beq NoUpdate

Update:
mov r0,#0x14
ldr r3, ReturnTrue
bx r3

NoUpdate:
ldr r3, ReturnFalse
goto_r3:
bx r3

.align
CursorLoc:
.long 0x202bcc4
CheckFree:
.long 0x801d5a9
ReturnFalse:
.long 0x8033061
ReturnTrue:
.long 0x8032f15
