@ NihilTester - given ram data in r0 and skill number in r1, changes r1 to 0xFF before passing it to SkillTester when:
@ the skill is a skill that Nihil nullifies/negates (so if in the NegatedSkills list)
@ the skill is being tested in a battle or whilst targeting an enemy
@ the skill to be tested belongs to either the attacker or the defender (so they are in a battle/targeting)
@ skill 0 is always true, skill FF is always false.
@ I probably was really wasteful with the registers but oh well I did not think about that until I had tested a billion skills and I lazy

.equ NihilID, SkillTesterOriginal+4
.equ Skill_Getter, NihilID+4
.equ NegatedSkills, Skill_Getter+4
.equ SkillTester, NegatedSkills+4
.equ CatchEmAll, SkillTester+4
.equ FreeByte, CatchEmAll+4
.thumb

push {r4-r7,lr}

mov	r7,r0		@really need to save these for the skill tester routine
mov	r6,r1
ldr	r4,=#0x203A4D4	@pre-battle data pointer, gonna check if a target has been selected or the fight has started (0x02 if targeting someone, 0x01 if battle started)
ldrb	r4,[r4]
cmp	r4,#0x01
blo	End	@if 0, not in combat, Nihil does nothing
cmp	r4,#0x02
bhi	End	@if 4 also not in combat so Nihil does nothing

ldrb	r0,[r7,#0x0B]
ldr	r4,=#0x203A4EC
ldrb	r4,[r4,#0x0B]
cmp	r0,r4		@check if the skill to test is from the attacker (compares allegiance byte of attacker and unit whose skill is being tested)
beq	IsAttacker
ldr	r4,=#0x203A56C
ldrb	r4,[r4,#0x0B]
cmp	r0,r4		@check if the skill to test is from the defender (compares allegiance byte of defender and unit whose skill is being tested)
beq	IsDefender
b	End		@if neither, skill is never negated, I think this last condition is met when checking for nearby auras and such

IsAttacker:
ldr	r0,=#0x203A56C	@prepare to get defender skills
ldr	r5,=#0x203A4EC	@and to set lethality to 0 if we find nihil
b	GetSkills

IsDefender:
ldr	r0,=#0x203A4EC	@prepare to get attacker skills
ldr	r5,=#0x203A56C	@and to set lethality to 0 if we find nihil

GetSkills:		@gets skills (returns pointer in r0 that contains a list of the skills the unit has terminated in 0)
ldr	r4,Skill_Getter
mov	lr,r4
.short	0xF800
ldr	r1,NihilID

NihilCheckLoop:		@check skills until end of the list or Nihil is found to find out if the target has Nihil
ldrb	r4,[r0]		@pointer to skills provided by skill getter
add	r0,#0x01
cmp	r4,#0x00	@checking if end of list, so no Nihil
beq	End
cmp	r4,r1		@checking if Nihil
bne	NihilCheckLoop

ldr	r1,NegatedSkills
SkillsLoop:		@check if the skill to be tested is a skill that Nihil negates
ldrb	r5,[r1]
add	r1,#0x01
cmp	r5,#0x00	@check if end of list
beq	End
cmp	r5,r6		@compare with skill to be tested
beq	Negated
b	SkillsLoop

Negated:		@change the skill to be tested to 0xFF, this will be fed to the original skill tester, which will always return false with 0xFF
mov	r6,#0xFF

End:
mov	r0,r7
mov	r1,r6		@if the skill was negated r6 contains 0, if not it contains the skill we were testing and the skill tester will work as normal

@check for catch em all
ldr	r2,CatchEmAll
cmp	r2,r1
beq	End2	@do not want to loop forever
ldr	r1,CatchEmAll
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
mov	r1,r6
cmp	r0,#0
beq	End2
mov	r1,#0
End2:
mov	r0,r7
ldr	r4,SkillTesterOriginal
mov	lr,r4
.short	0xF800
pop {r4-r7,pc}

.align
.ltorg
SkillTesterOriginal:
@POIN SkillTesterOriginal
@WORD NihilID
@POIN Skill_Getter
@POIN NegatedSkills
@POIN SkillTester
@WORD CatchEmAll
