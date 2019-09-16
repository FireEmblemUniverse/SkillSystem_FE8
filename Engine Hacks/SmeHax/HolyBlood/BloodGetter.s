.thumb
.align 4


.equ HolyBloodCharTable, HolyBloodTable+4

push {r14}

@r0 = char ID, return either 0 or pointer to table data entry in r0 and 1 or 0 for major or not in r1

ldr r1,HolyBloodCharTable
add r1,r0
ldrb r0,[r1] @r0 = holy blood ID
cmp r0,#0xFF
beq BadEnd

mov r1,#0x80
tst r0,r1
beq NoMajorBlood @here we check if it is major blood or not
mov r2,#1
b Continue
NoMajorBlood:
mov r2,#0
Continue:
lsl r0,r0,#25
lsr r0,r0,#25
ldr r1,HolyBloodTable
mov r3,#20
mul r0,r3
add r1,r0 @r1=table entry start
mov r0,r1 @r0 = holy blood table entry
mov r1,r2 @r1 = major/minor boolean
b GoBack

BadEnd:
mov r0,#0
mov r1,#0

GoBack:
pop {r4-r7}
pop {r2}
bx r2



.ltorg
.align
HolyBloodTable:

