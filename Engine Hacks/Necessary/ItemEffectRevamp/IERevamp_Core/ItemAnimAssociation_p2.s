.thumb
.global IER_GetSpellAnimLoop
.type IER_GetSpellAnimLoop, %function

@arguments:
	@r0 = item id
	@r1 = animation association table

IER_GetSpellAnimLoop:
ldr 	r2, =#0xFFFF	@marks end of table
reloop:
ldrh	r3,[r1]
cmp 	r3,r2	@go to End if at end of table
beq End
cmp 	r3,r0	@go to End if this is the right entry in the table
beq End
add 	r1, #0x10
b reloop
End:
mov 	r0, r1
bx	r14
.align
.ltorg
