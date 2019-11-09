
	.thumb

	.include "../Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE
	pBWLTable         = 0x0203E884

ForgetEffect:
	push {r4-r6, lr}

	@ r2 = Learn Skill Id
	mov  r2, #0x3C    @ Command proc field 0x3C is command index
	ldrb r2, [r1, r2]
	sub  r2, #2       @ Leaned Skills Commands are Commands 2+ (up to 6 excluded)

	@ r0 = Char Id
	ldr  r0, [r0, #0x14] @ Menu proc Parent
	ldr  r0, [r0, #0x2C] @ Field 2C of Wrapper is Unit
	ldr  r0, [r0]       @ r0 = pActiveChar
	ldrb r0, [r0, #4]   @ r0 = ActiveCharId

	@ r3 = Learned Skill List for Active Char
	ldr r3, =pBWLTable
	lsl r0, #4 @ CharId * sizeof(BWLEntry)
	add r3, r0
	add r3, #1 @ Learned Skills start at byte 1 in BWL Entry

lop:
	@ r1 = SkillList + i
	add  r1, r3, r2

	@ r0 = SkillList + i + 1
	add  r0, r1, #1

	@ SkillList[i] = SkillList[i+1]
	@ Note that it *will* copy garbage when it comes to the last skill, but it shouldn't matter since we're overwriting it a second time later
	ldrb r0, [r0]
	strb r0, [r1]

	@ ++i
	add r2, #1

	@ Continue if i < 4
	cmp r2, #4
	blt lop

	@ SkillList[3] = NewSkill
	ldr  r0, =pExtraItemOrSkill
	ldrb r0, [r0]
	strb r0, [r1]

	@ Return (0x10 = Clear Gfx) | (0x8 = Boop) | (0x4 = Beep) | (0x2 = Kill Menu)
	mov r0, #(0x10 | 0x8 | 0x4 | 0x2)

	pop {r4-r6}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ nothing
