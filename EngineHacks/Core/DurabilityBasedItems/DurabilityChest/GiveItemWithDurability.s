.thumb

.equ MemorySlotC, 0x30004E8

// input
// sval 0xC - durability

push {lr}

ldr r0, = MemorySlotC
ldr r0, [r0]
ldr r1, = #0x203FFF7 // end of RAM
strb r0, [r1]

pop {r0}
bx r0

.ltorg
.align
