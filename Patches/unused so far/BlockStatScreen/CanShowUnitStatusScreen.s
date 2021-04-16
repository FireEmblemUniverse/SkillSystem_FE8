.thumb

push {lr}

// Vanilla Class Check

ldr r1, [r0, #0x4] // +0x4 - Class Data
ldrb r1, [r1, #0x4] // +0x4 - Class ID
cmp r0, #0x62 // Gorgon Egg
beq DoNotShowStatusScreen
cmp r0, #0x34 // Gorgon Egg
beq DoNotShowStatusScreen

// Check By UnitID
ldr r1, [r0, #0x0] // +0x0 - Character Data
ldrb r1, [r1, #0x4] // +0x4 - Character ID
ldr r0, StatusScreenTable
ldr r0, [r0, r1]
cmp r0, #0x1
beq DoNotShowStatusScreen

// Show Status Screen
mov r0, #0x1
b End

DoNotShowStatusScreen:
mov r0, #0x0

End:
pop {r1}
bx r1

.ltorg
.align

StatusScreenTable:
@POIN StatusScreenTable
