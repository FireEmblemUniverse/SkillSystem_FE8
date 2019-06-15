@crit up skill, does pretty much the same as vanilla one but calls skill tester to make nihil easier
@character/class ability crit up (ability 1 value 0x40) no longer gives crit +15
@r4 has either attacker or defendant (the skill user)

.equ CritUpID, SkillTester+4

.thumb

push {r4, lr} 

mov	r4,r0		@get user into r4 for later

@go to skill check
ldr	r1,CritUpID
ldr	r2,SkillTester	@test for critup skill
mov	r14,r2
.short	0xF800
add	r4,#0x66	@pointer to crit
cmp	r0,#0x00
beq	End		@if skill not found do nothing
mov	r0,#0x0F	@crit that will be added
ldrb	r1,[r4]		@get crit
add	r1,r0		@add 15
strb	r1,[r4]		@store crit

End:
pop	{r4}
pop	{r0}
bx	r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD CritUpID
