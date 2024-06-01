@negative stat bar handler

.thumb
.org 0

@coming from 8086ae2, we need to return to 8086b02
cmp r1, #0
beq End
blt NegBar
@original routine goes here
mov r0,r8
add r0,#2
ldr r3,[sp,#0x28]
add r5,r3,r0
mov r4,r1

Loop1:
mov r0,r7
mov r1,r6
mov r2,r5
ldr r3,GreenPalette
mov lr,r3
.short 0xf800
add r5,#1
sub r4,#1
cmp r4,#0
bne Loop1
b End

NegBar:
neg r1,r1
mov r0,r8
add r0,#2
ldr r3,[sp,#0x28]
add r5,r3,r0
sub r5,r1
mov r4,r1

Loop2:
mov r0,r7
mov r1,r6
mov r2,r5
bl RedPalette
add r5,#1
sub r4,#1
cmp r4,#0
bne Loop2

End:
ldr r0, Return
bx r0

.align
GreenPalette:
.long 0x8086a24
Return:
.long 0x8086b03

RedPalette:
push {r4}
add r3,r1,r2
add r3,r0
mov r4,#8
strb r4,[r3]
lsl r1,#1
add r1,r2
add r0,r1
mov r1,#7
strb r1,[r0]
pop {r4}
bx lr
