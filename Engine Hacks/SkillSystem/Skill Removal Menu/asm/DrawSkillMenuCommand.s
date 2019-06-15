
	.thumb

	.include "Definitions.inc"

	prGetStringInStdBuffer = 0x0800A240|1
	prGenTextTiles         = 0x08004004|1
	prDrawText             = 0x08003E70|1
	prDrawIcon             = 0x080036BC|1 @ Arguments: r0 = Where, r1 = Icon Index, r2 = ?

	lpaSkillDescTable      = EALiterals+0x00

DrawSkillMenuCommand:
	@ Arguments: r0 = Where, r1 = Text Info Struct, r2 = Skill Id

	push {r4-r6, lr}

	@ moving arguments in saved registers
	mov r4, r0
	mov r5, r1
	mov r6, r2

	@ Setup a little margin for text because Skill Icons are HUGE
	mov  r0, #2
	strb r0, [r5, #2] @ Text Struct field 2 = local x cursor

	@ Getting Skill Desc for current skill
	ldr  r3, lpaSkillDescTable
	lsl  r0, r6, #1
	ldrh r0, [r3, r0]

	@ Getting Skill Desc Text, then Skill Name from that
	_blh prGetStringInStdBuffer
	bl GetSkillNameFromSkillDesc

	@ Generating text tiles

	mov r1, r0 @ arg r1 = String pointer
	mov r0, r5 @ arg r0 = Text Struct

	_blh prGenTextTiles

	@ Drawing text tiles on output

	mov r0, r5     @ arg r0 = Text Struct
	add r1, r4, #4 @ arg r1 = Output tile root

	_blh prDrawText

	@ Drawing skill icon

	mov r0, r4      @ arg r0 = Output tile root

	mov r1, #0x01
	lsl r1, #8
	orr r1, r6      @ arg r1 = Icon Identifer (Icon #SkillId in Sheet #0x01)

	ldr r2, =0x4000 @ arg r2 = 0x4000 (palette #4)

	_blh prDrawIcon

	pop {r4-r6}

	pop {r0}
	bx r0

	.pool
	.align

GetSkillNameFromSkillDesc:
	@ Arguments: r0 = String; Returns: r0 = same String
	@ Replaces the first colon (':') character by a 0, effectively ending the string there
	@ Since all skill desc are in the format "<name>: <desc>" it gets the skill name from the skill desc

	sub r2, r0, #1

continue:
	add r2, #1
	ldrb r1, [r2]

	cmp r1, #0
	beq end

	cmp r1, #0x3A @ ':'
	bne continue

	mov  r1, #0
	strb r1, [r2]

end:
	bx lr

	.pool
	.align

EALiterals:
	@ POIN SkillDescTable
