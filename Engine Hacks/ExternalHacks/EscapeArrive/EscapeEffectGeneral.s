.thumb
.align 4

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

push {r14}


ldr r0, =#0x03004E50 @ Location of current character's struct
ldr r0, [ r0 ] @ Pointer to character struct in r0
mov r1, r0
add r1, #0x10
add r0, r1, #0x01
ldrb r1, [ r1 ] @ X coordinate in r1
ldrb r2, [ r0 ] @ Y coordinate in r2

ldr r0, =#0x0202BCF0
add r0, #0x0E
ldrb r0, [ r0 ] @ Chapter ID in r0

push { r1 }
blh 0x080346B0, r3 @ Pointer to event pointer table in r0
pop { r1 }
ldr r0, [ r0, #0x08 ] @ Now THIS is pointer to LOCAs

mov r3, #0x00 @ Treat r3 as a loop index
LoopStart:
 mov r4, r0 @ Start pointer to location events in r4
 mov r6, #0x0C
 mul r6, r3
 add r4, r6 @ Now I'm at the nth LOCA
 ldrb r6, [ r4, #0x08 ] @ X coord in r6
 cmp r6, r1
 bne LoopFalse
	ldrb r6, [ r4, #0x09 ] @ Y coord in r6
	cmp r6, r2
	bne LoopFalse
		ldrb r6, [ r4, #0x0A ] @ Command ID
		cmp r6, #0x13
		bne LoopFalse
		@ Therefore r4 has the correct LOCA
		
		ldrb r0,[r4,#0x7]
		cmp r0,#0
		beq SkipRunningEvent
	
@ LoopTrue:
ldrb r0, [ r4, #0x02 ]
blh 0x08083D80, r1 @ Sets new event ID
ldr r0, [ r4, #0x04 ] @ Now r0 does
mov r1, #0x00
blh 0x0800D07C, r2
b SkipRunningEvent

LoopFalse:
add r3, #0x01
b LoopStart


SkipRunningEvent:


ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, EscapeEvent	@the text part
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

@grab action struct 
ldr r0,=#0x203A958

@set X coord in action struct (+0x0E)
@mov r1,#0xFF
@strb r1,[r0,#0xE]

@set last used command to Wait
mov r1,#1
strb r1,[r0,#0x11]

@set flag to denote escape should be triggered
ldr r0,=#0x2040000
ldrb r1,[r0]
mov r2,#0x4
orr r1,r2
strb r1,[r0]

	@see if we're rescuing anyone
	ldr r0,=#0x3004E50 @active unit
	ldr r0,[r0]
	ldrb r0,[r0,#0x1B]
	cmp r0,#0
	beq End @if this byte is empty, we're not rescuing anyone; we don't need to check if we're rescuing or being rescued because rescuees can't use the unit menu

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
	
	@check the lord bit on our rescuee to see if we should trigger the end of the map via their escape
	ldr r0,[r3]
	ldr r0,[r0,#0x28]
	ldr r1,[r3,#4]
	ldr r1,[r1,#0x28]
	orr r0,r1
	@check against bit 0x00002000
	mov r1,#0x20
	lsl r1,r1,#8
	and r0,r1
	cmp r0,#0
	beq End
	
	@trigger end of map
	ldr r0,=#0x8023021 @Seize command effect
	mov r14,r0
	.short 0xF800

End:
pop {r0}
bx r0

.ltorg
.align 4
EscapeEvent:



@praise uhh whoever wrote despoil
