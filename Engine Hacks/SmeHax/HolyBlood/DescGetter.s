.thumb
.align 4


.equ HolyBloodCharTable, HolyBloodTable+4


push {r4-r7,r14}

@return current character's holy blood name in r0, or return 0xE0 (which is "--") if no blood
mov r4,r0
ldr r5, =0x2003bfc
ldr r0, [r5, #0xc] @r0 = char struct pointer
ldr r0,[r0]  @r0 = char data pointer
ldrb r0,[r0,#4]@r0= char ID
ldr r1,HolyBloodCharTable
add r1,r0
ldrb r0,[r1] @r0 = holy blood ID
cmp r0,#0xFF
beq BadEnd
ldr r1,HolyBloodTable
mov r2,#20
mul r0,r2
add r1,r0 @r1=table entry start, which is name ID
add r1,#4 @r1=desc ID
ldrh r1,[r1]
b GoBack

BadEnd:
mov r1,#0xE0

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align
HolyBloodTable:
