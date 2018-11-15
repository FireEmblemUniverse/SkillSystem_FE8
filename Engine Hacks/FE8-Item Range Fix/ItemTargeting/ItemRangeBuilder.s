.thumb
.include "_TargetSelectionDefinitions.s"
@parameters: 
	@SelectedUnit = char pointer 
	@r0 = targeting condition routine pointer
	@r1 = item id
	
.equ GetItemRange, OffsetList + 0x0
.equ ConditionCheck, OffsetList + 0x4
.equ DrawRange, OffsetList + 0x8

push 	{r4-r7, r14}
mov 	r7, r0
mov 	r6, r1
ldr 	r5, =SelectedUnit
ldr 	r5, [r5]
mov 	r0, r5

ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
_blh RefreshTargetList

mov 	r0, r5
mov 	r1, r6
ldr 	r3, GetItemRange
bl	Jump
mov 	r4, r0

ldrb	r0, [r5, #0x10]
ldrb	r1, [r5, #0x11]
mov 	r2, r4
ldr 	r3, DrawRange
bl	Jump

mov 	r0, r7
cmp 	r0, #0x0	@skip check if no targeting condition
beq End
ldr 	r3, ConditionCheck
bl	Jump
End:
pop 	{r4-r7}
pop 	{r3}
Jump:
bx	r3

.ltorg
.align
OffsetList:
