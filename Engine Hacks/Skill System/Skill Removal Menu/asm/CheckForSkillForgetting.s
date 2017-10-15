.thumb
.include "_Definitions.h.s"

.set EAL_prCallSkillForgetMenu, (EALiterals+0x00)

.set pExtraItemOrSkill,          0x0202BCDE

@ Arguments: r0 = Parent 6C
CheckForSkillForgetting:
	push {r4, lr}
	
	mov r4, r0
	
	ldr  r0, =pExtraItemOrSkill
	ldrh r1, [r0]
	
	lsr r0, r1, #15
	beq NoNewSkill @ last bit not set
	
	ldr r3, EAL_prCallSkillForgetMenu
	mov lr, r3
	
	mov r0, r4 @ arg r0 = parent 6C
	
	.short 0xF800
	
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

