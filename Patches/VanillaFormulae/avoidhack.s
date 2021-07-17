.thumb

add r0,#0x19
mov r1,#0x0
ldsh r0,[r0,r1]
lsl r0,#0x1
mov r1,r2
add r1,#0x57
ldrb r1,[r1,#0x0]
lsl r1,#0x18
asr r1,#0x18
add r1,r0
mov r0,#0x5e
ldsb r0,[r2,r0]

ldr r3, =0x802ac01
bx r3


