.equ VigorDanceBit, DebuffTable+4
.equ EntrySize, VigorDanceBit+4
.thumb

.set gChapterData,           0x0202BCF0
.set GetUnit,                0x08019430
	@ arguments:
		@r0 = unit deployment id
	@returns:
		@r0 = unit pointer

cmp	r0,#1
beq	set0
mov	r0,#1
b	doneSet
set0:
mov	r0,#0
doneSet:
push	{r0,r4}

@r3 is our counter
ldr	r0,=gChapterData
ldrb	r4,[r0,#0x0F]	@phase
add	r4,#1

Loop:
@unset the bit for this skill in the debuff table entry for the unit

mov r0,r4
ldr r1,=GetUnit
mov lr,r1
.short 0xf800
ldr r1,DebuffTable
mov lr,r1
.short 0xf800
@ ldr	r0,DebuffTable
@ mov	r1,r3
@ ldr	r2,EntrySize
@ mul	r1,r2
@ add	r0,r1		@debuff table entry for this unit
push	{r0}
ldr	r0,VigorDanceBit
mov	r1,#8
swi	6		@get the byte
pop	{r2}
add	r0,r2		@byte we are modifying
mov	r2,#1
lsl	r2,r1		@bit to unset
ldrb	r1,[r0]
mvn	r2,r2
and	r1,r2
strb	r1,[r0]		@unset the bit

Next:
add	r4,#1
cmp	r4,#0x3F @end of player units
beq	End
cmp	r4,#0x55 @end of green units
beq	End
cmp	r4,#0xB3 @end of enemy units
beq	End
b	Loop

End:
pop	{r0,r4}
pop	{r1}
bx	r1

.align
.ltorg
DebuffTable:
@POIN DebuffTable
@WORD VigorDanceBit
@WORD EntrySize
