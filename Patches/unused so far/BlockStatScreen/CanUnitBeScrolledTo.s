.thumb

ldr r1, [r3, #0x0] // +0x0 - Character Data
ldrb r1, [r1, #0x4] // +0x4 - Character ID
ldr r0, StatusScreenTable
ldr r0, [r0, r1]
cmp r0, #0x1
beq DoNotShowStatusScreen

mov r0, r3
pop {r4-r7}
pop {r1}
bx r1

DoNotShowStatusScreen:
ldr r1, =#0x8087931
bx r1

.ltorg
.align

StatusScreenTable:
@POIN StatusScreenTable
