.thumb
.include "_Definitions.h.s"

.set EAL_prCheckForSkillForgetting, (EALiterals+0x00)

ay:
	push {r4, lr}
	
	mov r4, r0 @ var r4 = Battle/Arena 6C Struct
	
CheckInstigator:
	ldr r0, =pBattleUnitInstiagator
	
	ldrb r1, [r0, #0x13] @ Current HP
	
	cmp r1, #0
	beq CheckTarget @ Unit is ded
	
	ldrb r0, [r0, #0x0B] @ Unit Index
	
	mov r1, #0xC0
	tst r0, r1
	beq Yes @ Not NPC nor Enemy
	
CheckTarget:
	ldr r0, =pBattleUnitTarget
	
	ldrb r1, [r0, #0x13] @ Current HP
	
	cmp r1, #0
	beq No @ Unit is ded
	
	ldrb r0, [r0, #0x0B] @ Unit Index
	
	mov r1, #0xC0
	tst r0, r1
	bne No @ NPC or Enemy
	
Yes:
	_blh prUnit_GetStruct
	
	mov r1, r4
	
	ldr  r3, EAL_prCheckForSkillForgetting
	_blr r3
	
	b End

No:
	mov r0, #1 @ Continue
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prCheckForSkillForgetting
