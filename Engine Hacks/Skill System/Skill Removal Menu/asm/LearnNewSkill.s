.thumb
.include "_Definitions.h.s"

.set pExtraItemOrSkill,  0x0202BCDE

.set EAL_p6CLearnNewSkill, (EALiterals+0x00)
.set EAL_prSkillAdder,     (EALiterals+0x04)

LearnNewSkill:
	push {r4, lr}
	
	mov r4, r1
	
	@ Store new skill (without bit set)
	ldr  r3, =pExtraItemOrSkill
	strh r0, [r3]
	
	@ Actually learn new skill (will set bit if forgetting is needed)
	mov r1, r0
	ldr r0, =ppActiveUnit
	ldr r0, [r0]
	
	ldr r3, EAL_prSkillAdder
	mov lr, r3
	.short 0xF800
	
	@ Call 6C
	ldr r0, EAL_p6CLearnNewSkill
	
	cmp r4, #0
	bne Blocking
	
	mov r1, #3
	
	_blh pr6C_New
	
	b End
	
Blocking:
	mov r1, r4
	_blh pr6C_NewBlocking
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN p6CLearnNewSkill
	@ POIN prSkillAdder
