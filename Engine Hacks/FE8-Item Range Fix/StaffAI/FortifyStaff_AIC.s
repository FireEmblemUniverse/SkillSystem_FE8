.thumb
.include "_ItemAIDefinitions.s"
@AI_TA condition for fortify

@arguments:
	@r0 = stack pocket pointer
	@r1 = active unit pointer
	@r2 = x of tile; r3 = y of tile

.equ FillRange, OffsetList + 0x0
.set RecoveryModeUnitsInRange, 0x0803C3B0
push 	{r4-r7,lr}
mov 	r7, r0
mov 	r6, r1
mov 	r4, r2
mov 	r5, r3
ldr 	r0, =RangeMapRows
ldr 	r0, [r0]
mov 	r1, #0x0
_blh 	FillMap, r3
mov 	r0, r4
mov 	r1, r5
ldr 	r2, [r7, #0x24]
ldr 	r3, FillRange
_blr r3
_blh RecoveryModeUnitsInRange
str 	r0, [r7, #0x28]
mov 	r3, #0x0
cmp 	r0, #0x0
beq End
ldr 	r1, [r7, #0x14]
mov 	r2, #0x1
neg 	r2, r2
cmp 	r1, r2
beq Usable
ldr 	r1, [r7, #0x20]
cmp 	r0, r1
blt End
Usable:
mov 	r0, #0x3
orr 	r3, r0

End:
mov 	r0, r3
pop 	{r4-r7}
pop 	{r1}
bx	r1
.ltorg
.align
OffsetList:
