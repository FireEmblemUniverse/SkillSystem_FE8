.thumb
.align

push {r14}

ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, EscapeEvent	@the text part
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

@see if we're rescuing anyone
	ldr r0,=#0x3004E50 @active unit
	ldr r0,[r0]
	ldrb r0,[r0,#0x1B]
	cmp r0,#0
	beq EndMap @if this byte is empty, we're not rescuing anyone; we don't need to check if we're rescuing or being rescued because rescuees can't use the unit menu

	@if we are, get who we are
	ldr r1,=#0x08019431 @GetUnit
	mov r14,r1
	.short 0xF800
	mov r3,r0
	
	@set their stuff too
	ldr	r1,[r3,#0xC]
	mov	r2,#1
	orr	r1,r2
	mov r2,#0x8
	orr r1,r2
	str	r1,[r3,#0xC]


EndMap:
@trigger end of map
ldr r0,=#0x8023021 @Seize command effect
mov r14,r0
.short 0xF800


GoBack:
pop {r0}
bx r0

.ltorg
.align
EscapeEvent:
