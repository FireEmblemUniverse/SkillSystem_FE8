.thumb
.global GetItemVar
.type GetItemVar, %function

.equ ItemTable, OffsetList + 0x0

GetItemVar:
mov 	r1, #0xFF
and 	r0, r1
mov 	r1, #0x24
mul 	r1, r0
ldr 	r0, ItemTable
add 	r1, r0
mov 	r0, #0x22
ldrb 	r0, [r1, r0]
bx lr
.align
.ltorg
OffsetList:
