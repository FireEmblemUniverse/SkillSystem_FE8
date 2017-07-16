@unset flag - in case you cancel out
@hook with BL at 8022862
.thumb
@unset flag
ldr r0, =0x203f101
mov r1, #0
strb r1, [r0]
@as original
ldr r0, =0x2023ca8
mov r1, #0
bx lr

