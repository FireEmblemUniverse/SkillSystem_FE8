.thumb
push    {r4-r7,r14}
mov     r3,r15
mov     r7,r8
push    {r7}
mov     r6,r1
cmp     r0,#0x10
ble     Image1
sub     r3,#0xE
ldr     r3,[r3]
sub     r0,#0x0F
b       Continue
Image1:
sub     r3,#0xA
ldr     r3,[r3]
Continue:
mov     r1,r3//r3 contains pointer to image
mov     r8,r1
sub     r0,#0x1
lsl     r4,r0,#0x1
ldr     r3,=#0x08074C21
bx      r3