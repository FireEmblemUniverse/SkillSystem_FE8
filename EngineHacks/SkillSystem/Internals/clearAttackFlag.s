@org 18680 jumptohack
@clear out selected command
.thumb

strb r5, [r0, #0x10]
ldr r0, =0x203f101
strb r5, [r0]
ldr r0, =0x202bcb0
mov r1, r0
add r1, #0x3d
ldr r3, =0x8018689
bx r3
