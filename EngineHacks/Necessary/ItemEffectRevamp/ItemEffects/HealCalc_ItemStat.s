.thumb
.include "_ItemEffectDefinitions.s"

push {r4-r5, lr}
ldr 	r5, =ActionStruct
ldrb 	r0, [r5, #0xC]
_blh 	RamUnitByID
mov 	r4, r0
ldrb 	r0, [r5, #0x12]
lsl 	r0, r0, #0x1
add 	r0, #0x1E
ldrh 	r0, [r4, r0]
ldr 	r3, Item_StatGetter
_blr 	r3
pop 	{r4-r5}
pop 	{r3}
bx	r3

.ltorg
.align
Item_StatGetter:
