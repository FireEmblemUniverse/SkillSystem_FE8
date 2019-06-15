.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4
.thumb
push	{r0}

Condition:
@has skill
mov	r0,r6
ldr	r1,RandomMugID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x01
beq	GetRandom

mov	r0,r6
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0
beq	End1

ldr	r2,IdentityRamByte
ldrb	r2,[r2]
ldr	r3,IdentityProblemsMugs
ldrb	r0,[r3,r2]
pop	{r1}
b	End2

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800
GetMug:
ldr	r2,MugList
ldrb	r0,[r2,r0]
pop	{r1}
b	End2

End1:
pop	{r0}

End2:
ldr	r3,=#0xFFFFFEC0
add	r1,r7,r3
mov	r2,#0x9C
lsl	r2,r2,#0x2
ldr	r3,=#0x8099539
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
