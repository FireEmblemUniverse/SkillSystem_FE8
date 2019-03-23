.thumb

@arguments:
@	r0: max range
@	r1: min range
push	{r4-r5,lr}
ldr 	r4, StrangeRanges
mov 	r5, #0x0
mov 	r3, #0x1
neg 	r3, r3
loop:
ldrb 	r2, [r4]
cmp 	r2, r0	@check if max range matches
bne reloop
ldrb 	r2, [r4,#0x1]
cmp 	r2, r1	@check if min range matches
bne reloop
ldrh 	r5, [r4,#0x2]	@grab text id
b End	@exit loop
reloop:
add 	r4, r4, #0x8	@go to next entry in table
mov 	r2, #0x0
ldsh 	r2, [r4,r2]
cmp r2, r3	@end loop if both min and max range are 0xff
bne loop

End:
mov 	r0, r5	@return text id or 0 if nothing was found
pop 	{r4-r5}
pop 	{r3}
bx	r3
.align
.ltorg
StrangeRanges:
