.thumb
.equ gBattleData, 0x203A4D4

push 	{r4, lr}
@make sure we're in combat (or combat prep)
ldrb	r3, =gBattleData
ldrb	r3, [r3]
cmp		r3, #4
beq		End

ldr		r2, ApplyLeadershipBonus
mov		lr, r2
.short	0xf800 				@bl to lr

End:
pop 	{r4}
pop 	{r0}
bx		r0

.align
.ltorg
ApplyLeadershipBonus:
@POIN ApplyLeadershipBonus
