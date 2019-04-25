.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4

.thumb
OriginalStuff:
ldrb	r4,[r0]
ldrb	r0,[r0,#0x1]
lsl	r0,#0x8
add	r4,r0
ldr	r0,=#0xFFFF
cmp	r4,r0
beq	CurrentChar

ldr	r0,=#0xFFF0
cmp	r4,r0
beq	GetRandom

ldr	r0,=#0xFFE0
cmp	r4,r0
beq	GetRandom2

b	End

CurrentChar:
ldr	r0,=#0x3004E50
ldr	r0,[r0]
cmp	r0,#0x00
beq	NoChar

Condition:
ldr	r1,RandomMugID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x01
beq	GetRandom

ldr	r0,=#0x3004E50
ldr	r0,[r0]
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester	@test for skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x00
beq	End2
b	GetRandom2

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800
GetMug:
ldr	r2,MugList
ldrb	r4,[r2,r0]
ldr	r2,=#0x100
add	r4,r2
b	End

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
ldrb	r4,[r2,r0]
ldr	r2,=#0x100
add	r4,r2
b	End

NoChar:
ldr	r4,=#0x101
b	End

End:
ldr	r3,=#0x80078C1
bx	r3

End2:
ldr	r3,=#0x80078A7
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
