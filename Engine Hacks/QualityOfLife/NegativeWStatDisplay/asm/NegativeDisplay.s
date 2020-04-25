
	.thumb

	@ the old hack made hit (actually many things but hit was most noticeable) display as signed
	@ so this time, we only make it draw weapon stats as signed by hooking into the weapon stats drawing func

	@ Vanilla functions definitions

	Text_SetParams = 0x08003E68+1
	Text_DrawCharacter = 0x08004180+1

	GetItemMight = 0x080175DC+1
	GetItemHit = 0x080175F4+1
	GetItemWeight = 0x0801760C+1
	GetItemCrit = 0x08017624+1

	.global DrawHelpBoxWeaponStats_Hook
	.type   DrawHelpBoxWeaponStats_Hook, function

DrawHelpBoxWeaponStats_Hook:

	@ function is at 08089CD4, but we don't need to change all of it
	@ hook at 08089CFC (jumpToHack works), known state:
	@ - r4 is address of texts (there is 2 lines, r4+8 is the second one)
	@ - r5 is our item
	@ - everything else is whatever

	.macro draw_from_function function, x

		@ Defining macro because this is repeated 4 times

		ldr r3, =\function

		mov r0, r5 @ arg r0 = item

		bl call_via_r3

		@ Convert result to signed number
		lsl r0, r0, #24
		asr r3, r0, #24

		mov r0, r4 @ arg r0 = text
		mov r1, \x @ arg r1 = x
		mov r2, #7 @ arg r2 = color
		@ implied  @ arg r3 = number

		bl Text_InsertDrawSignedNumber

	.endm

	@ First line (there's already stuff drawn there from before we hooked)

	draw_from_function GetItemWeight, #129

	@ Second line
	add r4, #8

	draw_from_function GetItemMight, #32
	draw_from_function GetItemHit, #81
	draw_from_function GetItemCrit, #129

	@ epilogue

	pop {r4-r5}
	pop {r3}

call_via_r3:
	bx r3

	.pool

	.global Text_InsertDrawSignedNumber
	.type   Text_InsertDrawSignedNumber, function

Text_InsertDrawSignedNumber:
	@ this is our new function that replaces Text_InsertDrawNumberOrBlank

	@ arg r0 = text
	@ arg r1 = x
	@ arg r2 = color
	@ arg r3 = signed number

	push {r0, r4-r6, lr} @ pushing r0 is to make 4byte space on the stack

	mov r4, r0 @ var r4 = text
	mov r5, r3 @ var r5 = number

	ldr r3, =Text_SetParams

	@ implied @ arg r1 = cursor
	@ implied @ arg r2 = color

	bl call_via_r3

	cmp r5, #0
	beq Text_InsertDrawSignedNumber.draw_zero

	@ r6 = 1 if number is negative, r5 = abs(number)
	@ it's surprise tools that will help us later

	lsr r6, r5, #31
	beq Text_InsertDrawSignedNumber.lop

	neg r5, r5

Text_InsertDrawSignedNumber.lop:
	mov r0, r5  @ arg r0 = num
	mov r1, #10 @ arg r1 = denom

	swi 6 @ div!

	@ r0 = number / 10
	@ r1 = number % 10

	mov r5, r0 @ number = number / 10

	add r1, #0x30
	str r1, [sp] @ [sp] = ['0' + number % 10, 0, 0, 0]

	ldr r3, =Text_DrawCharacter

	mov r0, r4 @ arg r0 = text
	mov r1, sp @ arg r1 = string

	bl call_via_r3

	ldrb r0, [r4, #2]
	sub  r0, #15
	strb r0, [r4, #2]

	cmp r5, #0
	bne Text_InsertDrawSignedNumber.lop

	@ Draw dash if number was negative

	cmp r6, #0
	beq Text_InsertDrawSignedNumber.end

	ldrb r0, [r4, #2]
	add  r0, #3
	strb r0, [r4, #2]

	mov r0, #0x2D
	str r0, [sp] @ [sp] = ['-', 0, 0, 0]

	ldr r3, =Text_DrawCharacter

	mov r0, r4 @ arg r0 = text
	mov r1, sp @ arg r1 = string

	bl call_via_r3

Text_InsertDrawSignedNumber.end:
	pop {r0, r4-r6}

	pop {r0}
	bx r0

Text_InsertDrawSignedNumber.draw_zero:
	ldr r3, =Text_DrawCharacter

	mov r0, r4      @ arg r0 = text
	adr r1, strZero @ arg r1 = string

	bl call_via_r3

	b Text_InsertDrawSignedNumber.end

	.pool

strZero:
	.asciz "0"
