.equ SkillTester, IdentityProblemsNames+4
.equ IdentityProblemsID, SkillTester+4
.equ IdentityRamByte, IdentityProblemsID+4
.thumb
push	{r5}
mov	r5,r1
@skill check
ldr	r0,[r5,#0x30]
ldr	r1,IdentityProblemsID
ldr	r2,SkillTester
mov	r14,r2
.short	0xF800
cmp	r0,#0
beq	Original

GetName:
ldr	r1,IdentityRamByte
ldrb	r0,[r1]
lsl	r0,#1
ldr	r1,IdentityProblemsNames
ldrh	r0,[r1,r0]
b	End

Original:
ldr	r0,[r5,#0x30]
ldr	r0,[r0]
ldrh	r0,[r0]

End:
mov	r1,r5
pop	{r5}
ldr	r3,=#0x800A240
mov	lr,r3
.short	0xF800
mov	r7,r0
ldr	r3,=#0x809BA2F
bx	r3

.align
.ltorg
IdentityProblemsNames:
@POIN IdentityProblemsNames
@POIN SkillTester
@WORD IdentityProblemsID
@WORD IdentityRamByte
