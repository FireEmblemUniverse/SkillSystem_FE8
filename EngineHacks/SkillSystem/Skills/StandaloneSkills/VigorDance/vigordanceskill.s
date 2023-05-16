.equ VigorDanceID, SkillTester+4
.equ DebuffTable, VigorDanceID+4
.equ VigorDanceBit, DebuffTable+4
.equ EntrySize, VigorDanceBit+4
.thumb

.set gActionData,            0x0203A958

push	{r0,r4}
mov	r4,r0		@unit being refreshed

@get the dancer character data
ldr	r0,=gActionData	@action struct
ldrb	r0,[r0,#0xC]	@dancer's allegiance byte
ldr	r1,=#0x8019430	@get char data
mov	lr,r1
.short	0xf800		@r0 = pointer to dancer in ram

@check if the dancer has the skill
ldr	r1,SkillTester
mov	lr,r1
ldr	r1,VigorDanceID
.short	0xf800
cmp	r0,#0
beq	End

@set the bit for this skill in the debuff table entry for the refreshed unit
mov	r0,r4
bl GetUnitDebuffEntry 
ldr r1, =VigorDanceBitOffset_Link
ldr r1, [r1] 
bl SetBit 

End:
pop	{r0,r4}
ldr	r1,[r0,#0xC]
ldr	r2,=#0x80323A0
ldr	r2,[r2]
and	r1,r2
str	r1,[r0,#0xC]
ldrb	r0,[r4,#0xC]
ldr	r3,=#0x803236D
bx	r3

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD VigorDanceID
@POIN DebuffTable
@WORD VigorDanceBit
@WORD EntrySize
