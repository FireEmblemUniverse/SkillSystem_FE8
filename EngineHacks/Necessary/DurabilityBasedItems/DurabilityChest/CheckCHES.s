.thumb

push {r4,lr}

// input
// r0 - stack pointer to LOCA event

// output
// r0 - bool true if chest at location

mov r2, r0
ldr r3, [r2]
ldrb r1, [r3, #0x8] // x coord
ldrb r4, [r3, #0x9] // y coord
mov r0, #0x18
ldsb r0, [r2, r0] // presumably x coord on the stack
cmp r1, r0
bne NoChest
mov r0, #0x19
ldsb r0, [r2, r0] // presumably y coord on the stack
cmp r4, r0
bne NoChest

// Chest at location

// r2 - stack offset
// r3 - LOCA event offset

mov r0, #0x1
str r0, [r2, #0x4]

ldrh r0, [r3, #0x2]
str r0, [r2, #0x8] // eid

ldrh r0, [r3, #0xA]
str r0, [r2, #0xC] // event type (0x14 = chest)

ldrh r0, [r3, #0x4]

// custom - get the durability of the item
lsr r0, #0x8
ldr r1, = #0x203FFF7 // end of RAM
strb r0, [r1]

// now store the item id
ldrh r0, [r3, #0x4]
//mov r1, #0xFF
//and r0, r1
str r0, [r2, #0x14] // item id (0x77 for gold)

ldrh r0, [r3, #0x6]
str r0, [r2, #0x10] // gold amount

mov r0, #0x1
b End

NoChest:
mov r0, #0x0

End:
pop {r4}
pop {r1}
bx r1

.ltorg
.align
