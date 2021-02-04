.equ SkillTester, IdentityProblemsNames+4
.equ IdentityProblemsID, SkillTester+4
.equ IdentityRamByte, IdentityProblemsID+4
.thumb
push	{r5,r6}
mov	r6,r0
mov	r5,r1
@skill check
mov	r0,r5
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
ldr	r1,IdentityRamByte
strb	r0,[r1]
lsl	r0,#1
ldr	r1,IdentityProblemsNames
ldrh	r0,[r1,r0]
b	End

Original:
mov	r1,r5
pop	{r5,r6}
ldr	r0,[r1]
ldrh	r0,[r0]
ldr	r2,=#0x800A240
mov	lr,r2
.short	0xF800
mov	r1,r0
ldr	r3,=#0x803498E
mov	lr,r3
.short	0xF800

End:
mov	r1,r5
pop	{r5,r6}
ldr	r2,=#0x800A240
mov	lr,r2
.short	0xF800
mov	r1,r0
ldr	r3,=#0x803498E
mov	lr,r3
.short	0xF800
.align
.ltorg
IdentityProblemsNames:
@POIN IdentityProblemsNames
@POIN SkillTester
@WORD IdentityProblemsID
@WORD IdentityRamByte
