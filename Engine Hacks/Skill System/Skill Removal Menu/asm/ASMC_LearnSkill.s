.thumb
.include "_Definitions.h.s"

.set EAL_prLearnNewSkill, (EALiterals+0x00)

ASMC:
	push {lr}
	
	mov r1, r0 @ arg r1 = parent 6C (event engine)
	
	ldr r0, =pEventSlot0
	ldr r0, [r0, #(4 * 2)] @ Load skill index from event slot 2
	
	ldr r3, EAL_prLearnNewSkill
	mov lr, r3
	.short 0xF800
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prLearnNewSkill
