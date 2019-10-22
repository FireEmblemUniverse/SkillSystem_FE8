.thumb
.align

@801C928 - check if you are a gorgon egg function for seeing stat screen
@returns true/false for if you are allowed to see the stat screen or not
@r0 = char struct

push {r14}
ldr r0,[r0,#4]
ldrb r0,[r0,#4]

@now we do our loop
ldr r2,DenyStatScreenList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq True
cmp r0,r1
beq False
add r2,#1
b LoopStart

True:
mov r0,#1
b GoBack

False:
mov r0,#0

GoBack:
pop {r1}
bx r1

.ltorg
.align
DenyStatScreenList:
@POIN DenyStatScreenList





