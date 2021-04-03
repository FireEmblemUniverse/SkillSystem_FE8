.thumb
.global Item_TURange
.type Item_TURange, %function
.global Item_TURangeBuilder
.type Item_TURangeBuilder, %function

.include "_TargetSelectionDefinitions.s"

	@.equ RangeBuilder, OffsetList + 0x0
@parameters: 
	@r0 = char pointer 
	@r1 = targeting condition routine pointer
	@r2 = item id

Item_TURange:
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
bl 	Item_TURangeBuilder
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
Item_TURangeBuilder:
push 	{r4-r7, r14}
mov 	r7, r0
mov 	r6, r1
ldr 	r5, =SelectedUnit
ldr 	r5, [r5]
mov 	r0, r5

ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
_blh RefreshTargetList

@check for capture
ldr r0, Is_Capture_Set
cmp r0, #0x0
beq NotCapture
mov lr, r0
mov r0, r5
.short 0xf800
cmp r0, #0
beq NotCapture
	ldr r4, =0x00010001 @capture is always 1 range
	b GotRangeC

NotCapture:
mov 	r0, r5
mov 	r1, r6
@ldr 	r3, GetItemRange
@bl	Jump
bl 	ItemRangeGetter
mov 	r4, r0
b GotRange

GotRangeC:
ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
mov 	r2, r4
ldr 	r3, DrawRange
bl	Jump
ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
mov 	r2, r4
ldr 	r3, DrawRange
bl	Jump
b End

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
ldr 	r3, =CheckUnitsInRange+1
bl	Jump
End:
pop 	{r4-r7}
pop 	{r3}
Jump:
bx	r3

.ltorg
.align
OffsetList:
