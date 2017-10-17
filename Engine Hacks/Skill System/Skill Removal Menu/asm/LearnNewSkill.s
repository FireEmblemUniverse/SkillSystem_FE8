.thumb
.include "_Definitions.h.s"

.set pExtraItemOrSkill,  0x0202BCDE

.set EAL_p6CLearnNewSkill, (EALiterals+0x00)
.set EAL_prSkillAdder,     (EALiterals+0x04)

@ Arguments: r0 = Unit, r1 = Skill Index, r2 = Parent 6C
@ Returns:   r0 = 6C (if you really need it)
LearnNewSkill:
	push {r4-r5, lr}
	
	mov r4, r0 @ var r4 = Unit
	mov r5, r2 @ var r5 = Parent 6C
	
	@ Store new skill (without bit set)
	ldr  r3, =pExtraItemOrSkill
	strh r1, [r3]
	
	@ Actually learn new skill (will set bit if forgetting is needed)
	mov r0, r4
	
	ldr r3, EAL_prSkillAdder
	mov lr, r3
	.short 0xF800
	
	@ Call 6C
	ldr r0, EAL_p6CLearnNewSkill
	
	cmp r5, #0
	bne Blocking
	
	mov r1, #3
	
	_blh pr6C_New
	
	b End
	
Blocking:
	mov r1, r5
	_blh pr6C_NewBlocking
	
End:
	str r4, [r0, #0x2C]
	
	pop {r4-r5}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN p6CLearnNewSkill
	@ POIN prSkillAdder
