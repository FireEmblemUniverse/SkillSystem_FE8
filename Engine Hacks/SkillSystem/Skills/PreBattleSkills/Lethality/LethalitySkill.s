@lethality skill, does pretty much the same as vanilla one but calls skill tester to make nihil easier
@character/class ability "crit +15" (ability 1 value 0x40) no longer gives lethality chance, it now makes the unit immune to lethality
@r4 has either attacker or defendant (the skill user)
@r5 has the other one

.equ LethalityID, SkillTester+4

.thumb

push {r4,r14}

@go to skill check
mov	r0,r4
ldr	r1,LethalityID
ldr	r2,SkillTester	@test for lethality skill
mov	r14,r2
.short	0xF800
add	r4,#0x6C	@prepare the pointer to store the lethality chance
cmp	r0,#0x00
beq	NoLethality
ldr	r2,[r5]		@load character data
cmp	r2,#0x00	@just in case there's no pointer (was doing weird things with generics without this)
beq	JumpLoad1
ldr	r2,[r2,#0x28]	@load character abilities
JumpLoad1:
ldr	r0,[r5,#0x04]	@load class data
cmp	r0,#0x00	@just in case there's no pointer
beq	JumpLoad2
ldr	r0,[r0,#0x28]	@load class abilities
JumpLoad2:
orr	r0,r2		@add abilities
mov	r2,r0		@we need them twice
mov	r1,#0x40
@lsl	r1,#0x18	@value for "crit +15" ability (00 00 00 40), which now is "immune to lethality"
and	r0,r1
cmp	r0,r1		@if immune, 0 chance
beq	NoLethality
mov	r1,#0x80
lsl	r1,#0x08	@value for boss ability (80 00)
and	r2,r1
cmp	r2,r1		@if boss and not immune, half regular chance
beq	IsBoss

Normal:			
mov	r1,#0x32	@otherwise regular chance
b	End

IsBoss:
mov	r1,#0x19
b	End

NoLethality:
mov	r1,#0x00

End:
strb	r1,[r4]		@store lethality chance
pop	{r4}
pop	{r0}
bx	r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD LethalityID
