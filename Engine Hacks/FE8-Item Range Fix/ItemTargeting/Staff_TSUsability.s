.thumb
.include "_TargetSelectionDefinitions.s"
.set FindTargets, 0x08029068
@parameters
	@r0 character ram pointer
	@r1 item id
	@r2 usability condition
	@r3 range builder

push 	{r4-r6, lr}
mov 	r4, r0
mov 	r5, r1
mov 	r6, r3
cmp r2, #0x0
beq Skip
_blr	r2
cmp 	r0, #0x0	@staff is unusable if condition was not met
beq End
Skip:
mov 	r0, r4
mov 	r1, r6
mov 	r2, r5
_bldr r3, FindTargets
End:
pop 	{r4-r6}
pop 	{r1}
bx 	r1

.align
.ltorg
OffsetList:
