.thumb

.include "_ItemAIDefinitions.s"
.equ GetRangeType, OffsetList 0x0
.equ DrawRange, OffsetList + 0x4

@parameters
	@r0 = x
	@r1 = y
	@r2 = stack pocket pointer

push {r4-r7,lr}
mov 	r4, r0
mov 	r5, r1
mov 	r6, r2
@get item id
ldr 	r0, =#ActiveUnit
ldr 	r0, [r0]
ldr 	r1, [r6, #0x10]
lsl 	r1, r1, #0x1
ldrh 	r0, [r0, r1]

_blh 	GetRangeType

ldr 	r3, DrawRange
mov 	lr, r3
mov 	r3, r0
ldr 	r2, [r6, #0x24]
mov 	r1, r5
mov 	r0, r4
.short 0xF800

pop 	{r4-r7}
pop 	{r0}
bx r0

.align
.ltorg
