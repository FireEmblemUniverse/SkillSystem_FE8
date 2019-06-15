.thumb
.equ RightfulArchID, SkillTester+4
.equ RightfulKingID, RightfulArchID+4
.equ RightfulGodID, RightfulKingID+4

@ r0 is chance, r1 is user
@ r4 is chance, r5 is user
push	{r4-r5}

cmp	r1,#0x00
beq	End

mov	r4,r0
mov	r5,r1

ldr	r3, SkillTester
mov	lr, r3
mov	r0, r5		@user data
ldr	r1, RightfulArchID
.short	0xf800
cmp	r0, #0
beq	CheckKing
mov	r4,#0x64	@set it to 100
b	Restore

CheckKing:
ldr	r3, SkillTester
mov	lr, r3
mov	r0, r5		@user data
ldr	r1, RightfulKingID
.short	0xf800
cmp	r0, #0
beq	CheckGod
add	r4,#0x0A	@add 10

CheckGod:
ldr	r3, SkillTester
mov	lr, r3
mov	r0, r5		@user data
ldr	r1, RightfulGodID
.short	0xf800
cmp	r0, #0
beq	Restore
add	r4,#0x1E	@add 30

Restore:
mov	r0, r4
mov	r1, #0x00

End:
@first some original instructions
lsl	r0,r0,#0x10
lsr	r3,r0,#0x10
lsl	r1,r1,#0x18
lsl	r2,r1,#0x18
ldr	r0,=#0x203A4D4
ldrh	r1,[r0]

pop	{r4-r5}
ldr	r0,=#0x802A53B
bx	r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD RightfulArchID
@WORD RightfulKingID
@WORD RightfulGodID
