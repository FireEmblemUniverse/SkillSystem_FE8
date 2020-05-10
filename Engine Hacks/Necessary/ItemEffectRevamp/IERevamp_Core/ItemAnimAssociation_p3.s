.thumb
.global IER_GetEffectAnimLoop
.type IER_GetEffectAnimLoop, %function

@arguments:
	@r0 = item id
	@r1 = animation association table

IER_GetEffectAnimLoop:
push 	{r4-r5,lr}
mov 	r5, r0
mov 	r4, r1
bl 	Item_GetStat_EffectID
ldr 	r2, =#0xFFFF	@marks end of table
reloop:
ldrh	r1,[r4]
cmp 	r1,r2	@go to End if at end of table
beq End
cmp r1, r0	@check if effect id matches
bne getNextEntry
ldrh 	r1, [r4,#0x6]
cmp 	r1, r5
beq 	End
cmp 	r1, #0x0
beq 	End

getNextEntry:
add 	r4, #0x10
b 	reloop
End:
mov 	r0, r4
pop 	{r4-r5}
pop 	{r3}
bx 	r3
.align
.ltorg
