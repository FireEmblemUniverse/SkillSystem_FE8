.thumb
.align

@replacements for WriteSupplyItems and ReadSupplyItems
@that save the entire item word rather than bitpacking it

.global MSa_WriteSupplyItems
.type MSa_WriteSupplyItems, %function

.global MSa_ReadSupplyItems
.type MSa_ReadSupplyItems, %function

.equ WriteAndVerifySramFast, 0x080D184C+1
.equ ReadSramFastAddr, 0x030067A0   @ pointer to the actual ReadSramFast function
.equ gConvoyItemArray, 0x0203A81C
.equ GetConvoyItemArray, 0x08031500+1


MSa_WriteSupplyItems:
push {r4-r5, r14}
mov r4,r0 @ target address
mov r5,r1 @ size

ldr r0, =GetConvoyItemArray
mov r14,r0
.short 0xF800
@r0 = convoy array ptr

ldr r3, =WriteAndVerifySramFast

mov r2, r5   @ WriteAndVerifySramFast arg r2 = size
mov r0, r4   @ WriteAndVerifySramFast arg r1 = target address

mov r14,r3
.short 0xF800 

pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align


MSa_ReadSupplyItems:
push {r4-r5, r14}
mov r4,r0 @ target address
mov r5,r1 @ size

ldr r0, =GetConvoyItemArray
mov r14,r0
.short 0xF800
@r0 = convoy array ptr
mov r1, r0 @ ReadSramFast arg r1 = target address

ldr r3, =ReadSramFastAddr
ldr r3, [r3] @ r3 = ReadSramFast

mov r2, r5   @ ReadSramFast arg r2 = size
mov r0, r4   @ ReadSramFast arg r0 = source address

mov r14,r3
.short 0xF800 

pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align

