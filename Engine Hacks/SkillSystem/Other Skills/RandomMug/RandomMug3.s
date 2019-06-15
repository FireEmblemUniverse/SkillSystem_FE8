.equ SkillTester, MugList+4
.equ RandomMugID, SkillTester+4
.equ IdentityProblemsID, RandomMugID+4
.equ IdentityRamByte, IdentityProblemsID+4
.equ IdentityProblemsMugs, IdentityRamByte+4

.thumb
@ Edited to fit the mug loading calculation loop. - Snek
@ r0 = this control code.
push { r4, lr }
mov r4, r0

ldr	r0,=#0xFFFF
cmp	r4,r0
beq	CurrentChar

ldr	r0,=#0xFFF0
cmp	r4,r0
beq	GetRandom

ldr	r0,=#0xFFE0
cmp	r4,r0
beq	GetRandom2

b End @ This is neither control code. Return 0.


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
beq	End
b	GetRandom2

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800 @ Get RN
GetMug:
ldr	r2,MugList
ldrb	r4,[r2,r0]
ldr	r2,=#0x100
add	r4,r2
b Return @ Return this mug

GetRandom2:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800 @ Get RN

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
b Return @ Return this mug.

End:
mov r0, #0x00
Return:
pop { r4 }
pop { r1 }
bx r1

.ltorg
.align
MugList:
@POIN MugList
@POIN SkillTester
@WORD RandomMugID
@WORD IdentityProblemsID
@WORD IdentityRamByte
@POIN IdentityProblemsMugs
