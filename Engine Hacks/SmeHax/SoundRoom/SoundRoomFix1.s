.thumb

ldr r1,[r5,#0x2C]
ldr r2,[r5,#0x30]
add r2,#8
ldr r3,=#0x8590F44
ldrh r0,[r5,#0x3A]
and r4,r0
lsl r4,r4,#0xC
ldrh r0,[r5,#0x3C]
add r4,r0

mov r0,r5
add r0,#0x68
ldrh r0,[r0]

ldr r7, =#0x80AD3B3
bx r7

.ltorg
.align
