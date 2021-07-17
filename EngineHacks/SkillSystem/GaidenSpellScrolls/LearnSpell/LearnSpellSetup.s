
	.thumb
	.align 4

	.include "Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE
	pUnitStructRam = 0x30017BC

	lpProcLearnNewSpell			= EALiterals+0x00
	LearnNewSpell      			= EALiterals+0x04
	pProc_ReplaceSpellLearn		= EALiterals+0x08
	SkillDebugCommand_OnSelect	= EALiterals+0x0C

LearnSpellSetup:
	@ Arguments: r0 = Unit, r1 = Spell Index, r2 = Parent proc
	@ Returns:   r0 = proc (if you really need it)

	push {r4-r6, lr}

	mov r4, r0 @ var r4 = Unit
	mov r5, r2 @ var r5 = Parent proc
	mov r6, r1 @ var r6 = spell index 

	@ Store new Spell (without bit set)
	ldr  r3, =pExtraItemOrSkill
	strh r1, [r3]

	@ Actually learn new Spell (will set bit if forgetting is needed)
	mov r0, r4
	ldr r3, =pUnitStructRam
	str r0, [r3] 

	ldr r3, LearnNewSpell
	mov lr, r3
	.short 0xF800

	cmp r0, #0
	beq ForgetOldMove
	@ Call proc
	ldr r0, lpProcLearnNewSpell

	cmp r5, #0
	bne lpProcLearnNewSpell_blocking
	mov r1, #3
	_blh pr6C_New

	b end

lpProcLearnNewSpell_blocking:
	mov r1, r5
	_blh pr6C_NewBlocking

end:
	str r4, [r0, #0x2C]
	b exit 
	





	ForgetOldMove: @ LearnSpell returns T/F in r0, RamUnit in r1, and SpellToLearn in r2 
	mov r3, r1 @ Ram unit 
				@push {r2, r3} @ save what we want to keep on the stack for later
    ldr r0, pProc_ReplaceSpellLearn
    cmp r5, #0
    bne ForgetOldMove_blocking
	
    mov r1, #3
    _blh pr6C_New
	b ForgetOldMove_store
	
	ForgetOldMove_blocking:
	mov r1, r5 
	_blh pr6C_NewBlocking
	
	ForgetOldMove_store:
    @ new stuff here
	mov r2, r6  @ Spell
	mov r3, r4 @ Unit
				@pop {r2, r3} @ retrieve what we saved earlier; we needed to save it because a call to pr6C_New may clobber r0-r3
    str r2, [r0, #0x2C] @ store r2 in field +2C of the proc struct (the first free word)
    str r3, [r0, #0x30] @ store r3 in field +30 of the proc struct (the second free word)
	b exit

	


@Store to s7 as break point: [0x30004D4]!!
	.equ MemorySlot, 0x30004B8 
exit:
	@ cba making this work properly via storing to the proc fields 
	@ so we're storing it to s6 and s7 instead
	@ oh well 
	ldr r1, =MemorySlot
	str r2, [r1, #4*0x07]
	str r3, [r1, #4*0x06]
	pop {r4-r6}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN p6CLearnNewSpell
	@ POIN LearnNewSpell
	@ POIN pProc_ReplaceSpellLearn		
	@ POIN SkillDebugCommand_OnSelect	
	