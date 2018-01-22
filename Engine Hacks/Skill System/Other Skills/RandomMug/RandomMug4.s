.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4

.thumb
push	{r4}
mov	r4,r0
Condition:
@has skill
mov	r0,r5
ldr	r0,[r0]
ldr	r1,RandomMugID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x1
beq	GetRandom

mov	r0,r5
ldr	r0,[r0]
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
mov	r0,r4
End:
pop	{r4}

mov	r1,r0
mov	r0,#2
str	r0,[sp]
mov	r0,#0
mov	r2,#0xB0
ldr	r3,=#0x8022C02
mov	lr,r3
mov	r3,#0xC
.short	0xF800
.ltorg
.align
MugList:
@POIN MugList
@POIN SkillTester
@WORD RandomMugID
@WORD IdentityProblemsID
@WORD IdentityRamByte
@POIN IdentityProblemsMugs
