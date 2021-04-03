.equ VigorDanceBit, DebuffTable+4
.equ EntrySize, VigorDanceBit+4
.thumb

push	{r4-r6,lr}
mov	r4,r0		@stat
mov	r5,r1		@character pointer

@check if the bit is set in the debuff table entry
mov r0,r5
ldr r1,DebuffTable
mov lr,r1
.short 0xf800
@ ldrb	r0,[r1,#0xB]	@allegiance byte of refreshed unit
@ ldr	r1,EntrySize
@ mul	r0,r1
@ ldr	r1,DebuffTable
@ add	r0,r1		@debuff table entry for this unit

push	{r0}
ldr	r0,VigorDanceBit
mov	r1,#8
swi	6		@get the byte
pop	{r2}

add	r0,r2		@byte we are checking
mov	r2,#1
lsl	r2,r1		@bit to check
ldrb	r1,[r0]
and	r1,r2
cmp	r1,#0
beq	End

add	r4,#2		@add stat

End:
mov	r0,r4
mov	r1,r5
pop	{r4-r6}
pop	{r2}
bx	r2

.align
.ltorg
DebuffTable:
@POIN DebuffTable
@WORD VigorDanceBit
@WORD EntrySize
