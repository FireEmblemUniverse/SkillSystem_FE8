.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4

.thumb
push	{r0}

Condition:
@has skill
ldr	r0,[r4,#0x2C]
ldr	r1,RandomMugID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x1
beq	GetRandom

ldr	r0,[r4,#0x2C]
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x0
beq	End2

GetRandom2:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800

mov	r1,r0

cmp	r1,#33
bhi	_not0
mov	r0,#0
b	GetMug2
_not0:
mov	r0,#1
cmp	r1,#66
blo	GetMug2
mov	r0,#2

GetMug2:
ldr	r1,IdentityRamByte
strb	r0,[r1]
ldr	r2,IdentityProblemsMugs
ldrb	r0,[r2,r0]
b	End

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800
GetMug:
ldr	r2,MugList
ldrb	r0,[r2,r0]
b	End

End2:
pop	{r0}
mov	r1,r0
mov	r4,#4
neg	r4,r4
ldr	r0,=#0x203
str	r0,[sp]
ldr	r3,=#0x809B9A9
bx	r3

End:
pop	{r1}
mov	r1,r0
mov	r4,#4
neg	r4,r4
ldr	r0,=#0x203
str	r0,[sp]
ldr	r3,=#0x809B9A9
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
