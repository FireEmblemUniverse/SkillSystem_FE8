.equ ArmorMarchBit, DebuffTable+4
.equ EntrySize, ArmorMarchBit+4
.equ Boost, EntrySize+4
.thumb

push	{r4-r6,lr}
mov	r4,r0		@stat
mov	r5,r1		@character pointer

@check if the bit is set in the debuff table entry
ldrb	r0,[r1,#0xB]	@allegiance byte of refreshed unit
ldr	r1,EntrySize
mul	r0,r1
ldr	r1,DebuffTable
add	r0,r1		@debuff table entry for this unit

push	{r0}
ldr	r0,ArmorMarchBit
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

ldr	r0,Boost
add	r4,r0		@add stat

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
@WORD ArmorMarchBit
@WORD EntrySize
@WORD Boost
