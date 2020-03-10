.thumb
.include "_TargetSelectionDefinitions.s"
@parameters: 
	@r0 = char pointer 
	@r1 = targeting condition routine pointer
	@r2 = item id

	.equ RangeBuilder, OffsetList + 0x0
push 	{r4-r5, r14}
@mov 	r4, r0
mov 	r4, r1
mov 	r5, r2
ldr 	r2, =#SelectedUnit
str 	r0, [r2]
ldr 	r0, =RangeMapRows
ldr 	r0, [r0]
mov 	r1, #0x0
ldr 	r3, =FillMap	@clear out range map
mov 	r14, r3
.short 0xf800
mov 	r0, r4
mov 	r1, r5
@mov 	r2, r6
ldr 	r3, RangeBuilder
_blr	r3
pop 	{r4-r5}
pop 	{r3}
bx	r3

.align
.ltorg
OffsetList:
