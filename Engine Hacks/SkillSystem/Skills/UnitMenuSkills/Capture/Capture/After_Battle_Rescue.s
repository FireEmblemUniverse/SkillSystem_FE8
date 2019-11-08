.thumb
.org 0x0

@bl'd to from 328F0
@r4=defender, r6=attacker battle structs
@r7 should contain char data ptr of person dropping item, 0 if capturing; r5 has char data of receiver

@r7 only contains char data IF they die AND you are not capturing.

	push	{r14}

	ldrb	r0, [r6, #0xB]		@ arg r0 = acting unit id

	ldr		r3, Get_Unit_Data
	mov		r14,r3
	.short	0xF800

	mov r5, r0 @ r5 = acting unit

	ldr		r0, Is_Capture_Set
	mov		r14, r0
	mov		r0, r5
	.short	0xF800

	cmp		r0, #0
	beq		NotCapture

@if capturing:


	ldr     r0,[r5, #0xC]
	mov		r1,#0x80
	lsl		r1,#0x17
	mvn		r1,r1
	and		r0,r1
	str		r0,[r5,#0xC]		@remove the 'is capturing' bit from attacker

	ldrb	r0,[r4,#0x13]		@is defender dead?
	cmp		r0,#0x0
	bne End

	@if defender dead and capturing:

	ldrb	r7,[r4,#0xB]		@defender allegiance
	ldr		r0,Get_Unit_Data
	mov		r14,r0
	mov		r0,r7
	.short	0xF800
	mov r7, r0

	ldr		r0,Write_Rescue_Data
	mov		r14,r0
	mov		r0,r5
	mov		r1,r7
	.short	0xF800
	
	mov		r7,#0x0				@captured units don't drop anything
	b End

NotCapture:
	@ if not capturing, check if dead and drop item flag set

	@ reminder:
	@ r6 = acting battle unit; r4 = target battle unit

	mov  r0, #0x13
	ldsb r0, [r6, r0]

	cmp  r0, #0 @ is *acting unit* dead?
	bne  CheckTargetDeadItemDrop

	ldrb r0, [r6, #0xB]

	ldr  r3, Get_Unit_Data
	mov  lr, r3
	.short 0xF800

	mov r7, r0 @ r7 = acting unit (dead unit)

	ldrb r0, [r4, #0xB]

	ldr  r3, Get_Unit_Data
	mov  lr, r3
	.short 0xF800

	mov r5, r0 @ r5 = target unit (unit receiving item)

CheckTargetDeadItemDrop:
	mov  r0, #0x13
	ldsb r0, [r4, r0]

	cmp  r0, #0 @ is *target unit* dead?
	bne  End

	ldrb r0, [r6, #0xB]

	ldr  r3, Get_Unit_Data
	mov  lr, r3
	.short 0xF800

	mov r5, r0 @ r7 = acting unit (unit receiving item)

	ldrb r0, [r4, #0xB]

	ldr  r3, Get_Unit_Data
	mov  lr, r3
	.short 0xF800

	mov r7, r0 @ r5 = target unit (dead unit)

End:
	@ We shouldn't need to check if the dead unit has the drop item flag
	@ the vanilla functions should do it for us at 0803292C (we resume at 08032928).

	pop		{r3}
	bx		r3

.align
Get_Unit_Data:
.long 0x08019430 @ GetUnit
Write_Rescue_Data:
.long 0x0801834C @ UnitRescue
Is_Capture_Set:
@


