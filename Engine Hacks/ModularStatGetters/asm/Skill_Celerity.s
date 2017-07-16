.thumb
@r0 is current stat
@r1 is unit data
Celerity:
	push {r4-r6,lr}
	mov r4, r0
	mov r5, r1

	ldr r0, EALiterals @SkillTester
	mov lr, r0
	mov r0, r5
	ldr r1, EALiterals+4 @CelerityID
	.short 0xf800
	cmp r0, #0
	beq End
		add r4, #1
End:
	mov r0, r4
	mov r1, r5
	pop {r4-r6,pc}

.ltorg
.align

EALiterals:
@POIN SkillTester
@WORD CelerityID
