.equ StatusStaffList, HealingStaffList+4

.thumb

// input
// r0 - item and uses

push {lr}

mov r1, #0xFF
and r0, r1 // get low byte

ldr r1, HealingStaffList
HealingStaffLoop:
ldrb r2, [r1]
add r1, #0x1
cmp r2, r0
beq HealingStaff
cmp r2, #0xFF
bne HealingStaffLoop

ldr r1, StatusStaffList
StatusStaffLoop:
ldrb r2, [r1]
add r1, #0x1
cmp r2, r0
beq StatusStaff
cmp r2, #0xFF
bne StatusStaffLoop

// Not in either list
mov r0, #0x0
b End

HealingStaff:
mov r0, #0x2
b End

StatusStaff:
mov r0, #0x1

End:
pop {r1}
bx r1

.ltorg
.align

HealingStaffList:
@POIN HealingStaffList
@POIN StatusStaffList
