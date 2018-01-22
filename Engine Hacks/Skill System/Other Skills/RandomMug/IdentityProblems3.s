.equ SkillTester, IdentityProblemsNames+4
.equ IdentityProblemsID, SkillTester+4
.equ IdentityRamByte, IdentityProblemsID+4
.thumb
push	{r2}
mov	r8,r0
mov	r6,r1
mov	r0,r2

@skill check
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester
mov	r14,r2
.short	0xF800
cmp	r0,#0
beq	Original

GetRandom:
ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800

mov	r1,r0

cmp	r1,#33
bhi	_not0
mov	r0,#0
b	GetName
_not0:
mov	r0,#1
cmp	r1,#66
blo	GetName
mov	r0,#2

GetName:
lsl	r0,#1
ldr	r1,IdentityProblemsNames
ldrh	r0,[r1,r0]
pop	{r2}
b	End

Original:
pop	{r2}
ldr	r0,[r2]
ldrh	r0,[r0]

End:
ldr	r1,=#0x80365F4
mov	lr,r1
.short	0xF800
.align
.ltorg
IdentityProblemsNames:
@POIN IdentityProblemsNames
@POIN SkillTester
@WORD IdentityProblemsID
@WORD IdentityRamByte
