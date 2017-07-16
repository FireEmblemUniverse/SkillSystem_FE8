.thumb
@r4 = the unit struct

ldr r2, AdditionalDataTable
ldrb r3, [r4, #0xB]         @Deployment number
lsl r3, #0x3                @*8
add r2, r3
mov r3, #0x00
str r3, [r2]                @Clear out the first eight bytes
str r3, [r2, #0x4]


lsr     r1,r1,#0x4
ldrb    r0,[r0,#0x8]
mov     r5,#0x1
and     r0,r5
lsl     r0,r0,#0x4
orr     r0,r1
bx lr

AdditionalDataTable:
    @Handled in installer
