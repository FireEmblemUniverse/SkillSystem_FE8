.equ Boost, EntrySize+4
.thumb

push	{r4-r6,lr}
mov	r4,r0		@stat
mov	r5,r1		@ unit struct 

mov r0, r5 
bl GetUnitDebuffEntry 
ldr	r1, =ArmorMarchBitOffset_Link
ldr r1, [r1] 
bl CheckBit 
cmp r0, #0 
beq End 
ldr	r0, =ArmorMarchBoost
ldr r0, [r0] 
add	r4,r0		@add stat

End:
mov	r0,r4
mov	r1,r5
pop	{r4-r6}
pop	{r2}
bx	r2

.ltorg

