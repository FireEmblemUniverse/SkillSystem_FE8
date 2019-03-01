.thumb
.include "_TargetSelectionDefinitions.s"
@.equ 	RangeSetup, PointerList + 0x0
.equ 	TSProc, PointerList + 0x0
@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r2 = item id
	@r3 = pointer list for proc
	
push	{r4,lr}
mov 	r4, r3
mov 	r3, r1
bl	Jump
ldr 	r0, =MoveCostMapRows
ldr 	r0, [r0]
mov 	r1, #0x1
neg 	r1, r1
_blh 	FillMap
mov 	r0, r4
ldr 	r3, TSProc
bl	Jump
pop 	{r4}
pop 	{r3}
Jump:
bx	r3

.ltorg
.align
PointerList:
