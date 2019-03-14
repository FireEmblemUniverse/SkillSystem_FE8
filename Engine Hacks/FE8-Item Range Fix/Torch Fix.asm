.thumb
.include "ItemTargeting/_TargetSelectionDefinitions.s"

@arguments
	@r0 = unit pointer
	@r1 = item id
.equ RangeWrite,             OffsetList + 0x0
.equ Torch_TCondition,       OffsetList + 0x4

push {r4-r5,lr}
mov 	r4, r0
mov 	r5, r1
ldr 	r1,=ChapterDataStruct
ldrb 	r2,[r1,#0x0D]	@vision byte. If non-zero, fog is present.
mov		r0,#0x0
cmp		r2,#0x0
beq		GoBack
mov		r0,r4
ldr 	r1,Torch_TCondition
mov		r2,r5
ldr		r3,RangeWrite
bl		goto_r3
mov		r0,#0x1

GoBack:
@ldr		r1,GoBackPtr
pop 	{r4-r5}
pop 	{r1}
bx		r1

goto_r3:
bx		r3
.ltorg
.align
@Fog:
@.long 0x0202BCF0
@GoBackPtr:
@.long 0x08028C06+1
OffsetList:
@RangeWrite
@Torch_TCondition
