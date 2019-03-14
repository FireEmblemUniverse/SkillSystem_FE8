
	.thumb

	.include "../Definitions.inc"

	@ GetTextInStdBuffer = 0x0800A240|1
	@ GenTextTiles       = 0x08004004|1
	@ DrawText           = 0x08003E70|1

	@ DrawIcon           = 0x080036BC|1 @ Arguments: r0 = Where, r1 = Icon Index, r2 = ?

	lprDrawSkillMenuCommand = EALiterals+0x00
	lprGetSkillIdByIndex    = EALiterals+0x04

Draw:
	push {r4-r7, lr}

	mov r4, r1 @ r4 = Command proc

	ldr r5, =#0x02022CA8 @ BG0 Map Buffer

	ldrh r1, [r4, #0x2A]
	ldrh r2, [r4, #0x2C]

	@ r5 = Tile Position To Draw To
	lsl r2, #5
	add r2, r1
	lsl r2, #1
	add r5, r2

	@ r1 = command index (skill index)
	mov  r1, #0x3C
	ldrb r1, [r4, r1]

	mov r3, r4
	add r3, #0x34

	cmp r1, #2
	bge non_fixed_skill @ If Skill Index >= 2 (not Char nor Class Skill), then no need to set the color to gray.

	@ Setting Text Color to Gray
	mov  r2, #1
	strb r2, [r3, #3]

non_fixed_skill:
	cmp r1, #6
	bne non_extra_learn_skill @ If Skill Index != 6 (not Extra new learning skill), then no need to set the color to blue

	@ Setting Text Color to Blue
	mov  r2, #2
	strb r2, [r3, #3]

non_extra_learn_skill:
	ldr r0, [r0, #0x14] @ Menu 6C Parent
	ldr r0, [r0, #0x2C] @ Field 2C of Wrapper is Unit

	ldr  r3, lprGetSkillIdByIndex
	_blr r3

	@ arg r2 = Skill Id
	mov r2, r0

	@ arg r0 = Tile Position
	mov r0, r5

	@ arg r1 = Text Info Struct
	mov r1, r4
	add r1, #0x34

	ldr  r3, lprDrawSkillMenuCommand
	_blr r3

	pop {r4-r7}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN prDrawSkillMenuCommand
	@ POIN prGetSkillIdByIndex
