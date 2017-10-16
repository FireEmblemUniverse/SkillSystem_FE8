.thumb
.include "_Definitions.h.s"

.set pExtraItemOrSkill,  0x0202BCDE

.set prNewPopup,        (0x08011474+1)
.set prSetPopupShort,   (0x0801145C+1)

.set EAL_pPopupDef,     (EALiterals+0x00)
.set EAL_time,          (EALiterals+0x04)

@ Arguments: r0 = Parent 6C
@ Returns:   r0 = 0 on success (skill is displayed)
hey:
	push {r4, lr}
	
	@ Save 6C for later
	mov r4, r0
	
	@ Load Skill index short
	ldr  r3, =pExtraItemOrSkill
	ldrh r0, [r3]
	
	@ Check if zero
	cmp r0, #0
	beq NoPopup
	
	@ Set skill index
	ldrb r0, [r3]
	_blh prSetPopupShort
	
	ldr r0, EAL_pPopupDef @ arg r0 = popup definition pointer
	ldr r1, EAL_time      @ arg r1 = time the popup stays up
	mov r2, #0            @ arg r2 = popup window style
	mov r3, r4            @ arg r3 = parent 6C (0 works)
	
	_blh prNewPopup, r4
	
	mov r0, #0 @ Yield 6C (in case it was used with 6C code 0x16)
	b End
	
NoPopup:
	mov r0, #1 @ Continue 6C (in case it was used with 6C code 0x16)
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN pPopupDef
	@ WORD Time
