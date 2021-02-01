.thumb
.include "../_ItemAIDefinitions.h.s"
@AI_TA condition for fortify

@arguments:
	@r0 = stack pocket pointer
	@r1 = active unit pointer
	@r2 = x of tile; r3 = y of tile

.equ FillRange, OffsetList + 0x0
.set RecoveryModeUnitsInRange, 0x0803C3B0

@minimum amount of targets in range to be usable
.equ MinInRange,2

push 	{r4-r7,lr}
mov 	r7, r0
mov 	r6, r1
mov 	r4, r2
mov 	r5, r3

mov 	r0,r4
mov 	r1,r5
mov 	r2, #spItemRange
add 	r2, r7, r2
_blh ItemAI_RangeBuilder
@ mov 	r3, ItemAI_RangeBuilder
@ _blr r3
_blh RecoveryModeUnitsInRange
str 	r0, [r7, #spNewPriority]
@make sure there are at least MinInRange targets to be usable
cmp 	r0, #MinInRange
ble 	CantHit
@check if more targets can be reached here than before
ldr 	r1, [r7,#spPriority]
cmp 	r0,r1
blt 	CantHit

Usable:
mov 	r0, #0x3
b End

CantHit:
mov 	r0, #0x0
End:
pop 	{r4-r7}
pop 	{r1}
bx 	r1
.ltorg
.align
OffsetList:
