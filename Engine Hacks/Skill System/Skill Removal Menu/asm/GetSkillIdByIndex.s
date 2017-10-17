.thumb
.include "_Definitions.h.s"

.set lpCharSkillTable,  (EALiterals+0x00)
.set lpClassSkillTable, (EALiterals+0x04)

.set pExtraItemOrSkill, 0x0202BCDE
.set pBWLTable,         0x0203E884

@ Arguments: r0 = Unit Struct, r1 = Index
@ Returns:   r0 = Skill Id (0 if none)
GetSkillIdByIndex:
	push {r4, lr}
	
	cmp r1, #0
	bne NotCharSkill
	
	ldr  r2, [r0]
	ldrb r2, [r2, #4]
	
	ldr  r3, lpCharSkillTable
	ldrb r0, [r3, r2]
	
	b End

NotCharSkill:
	cmp r1, #1
	bne NotClassSkill
	
	ldr  r2, [r0, #4]
	ldrb r2, [r2, #4]
	
	ldr  r3, lpClassSkillTable
	ldrb r0, [r3, r2]
	
	b End
	
NotClassSkill:
	cmp r1, #6
	bne NotExtraLearnSkill
	
	ldr  r2, =pExtraItemOrSkill
	ldrb r0, [r2]
	
	b End
	
NotExtraLearnSkill:
	sub r1, #2
	blt ReturnZero
	
	cmp r1, #4
	bge ReturnZero
	
	@ r2 = Char Id
	ldr  r2, [r0]
	ldrb r2, [r2, #4]
	
	@ if CharID > 0x46 then return 0
	cmp r2, #0x46
	bhi ReturnZero
	
	lsl  r2, #4
	
	ldr  r3, =pBWLTable
	add  r3, r2
	add  r3, #1
	ldrb r0, [r3, r1]

	b End
	
ReturnZero:
	mov r0, #0
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN CharacterSkillTable
	@ POIN ClassSkillTable
