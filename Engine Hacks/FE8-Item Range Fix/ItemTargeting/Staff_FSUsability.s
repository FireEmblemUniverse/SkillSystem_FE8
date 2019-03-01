.thumb
.include "_TargetSelectionDefinitions.s"
@usability check
@parameters: 
	@r0 = character ram pointer
	@r1 = item id
	@r2 = use condition
	@r3 = range builder

push {r4-r6, lr}
mov 	r4, r0
mov 	r5, r1
mov 	r6, r3
cmp 	r2, #0x0
beq Skip
_blr 	r2
cmp 	r0, #0x0
beq End
Skip:
mov 	r3, r6
cmp 	r3, #0x0
beq Skip2
mov 	r0, r4
mov 	r2, r5
_blr 	r3
Skip2:
mov 	r2, #0x1
End:
mov 	r0, r2
pop 	{r4-r6}
pop 	{r3}
Jump:
bx 	r3

.align
.ltorg
OffsetList:
