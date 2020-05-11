.thumb
.global ItemRangeGetter
.type ItemRangeGetter, %function
.set Item_MinRange, 0x0801766C
.set Item_MaxRange, 0x08017684
@.set HalfMagRange, 0x8018A1C

.equ SpecialRanges, OffsetList + 0x0
.equ RangeModSkills, OffsetList + 0x4

@arguments: 
	@r0= char pointer; 
	@r1= item id
@retuns
	@r0: min max range word
ItemRangeGetter:
push {r4-r6, r14}
mov 	r4, r0
mov 	r5, r1
add 	sp, #-0x4
mov 	r6, sp
mov 	r0, r5
ldr 	r3, =#Item_MaxRange
mov 	r14, r3
.short 0xF800
strh r0, [r6]

mov 	r0, r5
ldr 	r3, =#Item_MinRange
mov 	r14, r3
.short 0xF800
strh r0, [r6, #0x2]

ldrh 	r0, [r6]
ldrh 	r1, [r6, #0x2]
ldr 	r3, SpecialRanges
mov 	r14, r3
.short 0xF800
cmp 	r0, #0x0
beq SkillCheck
mov 	r3, r0
mov 	r0, r4
mov 	r1, r5
ldr 	r2, [r6]
bl 	Jump_r3	@returns new max range in r0 and new min range in r1
strh 	r0, [r6]
strh 	r1, [r6,#0x2]

SkillCheck:
ldr 	r3, RangeModSkills
cmp 	r3, #0x0
beq NoSkills
mov 	r0, r4
mov 	r1, r5
ldr 	r2, [r6]
mov 	r14, r3
.short 0xF800	@return modified item range in r0
b 	End
NoSkills:
ldr 	r0, [r6]
End:
add 	sp, #0x4
pop 	{r4-r6}
pop 	{r3}
Jump_r3:
bx	r3

.ltorg
.align
OffsetList:
