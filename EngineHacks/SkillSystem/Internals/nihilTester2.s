@ NihilTester - given ram data in r0 and skill number in r1, changes r1 to 0xFF before passing it to SkillTester when:
@ the skill is a skill that Nihil nullifies/negates (so if in the NegatedSkills list)
@ the skill is being tested in a battle or whilst targeting an enemy
@ the skill to be tested belongs to either the attacker or the defender (so they are in a battle/targeting)
@ skill 0 is always true, skill FF is always false.
@This version is meant for skills shadowgift to avoid endless looping
.thumb

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.set BattleActingUnit, 0x0203A4EC @attacker
.set BattleTargetUnit, 0x0203A56C @defender

.equ SkillTesterOriginal2, OffsetList + 0x0
.equ NegatedSkills, OffsetList + 0x4
.equ NihilID, OffsetList + 0x8
.equ CatchEmAll, OffsetList + 0xC

@arguments:
	@r0 = unit pointer
	@r1 = skill id
@returns:
	@r0 = True or False

NihilTester2:
push 	{r4-r5,lr}
mov 	r4,r0		@really need to save these for the skill tester routine
mov 	r5,r1

ldr 	r3,=#0x203A4D4	@pre-battle data pointer, gonna check if a target has been selected or the fight has started (0x02 if targeting someone, 0x01 if battle started)
ldrb 	r3,[r3]
cmp 	r3, #0x1
blo End	@if 0, not in combat, Nihil does nothing
cmp 	r3,#0x1
bhi End	@if 4 also not in combat so Nihil does nothing

ldrb 	r0,[r4,#0xB]
ldr 	r3, =BattleActingUnit
ldrb 	r1, [r3,#0xB]
cmp 	r0, r1
beq IsAttacker
ldr 	r3, =BattleTargetUnit
ldrb 	r1, [r3,#0xB]
cmp 	r0, r1
beq IsDefender
b End		@if neither, skill is never negated, I think this last condition is met when checking for nearby auras and such

IsAttacker:
ldr 	r0,=#0x203A56C	@prepare to get defender skills
b GetSkills

IsDefender:
ldr 	r0,=#0x203A4EC	@prepare to get attacker skills

GetSkills:
ldr 	r1,NihilID
ldr 	r3, SkillTesterOriginal2
_blr r3
@bl SkillTesterOriginal2
cmp 	r0, #0x0
beq End @skip the rest if opponent does not have nihil

ldr 	r1,NegatedSkills
SkillsLoop:		@check if the skill to be tested is a skill that Nihil negates
ldrb 	r3,[r1]
add 	r1,#0x01
cmp 	r3,#0x00	@check if end of list
beq End
cmp 	r3,r5		@compare with skill to be tested
beq Negated
b SkillsLoop

Negated:		@change the skill to be tested to 0xFF, this will be fed to the original skill tester, which will always return false with 0xFF
mov 	r5,#0xFF

End:
mov 	r0,r4
mov 	r1,r5		@if the skill was negated r5 contains 0, if not it contains the skill we were testing and the skill tester will work as normal

@check for catch em all
ldr 	r2,CatchEmAll
cmp 	r2,r1
beq 	End2	@do not want to loop forever
ldr 	r1,CatchEmAll
bl NihilTester2 @repeat routine to check for CatchEmAll
mov 	r1,r5
cmp 	r0,#0x0
beq End2
mov 	r1, #0x0
End2:
mov 	r0,r4
ldr 	r3, SkillTesterOriginal2
_blr r3
@bl SkillTesterOriginal2
pop 	{r4-r5,pc}

.align
.ltorg

OffsetList:
@POIN SkillTesterOriginal2
@POIN NegatedSkills
@WORD NihilID
@WORD CatchEmAllID
