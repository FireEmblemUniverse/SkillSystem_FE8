.thumb
.equ QuickBurnID, SkillTester+4

push {r4-r5, lr}
mov	r4, r0 @attacker

@check if turn is bigger than 15
ldr	r5,=#0x202BCF0
ldrh	r5, [r5,#0x10]
cmp	r5, #0x0F
bhi	End

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, QuickBurnID
.short	0xf800
cmp	r0, #0
beq	End

@add 16 - turn to hit and avoid
mov	r0, #0x60
ldrh	r1, [r4,r0]	@load hit
add	r1, #0x10	@add 16 to hit
sub	r1, r5		@subtract turn to hit (so result is hit = hit + 16 - turn)
strh	r1, [r4,r0]     @store

mov	r0, #0x62
ldrh	r1, [r4,r0]	@load avoid
add	r1, #0x10	@add 16 to avoid
sub	r1, r5		@subtract turn to hit (so result is hit = hit + 16 - turn)
strh	r1, [r4,r0]     @store

End:
pop	{r4-r5, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD QuickBurnID
