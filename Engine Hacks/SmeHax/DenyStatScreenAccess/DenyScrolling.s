.thumb
.align

.equ AllowScrolling,0x80879d1
.equ DenyScrolling,0x8087931


@r2 = class data


ldrb r0,[r2,#4]

@now we do our loop
ldr r2,DenyStatScreenList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq False
cmp r0,r1
beq True
add r2,#1
b LoopStart

True:
ldr r1,=DenyScrolling
b GoBack

False:
ldr r1,=AllowScrolling
mov r0,r3

GoBack:
bx r1

.ltorg
.align
DenyStatScreenList:
@POIN DenyStatScreenList





