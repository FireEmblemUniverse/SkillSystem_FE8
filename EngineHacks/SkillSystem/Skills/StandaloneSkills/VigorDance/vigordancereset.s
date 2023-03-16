.equ VigorDanceBit, DebuffTable+4
.equ EntrySize, VigorDanceBit+4
.thumb
@ VigorDanceReset
.set gChapterData,           0x0202BCF0
.set GetUnit,                0x08019430
	@ arguments:
		@r0 = unit deployment id
	@returns:
		@r0 = unit pointer
push	{r4, lr}

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
cmp r0, #0 
beq Next 
bl GetUnitDebuffEntry 
ldr r1, =VigorDanceBitOffset_Link
ldr r1, [r1] 
bl UnsetBit 

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
mov r0, #0 @ no blocking proc / animation 
pop	{r4}
pop	{r1}
bx	r1

.align
.ltorg
DebuffTable:
@POIN DebuffTable
@WORD VigorDanceBit
@WORD EntrySize
