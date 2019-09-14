.thumb
.align 4


.equ HolyBloodCharTable, HolyBloodTable+4


push {r4-r7,r14}

@return current character's holy blood name in r0, or return 0xE0 (which is "--") if no blood
@r8 = current unit data
mov r0,r8
ldr r0,[r0]
ldrb r0,[r0,#4] @r0= char ID
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
add r1,r0 @r1=table entry start, which is name ID
@add r1,#4 @r1=desc ID
ldrh r0,[r1]
b GoBack

BadEnd:
mov r0,#0xE0

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align
HolyBloodTable:
