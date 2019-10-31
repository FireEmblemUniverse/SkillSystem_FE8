.thumb
.align


.equ TrueReturn,0x802AB67
.equ FalseReturn,0x802AB6B

@no need to push since this doesn't need to return to where it came from
@r6 = attacker/defender struct we're working with
mov r0,r6
add r0,#0x48
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1

ldr r2,NoCounteringList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq False
cmp r0,r1
beq True
add r2,#1
b LoopStart

True:
ldr r0, =TrueReturn
b GoBack

False:
ldr r0, =FalseReturn

GoBack:
bx r0

.ltorg
.align
NoCounteringList:
@POIN NoCounteringList
