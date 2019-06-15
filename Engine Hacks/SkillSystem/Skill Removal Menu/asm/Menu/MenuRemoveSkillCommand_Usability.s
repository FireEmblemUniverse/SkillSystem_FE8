
	.thumb

	.include "../Definitions.inc"

Command_Usability:
	push {lr}

	@ I'm cheating a bit here, and abusing the fact that the usability routine is only called at 0804ED9C, where in r5 lies the Menu proc Struct pointer.
	@ IS apparently didn't feel the need to pass it as argument over here
	@ Ugh
	@ Anyway that's why there's a random r5 here

	ldr r0, [r5, #0x14] @ Menu proc Parent
	ldr r0, [r0, #0x2C] @ Field 2C of Wrapper is Unit

	ldr  r3, EALiterals
	_blr r3

	cmp r0, #0
	beq unusable

	mov r0, #1
	b end

unusable:
	mov r0, #3

end:
	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN prGetSkillIdByIndex
