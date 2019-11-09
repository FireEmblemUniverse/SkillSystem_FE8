.thumb
.equ SlowBurnID, SkillTester+4

push {r4-r5, lr}
mov	r4, r0 @attacker

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, SlowBurnID
.short	0xf800
cmp	r0, #0
beq	End

@get turn
ldr	r5,=#0x202BCF0
ldrh	r5, [r5,#0x10]
mov	r0, #0x01
sub	r5, r0
cmp	r5, #0x0F
bls	SkipSet
mov	r5, #0x0F

SkipSet:
@add turn to hit and avoid (if turn is higher than 15, add 15)
mov	r0, #0x60
ldrh	r1, [r4,r0]	@load hit
add	r1, r5		@add turn to hit (max 15)
strh	r1, [r4,r0]     @store

mov	r0, #0x62
ldrh	r1, [r4,r0]	@load avoid
add	r1, r5		@add turn to avoid (max 15)
strh	r1, [r4,r0]     @store

End:
pop	{r4-r5, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD SlowBurnID
