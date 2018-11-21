.thumb
.org 0x0
.equ OpportunistID, SkillTester+4
push	{r4,r5,r14}
mov		r4,r0
mov		r5,r1

ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		GoBack
mov		r0,#0x52
ldrb	r0,[r5,r0]		@can unit counter
cmp		r0,#0
bne		GoBack

mov		r0,r4
ldr		r1,SkillTester
mov		r14,r1
ldr		r1, OpportunistID
.short  0xF800
cmp		r0,#0x0
beq		GoBack

add		r4,#0x5A
ldrh	r0,[r4]
add		r0,#4
strh	r0,[r4]

GoBack:
pop		{r4-r5}
pop		{r0}
bx		r0

.align
SkillTester:
@POIN SkillTester
@WORD OpportunistID
