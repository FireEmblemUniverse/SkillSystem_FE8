.thumb

.equ SkillTester, EALiterals+0x00
.equ SkillID,     EALiterals+0x04

@ r0 is current stat, r1 is unit data
@ returns r0 = 1 if unit has skill, r0 = 0 otherwise
CheckSkill:
	push {lr}
	
	@ Loading Routine ptr in lr
	ldr r0, SkillTester
	mov lr, r0
	
	@ r0 = char data
	mov r0, r1
	
	@ r1 = skill id to check
	mov r1, r2
	
	@ call
	.short 0xf800
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@POIN SkillTester
