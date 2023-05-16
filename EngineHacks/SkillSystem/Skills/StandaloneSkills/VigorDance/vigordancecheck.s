.thumb

push	{r4-r5,lr}
mov	r4,r0		@stat
mov	r5,r1		@character pointer

@check if the bit is set in the debuff table entry
mov r0,r5
bl GetUnitDebuffEntry 
ldr r1, =VigorDanceBitOffset_Link
ldr r1, [r1] 
bl CheckBit 
cmp	r0,#0
beq	End

add	r4,#2		@add stat

End:
mov	r0,r4
mov	r1,r5
pop	{r4-r5}
pop	{r2}
bx	r2

.align
.ltorg

