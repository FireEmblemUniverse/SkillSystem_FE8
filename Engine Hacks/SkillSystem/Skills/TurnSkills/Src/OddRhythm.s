.thumb
.equ OddRhythmID, SkillTester+4

push	{r4, lr}
mov	r4, r0 @attacker
mov	r5, r1 @defender

@check if turn is odd
ldr	r0,=#0x202BCF0
ldrh	r0, [r0,#0x10]
mov	r1, #0x01
and	r0, r1
cmp	r0, #0x00
beq	End

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, OddRhythmID
.short	0xf800
cmp	r0, #0
beq	End

@add 10 to hit and avoid
mov	r0, #0x60
ldrh	r1, [r4,r0]	@load hit
add	r1, #0x0A	@add 20 to hit
strh	r1, [r4,r0]     @store

mov	r0, #0x62
ldrh	r1, [r4,r0]	@load avoid
add	r1, #0x0A	@add 20 to avoid
strh	r1, [r4,r0]     @store

End:
pop	{r4, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD OddRhythmID
