.thumb
.include "_Definitions.h.s"

.set EAL_prSkillTester, (EALiterals+0x00)

ASMC:
	push {lr}
	
	ldr r0, =pEventSlot0
	ldr r1, [r0, #(0x02 * 4)] @ Load skill index from event slot 2
	
	ldr r0, =ppActiveUnit
	ldr r0, [r0]
	
	ldr r3, EAL_prSkillTester
	mov lr, r3
	.short 0xF800
	
	ldr r1, =pEventSlot0
	str r0, [r1, #(0x0C * 4)] @ Store result in slot C
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prSkillTester
