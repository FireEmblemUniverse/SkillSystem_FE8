.thumb

@arguments:
	@r0: unit pointer
	@r1: item id
	@r2: min max range word
@retuns
	@r0: updated min max range word

.equ SkillTester, OffsetList + 0x0
.equ RangeSkillsList, OffsetList + 0x4

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

	push {r4-r7, lr}
	mov 	r4, r0
	mov 	r5, r1
	mov 	r6, r2
	ldr 	r7, RangeSkillsList
	Loop:
	ldr 	r1, [r7]
	cmp 	r1, #0x0
	beq SkipSkillCheck
	mov 	r0, r4
	ldr 	r3, SkillTester
	_blr r3
	cmp 	r0, #0x0
	beq Reloop
SkipSkillCheck:
	ldr 	r3, [r7, #0x4]	@grab pointer to routine
	cmp 	r3, #0x0
	beq 	End	@end loop is routine pointer is null
	mov 	r0, r4
	mov 	r1, r5
	mov 	r2, r6
	bl Jump_r3
	mov 	r6 ,r0	@replace with updated range
	
	Reloop:
	add 	r7, #0x8
	b Loop
End:
	mov 	r0, r6
	pop 	{r4-r7}
	pop 	{r3}
Jump_r3:
	bx 	r3
.ltorg
.align
OffsetList:
@SkillTester
@RangeSkillsList
