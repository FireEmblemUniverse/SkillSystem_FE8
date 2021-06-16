
	.thumb
	.align 4

	.include "Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE

	lpProcLearnNewSpell = EALiterals+0x00
	lprSpellAdder       = EALiterals+0x04

LearnNewSpell:
	@ Arguments: r0 = Unit, r1 = Spell Index, r2 = Parent proc
	@ Returns:   r0 = proc (if you really need it)

	push {r4-r5, lr}

	mov r4, r0 @ var r4 = Unit
	mov r5, r2 @ var r5 = Parent proc

	@ Store new Spell (without bit set)
	ldr  r3, =pExtraItemOrSkill
	strh r1, [r3]

	@ Actually learn new Spell (will set bit if forgetting is needed)
	mov r0, r4

	ldr r3, lprSpellAdder
	mov lr, r3
	.short 0xF800

	@ Call proc
	ldr r0, lpProcLearnNewSpell

	cmp r5, #0
	bne blocking

	mov r1, #3

	_blh pr6C_New

	b end

blocking:
	mov r1, r5
	_blh pr6C_NewBlocking

end:
	str r4, [r0, #0x2C]

	pop {r4-r5}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN p6CLearnNewSpell
	@ POIN prSpellAdder
