.thumb

.set prSkillTester,     EALiterals+0x00
.set pSkillBowRangeUp,  EALiterals+0x04
.set pSkillStaffSavant, EALiterals+0x08

@ Arguments: r0 = Item Short, r1 = Unit Struct
GetMaxRange:
	push {r4-r6, lr}
	
	mov r4, r0
	mov r5, r1
	
	ldr r3, =#0x08017684 @ Vanilla Max Range Getter (for Item only)
	
	mov lr, r3
	.short 0xF800
	
	cmp r0, #0
	beq End @ 0 has a special meaning sometimes (mag/2), so lets keep it away
	
	mov r6, r0 @ r6 = Range
	
	mov r0, r4
	
	ldr r3, =#0x08017548 @ Get Item WType
	
	mov lr, r3
	.short 0xF800
	
	cmp r0, #3 @ Bow
	beq HandleBow
	
	@ Not Handling Staves yet because a lot of them have hardcoded effective range (to do later, but it shouldn't be taht hard)
	@ cmp r0, #4 @ Staff
	@ beq HandleStaff
	
	b Return

HandleBow:
	mov r0, r5
	ldr r1, pSkillBowRangeUp
	
	ldr r3, prSkillTester
	mov lr, r3
	.short 0xF800
	
	cmp r0, #0
	beq Return
	
	add r6, #1
	b Return
	
HandleStaff:
	mov r0, r5
	ldr r1, pSkillStaffSavant
	
	ldr r3, prSkillTester
	mov lr, r3
	.short 0xF800
	
	cmp r0, #0
	beq Return
	
	add r6, #1
	b Return
	
Return:
	mov r0, r6

End:
	pop {r4-r6}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prSkillTester
	@ WORD Bow Range Up
	@ WORD Staff Savant
