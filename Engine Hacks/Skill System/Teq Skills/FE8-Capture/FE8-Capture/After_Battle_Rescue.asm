.thumb
.org 0x0

@bl'd to from 328F0
@r4=defender, r6=attacker battle structs
@r7 should contain char data ptr of person dropping item, 0 if capturing; r5 has char data of receiver

@r7 only contains char data IF they die AND you are not capturing.

push	{r14}

ldrb	r5,[r6,#0xB]		@attacker allegiance
ldr		r0,Get_Char_Data
mov		r14,r0
mov		r0,r5
.short	0xF800
mov r5, r0

ldr		r0,Is_Capture_Set
mov		r14,r0
mov		r0,r5
.short	0xF800
cmp		r0,#0x0
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
	bne GoBack

	@if defender dead and capturing:

	ldrb	r7,[r4,#0xB]		@defender allegiance
	ldr		r0,Get_Char_Data
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
	b GoBack

NotCapture:
	@if not capturing, check if dead and drop item flag set
	ldrb	r0,[r4,#0x13]		@is defender dead?
	cmp		r0,#0x0
	bne GoBack

	ldrb	r7,[r4,#0xB]		@defender allegiance
	ldr		r0,Get_Char_Data
	mov		r14,r0
	mov		r0,r7
	.short	0xF800
	mov r7, r0

	ldr r0, [r7, #0xC]
	lsr r0, #8
	mov r1, #0x10
	and r0, r1
	cmp r0, #0
	bne GoBack @if drop item byte set, leave data in r7
	mov r7, #0

GoBack:
pop		{r0}
bx		r0

.align
Get_Char_Data:
.long 0x08019430
Write_Rescue_Data:
.long 0x0801834C
Is_Capture_Set:
@


