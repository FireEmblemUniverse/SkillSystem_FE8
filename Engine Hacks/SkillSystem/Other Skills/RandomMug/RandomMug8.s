.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4
.thumb
push	{r1}
mov	r5,r1
Condition:
@has skill
mov	r0,r5
ldr	r1,RandomMugID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x01
beq	GetRandom

mov	r0,r5
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0
beq	End1

ldr	r2,IdentityRamByte
ldrb	r2,[r2]
ldr	r3,IdentityProblemsMugs
ldrb	r4,[r3,r2]
b	End2

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800
GetMug:
ldr	r2,MugList
ldrb	r4,[r2,r0]
b	End2

End1:
pop	{r1}
ldr	r0,[r1]
ldrh	r4,[r0,#0x6]
ldr	r0,=#0x87592CC
ldr	r3,=#0x8005544
mov	lr,r3
.short	0xF800
ldr	r0,=#0x1042
ldr	r3,=#0x8073DC7
bx	r3

End2:
pop	{r1}
ldr	r0,[r1]
ldr	r0,=#0x87592CC
ldr	r3,=#0x8005544
mov	lr,r3
.short	0xF800
ldr	r0,=#0x1042
ldr	r3,=#0x8073DC7
bx	r3

.ltorg
.align
MugList:
@POIN MugList
@POIN SkillTester
@WORD RandomMugID
@WORD IdentityProblemsID
@WORD IdentityRamByte
@POIN IdentityProblemsMugs
