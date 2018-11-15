.thumb
.set Item_MinRange, 0x0801766C
.set Item_MaxRange, 0x08017684
.set HalfMagRange, 0x8018A1C
.set Total, 0xFF 	@value to represent total range
@parameters: 
	@r0= char pointer; 
	@r1= item id
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

ldrh r1, [r6]
cmp r1, #0x0
bne 	SkillCheck
mov 	r1, r6
mov 	r2, r4
mov 	r3, r5
bl AbnormalRanges

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
bx	r3

AbnormalRanges: 	@hold up to 15 abnormal cases for item range
push 	{r4-r6, r14}
mov 	r4, r2
mov 	r5, r3
mov 	r6, r1
cmp 	r0, #0x0
beq 	NullCase
cmp 	r0, #0x1
bne Case2

Case1:	@Mag/2 Range
mov 	r0, r4
ldr 	r3, =#HalfMagRange
mov r14, r3
.short 0xF800
strh 	r0, [r6]
mov 	r0, #0x1
strh	r0, [r6, #0x2]
b Return

Case2:
@add other abnormal range cases here

CaseF:
cmp 	r0, #0xF
bne NullCase
mov 	r0, #Total
str 	r0, [r6]
@b Return

NullCase:
Return:
pop 	{r4-r6}
pop 	{r15}
.ltorg
.align
RangeModSkills: @leave as 0x0 if not using skill system
