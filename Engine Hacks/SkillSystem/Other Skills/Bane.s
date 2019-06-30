@bane skill, skill/2% chance of reducing enemy hp to 1 if the attack wouldn't have killed (does not trigger if damage > current enemy hp-1)
@character/class ability "crti +15" (ability 1 value 0x40) no longer gives lethality chance, it now makes the unit immune to lethality
@r4 has either attacker or defendant (the skill user)
@r5 has the other one

.equ LethalityID, SkillTester+4
.equ BaneID, LethalityID+4

.thumb

push {r4,r14}

@go to skill check
mov	r0,r4
ldr	r1,LethalityID
ldr	r2,SkillTester	@test for lethality skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x01	@if lethality is found, ignore bane
beq	End

mov	r0,r4
ldr	r1,BaneID
ldr	r2,SkillTester	@test for bane skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x00
beq	NoBane

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
beq	NoBane
mov	r1,#0x80
lsl	r1,#0x08	@value for boss ability (80 00)
and	r2,r1
cmp	r2,r1		@if boss, 0 chance
beq	NoBane

Normal:			@roll is done in procloopparent
mov	r1,#0x7F	@set to 100% chance of getting lethality (will trigger even if the unit doesn't crit)
b	Store

NoBane:
mov	r1,#0x00	@if no lethality and no bane chance is 0

Store:
add	r4,#0x6C	@prepare the pointer to store the bane chance
strb	r1,[r4]		@store bane chance

End:
pop	{r4}
pop	{r0}
bx	r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD LethalityID
@WORD BaneID
