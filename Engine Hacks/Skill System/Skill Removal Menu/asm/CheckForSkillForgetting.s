.thumb
.include "_Definitions.h.s"

.set EAL_prCallSkillForgetMenu, (EALiterals+0x00)

.set pExtraItemOrSkill,          0x0202BCDE

@ Arguments: r0 = Unit, r1 = Parent 6C
@ Returns:   r0 = 0 on success (aka a skill is to be learned)
CheckForSkillForgetting:
	push {r4, lr}
	
	ldr  r3, =pExtraItemOrSkill
	ldrh r3, [r3]
	
	lsr r3, #15
	beq NoNewSkill @ last bit not set
	
	@ implied @ arg r0 = Unit
	@ implied @ arg r1 = Parent 6C
	
	ldr  r3, EAL_prCallSkillForgetMenu
	_blr r3
	
	mov r0, #0
	b End
	
NoNewSkill:
	mov r0, #1
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prCallSkillForgetMenu

