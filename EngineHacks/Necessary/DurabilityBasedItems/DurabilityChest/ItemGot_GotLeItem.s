.thumb

.equ GetMaxDurabilityFromItemID, 0x8016540
.equ HandleNewItemGetFromDrop, 0x801E098

.macro blh to, reg = r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

push {r4,r5,lr}

mov r4, r0
ldr r5, [r4, #0x54] // unit
ldr r0, [r4, #0x58] // item id

// custom - check for durability
ldr r1, = #0x203FFF7 // end of RAM
mov r2, r1
ldrb r1, [r1]
cmp r1, #0x0
beq GetMaxDurability
lsl r1, #0x8
orr r0, r1
mov r1, #0x0
strb r1, [r2] // zero it back out
b HandleDrop

GetMaxDurability:
ldr r1,DroppedItemDurabilityOption
cmp r1,#1
beq DoNotKeepDurability
lsl r0,r0,#24
lsr r0,r0,#24
DoNotKeepDurability:
blh GetMaxDurabilityFromItemID

HandleDrop:
mov r1, r0
mov r0, r5
mov r2, r4
blh HandleNewItemGetFromDrop

pop {r4, r5}
pop {r0}
bx r0

.ltorg
.align

DroppedItemDurabilityOption:
@WORD DROPPED_ITEM_DURABILITY
