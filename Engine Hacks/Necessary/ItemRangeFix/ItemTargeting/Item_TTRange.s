.thumb
.global Item_TTRange
.type Item_TTRange, %function
.global Item_TTRangeBuilder
.type Item_TTRangeBuilder, %function

.include "_TargetSelectionDefinitions.s"

	@.equ RangeBuilder, OffsetList + 0x0
@parameters: 
	@r0 = char pointer 
	@r1 = targeting condition routine pointer
	@r2 = item id

Item_TTRange:
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
@ldr 	r3, RangeBuilder
@_blr	r3
bl 	Item_TTRangeBuilder
pop 	{r4-r5}
pop 	{r3}
bx	r3

.ltorg
.align

@.equ GetItemRange, OffsetList + 0x0
@.equ ConditionCheck, OffsetList + 0x4
.equ DrawRange, OffsetList + 0x0
.equ Is_Capture_Set, OffsetList + 0x4

@parameters: 
	@SelectedUnit = char pointer 
	@r0 = targeting condition routine pointer
	@r1 = item id
Item_TTRangeBuilder:
push 	{r4-r7, r14}
mov 	r7, r0
mov 	r6, r1
ldr 	r5, =SelectedUnit
ldr 	r5, [r5]
mov 	r0, r5

ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
_blh RefreshTargetList

@i probably don't need to check for caputre here but i'll do it just in case
ldr r0, Is_Capture_Set
cmp r0, #0x0
beq NotCapture
mov lr, r0
mov r0, r5
.short 0xf800
cmp r0, #0
beq NotCapture
	ldr r4, =0x00010001 @capture is always 1 range
	b GotRange

NotCapture:
mov 	r0, r5
mov 	r1, r6
@ldr 	r3, GetItemRange
@bl	Jump
bl 	ItemRangeGetter
mov 	r4, r0

GotRange:
ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
mov 	r2, r4
ldr 	r3, DrawRange
bl	Jump

mov 	r0, r7
cmp 	r0, #0x0	@skip check if no targeting condition
beq End
@ldr 	r3, ConditionCheck
ldr 	r3, =CheckTilesInRange+1
bl	Jump
End:
pop 	{r4-r7}
pop 	{r3}
Jump:
bx	r3

.ltorg
.align
OffsetList:
