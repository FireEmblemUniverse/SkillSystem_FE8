.thumb
.include "_Definitions.h.s"
.include "_Config.h.s"

.set prMakeShoveTargetList, EALiterals+0x00

.ifdef SKILL_SYSTEM_INTEGRATION
	.set prSkillTester,     EALiterals+0x04
	.set SkillShoveID,      EALiterals+0x08
.endif

ShoveUsability:
	push {lr}

	.ifdef SKILL_SYSTEM_INTEGRATION
		ldr r3, =ppActiveUnit
		ldr r0, [r3]
		
		ldr r1, SkillShoveID

		ldr r3, prSkillTester
		_blr r3

		cmp r0, #0 @ No Skill
		beq ReturnNotUsable
	.endif
	
	@ Loading Active Unit
	ldr r3, =ppActiveUnit
	ldr r0, [r3]
	
	@ Loading Unit State
	ldr r1, [r0, #0x0C]
	
	@ Canto Check
	mov r2, #0x40
	and r2, r1
	bne ReturnNotUsable
	
	.ifndef EVERYONE_SHOVE
		ldr r1, [r0, #0]
		ldr r2, [r0, #4]
		
		ldr r1, [r1, #0x28]
		ldr r2, [r2, #0x28]
		
		orr r1, r2
		mov r2, #0x01 @ Mounted Aid Flag
		
		tst r1, r2
		bne ReturnNotUsable
	.endif

	@ Making Target List
	ldr r3, prMakeShoveTargetList
	_blr r3
	
	@ Getting Size
	_blh prGetTargetListSize
	
	cmp r0, #0
	beq ReturnNotUsable
	
	mov r0, #1
	b End
	
ReturnNotUsable:
	mov r0, #3
	
End:
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prMakeShoveTargetList
	@ POIN prSkillTester
	@ WORD SkillShoveID
