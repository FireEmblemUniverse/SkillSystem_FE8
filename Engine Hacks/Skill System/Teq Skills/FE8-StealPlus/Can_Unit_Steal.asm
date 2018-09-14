.thumb

@r0=char data ptr

.equ StealID, SkillTester+4
.equ StealPlusID, StealID+4

push	{r4-r5,r14}
mov		r4,r0
ldr		r5,SkillTester
ldr		r1,StealID
mov		r14,r5
.short	0xF800
cmp		r0,#0
bne		RetTrue
mov		r0,r4
ldr		r1,StealPlusID
mov		r14,r5
.short	0xF800
cmp		r0,#0
beq		GoBack
RetTrue:
mov		r0,#1
GoBack:
pop		{r4-r5}
pop		{r1}
cmp		r0,#0				@necessary due to laziness and space constraints
bx		r1

.align
SkillTester:
@
