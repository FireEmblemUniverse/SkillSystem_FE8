.thumb

.equ MemorySlot1, 0x30004BC
.equ MemorySlot2, 0x30004C0
.equ MemorySlotC, 0x30004E8
.equ GetUnitStructFromEventParameter, 0x800BC50 

.macro blh to, reg = r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

// input
// sval 0xC - unit coords
// sval 0x1 - item slot
// sval 0x2 - durability

push {lr}

ldr r0, = MemorySlotC
ldr r0, [r0]
blh GetUnitStructFromEventParameter
ldr r1, = MemorySlot1
ldr r1, [r1]
mov r2, #0x2
mul r1, r2
add r0, r1
add r0, #0x1F // items
ldr r1, = MemorySlot2
ldr r1, [r1]
strb r1, [r0]

pop {r0}
bx r0

.ltorg
.align
