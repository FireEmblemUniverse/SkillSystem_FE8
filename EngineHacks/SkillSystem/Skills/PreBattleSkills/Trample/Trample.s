.thumb
.org 0x0
.equ TrampleID, SkillTester+4
push	{r4,r5,r14}
mov		r4,r0
mov		r5,r1
ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		GoBack
mov		r0,r4
ldr		r1,SkillTester
mov		r14,r1
ldr		r1, TrampleID
.short  0xF800
cmp		r0,#0x0
beq		GoBack

ldr		r0,[r5]
ldr		r0,[r0,#0x28]
ldr		r1,[r5,#0x4]
ldr		r1,[r1,#0x28]
orr		r0,r1
mov		r1,#0x1			@is defender mounted
tst		r0,r1
bne		GoBack

add		r4,#0x5A
ldrh	r0,[r4]
add		r0,#5
strh	r0,[r4]

GoBack:
pop		{r4-r5}
pop		{r0}
bx		r0

.align
SkillTester:
@POIN SkillTester
@WORD TrampleID
