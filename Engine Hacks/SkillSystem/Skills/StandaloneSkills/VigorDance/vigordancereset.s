.equ VigorDanceBit, DebuffTable+4
.equ EntrySize, VigorDanceBit+4
.thumb

cmp	r0,#1
beq	set0
mov	r0,#1
b	doneSet
set0:
mov	r0,#0
doneSet:
push	{r0}

@r3 is our counter
ldr	r0,=#0x202BCF0
ldrb	r3,[r0,#0x0F]	@phase
add	r3,#1

Loop:
@unset the bit for this skill in the debuff table entry for the unit
ldr	r0,DebuffTable
mov	r1,r3
ldr	r2,EntrySize
mul	r1,r2
add	r0,r1		@debuff table entry for this unit
push	{r0,r3}
ldr	r0,VigorDanceBit
mov	r1,#8
swi	6		@get the byte
pop	{r2,r3}
add	r0,r2		@byte we are modifying
mov	r2,#1
lsl	r2,r1		@bit to unset
ldrb	r1,[r0]
mvn	r2,r2
and	r1,r2
strb	r1,[r0]		@unset the bit

Next:
add	r3,#1
cmp	r3,#0x3F
beq	End
cmp	r3,#0x55
beq	End
cmp	r3,#0xB3
beq	End
b	Loop

End:
pop	{r0}
pop	{r1}
bx	r1

.align
.ltorg
DebuffTable:
@POIN DebuffTable
@WORD VigorDanceBit
@WORD EntrySize
