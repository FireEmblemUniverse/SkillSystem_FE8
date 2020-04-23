.thumb
.align


.global ArriveCommandUsability
.type ArriveCommandUsability, %function

.global ArriveCommandEffect
.type ArriveCommandEffect, %function

.global EscapeCommandUsability
.type EscapeCommandUsability, %function

.global EscapeCommandEffect
.type EscapeCommandEffect, %function


.equ CheckEventId,0x8083da8
.equ GetDeployedPlayerUnitCount,0x8018ff1


ArriveCommandUsability:
push {r4,r14}

@Check for Cantoing
ldr r4,=0x03004E50 							@active unit ptr
ldr r2,[r4] 								@unit struct ptr
ldr r0,[r2,#0x0C]							@unit status bitfield
mov r1,#0x40								@cantoing bit
and r0,r1									@check for bit
cmp r0,#0									@if 0, bit is not set
bne ArriveCommandUsability_ReturnFalse		@if set, return false

@Check for being on arrive point
ldr r1,[r4]									@unit struct ptr
ldrb r0,[r1,#0x10]							@load X coord
ldrb r1,[r1,#0x11]							@load Y coord
ldr r3,=#0x8084078							@function that gets the ID of the thing we're on
mov r14,r3									@
.short 0xF800								@blh
mov r1,#0x03								@
cmp r0,#0x19								@if ID = 0x19, it's an arrive point
bne ArriveCommandUsability_ReturnFalse		@otherwise, return false

mov r0,#1									@return true		
b ArriveCommandUsability_GoBack				@jump to go back

ArriveCommandUsability_ReturnFalse:			
mov r0,#3									@return false

ArriveCommandUsability_GoBack:
pop {r4}									@
pop {r1}									@
bx r1										@

.ltorg
.align



ArriveCommandEffect:
push {r4,r14}
ldr r4,=#0x8023021 	@seize command effect
mov r14,r4			@
.short 0xF800		@blh
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r4}			@
pop {r1}			@
bx r1				@

.ltorg
.align



EscapeCommandUsability:
push {r4,r14}

@Check for Cantoing
ldr r4,=0x03004E50
ldr r2,[r4]
ldr r0,[r2,#0x0C]
mov r1,#0x40
and r0,r1
cmp r0,#0
bne EscapeCommandUsability_ReturnFalse


@Check for being on escape point
ldr r1,[r4]
mov r0,#0x10
ldsb r0,[r1,r0]
ldrb r1,[r1,#0x11]
lsl r1,r1,#0x18
asr r1,r1,#0x18
ldr r3,=#0x8084078
mov r14,r3
.short 0xF800
mov r1,#0x03
cmp r0,#0x13
bne EscapeCommandUsability_ReturnFalse

@Check for being lord
ldr r0,[r4]
ldr r0,[r0]
ldr r0,[r0,#40]
lsl r0,r0,#16
lsr r0,r0,#24
mov r1,#0x20
and r0,r1
cmp r0,#0x20
beq EscapeCommandUsability_IsALord

@Check for rescuee who is a lord
ldr r0,[r4]
ldrb r0,[r0,#0x1B]
cmp r0,#0
beq EscapeCommandUsability_ReturnTrue

@are they lord
ldr r1,=#0x08019431 @GetUnit
mov r14,r1
.short 0xF800
mov r3,r0

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
bne EscapeCommandUsability_IsALord



EscapeCommandUsability_ReturnTrue:
mov r0,#1
b EscapeCommandUsability_GoBack

EscapeCommandUsability_IsALord:
@we're a lord, so check if the flag is set that will make us have to return the "gray out this menu option" thing
ldr r0,=LordMustEscapeLastFlagLink
ldrh r0,[r0]
ldr r1,=CheckEventId
mov r14,r1
.short 0xF800
cmp r0,#0
bne EscapeCommandUsability_CheckTheFlag
mov r0,#1
b EscapeCommandUsability_GoBack

EscapeCommandUsability_CheckTheFlag:
ldr r0,=GetDeployedPlayerUnitCount
mov r14,r0
.short 0xF800
cmp r0,#1
beq EscapeCommandUsability_GoBack
mov r0,#1
b EscapeCommandUsability_DoTheGrayThing


EscapeCommandUsability_DoTheGrayThing:
@return 2
mov r0,#2
b EscapeCommandUsability_GoBack

EscapeCommandUsability_ReturnFalse:
mov r0,#3

EscapeCommandUsability_GoBack:
pop {r4}
pop {r1}
bx r1


.ltorg
.align






EscapeCommandEffect:
push {r4-r7,r14}


mov r5,r0


@check if we're lord and we can't go not-last
@check for lord last flag
ldr r0,=LordMustEscapeLastFlagLink
ldrh r0,[r0]
ldr r1,=CheckEventId
mov r14,r1
.short 0xF800
cmp r0,#0
beq EscapeCommandEffect_ActualEscapeEffect

@check that there are more than 1 units deployed
ldr r0,=GetDeployedPlayerUnitCount
mov r14,r0
.short 0xF800
cmp r0,#1
beq EscapeCommandEffect_ActualEscapeEffect

@Check for being lord
ldr r4,=#0x3004E50
ldr r0,[r4]
ldr r0,[r0]
ldr r0,[r0,#40]
lsl r0,r0,#16
lsr r0,r0,#24
mov r1,#0x20
and r0,r1
cmp r0,#0x20
beq EscapeCommandEffect_SayNO

ldr r0,[r4]
ldrb r0,[r0,#0x1B]
cmp r0,#0
beq EscapeCommandEffect_ActualEscapeEffect

@are they lord
ldr r1,=#0x08019431 @GetUnit
mov r14,r1
.short 0xF800
mov r3,r0

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
beq EscapeCommandEffect_ActualEscapeEffect

@say NO to lords escaping first!

EscapeCommandEffect_SayNO:

ldr r1, =LordMustEscapeLastTextIDLink
ldrh r1, [r1]
mov r0, r5
ldr r2,=#0x0804F580 @ Sets that text ID for the error text
mov r14,r2
.short 0xF800
mov r0, #0x08
b RealGoBack

.ltorg
.align

EscapeCommandEffect_ActualEscapeEffect:

@ldr r0, =#0x03004E50 @ Location of current character's struct
@ldr r0, [ r0 ] @ Pointer to character struct in r0
@mov r1, r0
@add r1, #0x10
@add r0, r1, #0x01
@ldrb r1, [ r1 ] @ X coordinate in r1
@ldrb r2, [ r0 ] @ Y coordinate in r2

@ldr r0, =#0x0202BCF0
@add r0, #0x0E
@ldrb r0, [ r0 ] @ Chapter ID in r0

@push { r1 }
@ldr r3,=#0x080346B0 @ Pointer to event pointer table in r0
@mov r14,r3
@.short 0xF800
@pop { r1 }
@ldr r0, [ r0, #0x08 ] @ Now THIS is pointer to LOCAs

@mov r3, #0x00 @ Treat r3 as a loop index
@LoopStart:
@ mov r4, r0 @ Start pointer to location events in r4
@ mov r6, #0x0C
@ mul r6, r3
@ add r4, r6 @ Now I'm at the nth LOCA
@ ldrb r6, [ r4, #0x08 ] @ X coord in r6
@ cmp r6, r1
@ bne LoopFalse
@	ldrb r6, [ r4, #0x09 ] @ Y coord in r6
@	cmp r6, r2
@	bne LoopFalse
@		ldrb r6, [ r4, #0x0A ] @ Command ID
@		cmp r6, #0x13
@		bne LoopFalse
@		@ Therefore r4 has the correct LOCA
		
@		ldrb r0,[r4,#0x7]
@		cmp r0,#0
@		beq SkipRunningEvent
	
@ LoopTrue:
@ldrb r0, [ r4, #0x02 ]
@ldr r1,=#0x08083D80 @ Sets new event ID
@mov r14,r1
@.short 0xF800
@ldr r0, [ r4, #0x04 ] @ Now r0 does
@mov r1, #0x01
@ldr r2,=#0x0800D07C
@mov r14,r2
@.short 0xF800

@b SkipRunningEvent

@LoopFalse:
@add r3, #0x01
@b LoopStart


SkipRunningEvent:

ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, =EscapeEvent	@the text part
mov	r1, #0x01			@0x01 = wait for events
.short	0xF800

@grab action struct 
ldr r0,=#0x203A958

@set last used command to Wait
mov r1,#1
strb r1,[r0,#0x11]

@set flag to denote escape should be triggered
ldr r0,=#0x2040000
ldrb r1,[r0]
mov r2,#0x4
orr r1,r2
strb r1,[r0]

ldr r3,=#0x3004E50
ldr r3,[r3]

ldr	r1,[r3,#0xC]
mov	r2,#1
orr	r1,r2
mov r2,#0x8
orr r1,r2
str	r1,[r3,#0xC]

@see if we're rescuing anyone
	ldr r0,=#0x3004E50 @active unit
	ldr r0,[r0]
	ldrb r0,[r0,#0x1B]
	cmp r0,#0
	beq NonRescueeEndingChecks @if this byte is empty, we're not rescuing anyone; we don't need to check if we're rescuing or being rescued because rescuees can't use the unit menu

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
	
	@see if we're rescuing anyone
	ldr r0,=#0x3004E50 @active unit
	ldr r0,[r0]
	ldrb r0,[r0,#0x1B]
	cmp r0,#0
	beq NonRescueeEndingChecks @if this byte is empty, we're not rescuing anyone; we don't need to check if we're rescuing or being rescued because rescuees can't use the unit menu

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
	beq NonRescueeEndingChecks
	
	@see if we should end the map
	ldr r0,=AllUnitsMustEscapeFlagLink
	ldrh r0,[r0]
	ldr r1,=CheckEventId
	mov r14,r1
	.short 0xF800
	cmp r0,#0
	beq NonRescueeEndingChecks
	
	@check if we're the last 2 units
	ldr r0,=GetDeployedPlayerUnitCount
	mov r14,r0
	.short 0xF800
	cmp r0,#0
	beq EndMap
	b GoBack

.ltorg
.align

NonRescueeEndingChecks:
	@see if we should end the map
	ldr r0,=AllUnitsMustEscapeFlagLink
	ldrh r0,[r0]
	ldr r1,=CheckEventId
	mov r14,r1
	.short 0xF800
	cmp r0,#0
	beq NonRescueeLordCheck
	
	@how many units?
	ldr r0,=GetDeployedPlayerUnitCount
	mov r14,r0
	.short 0xF800
	cmp r0,#0
	beq EndMap
	b GoBack

NonRescueeLordCheck:
@are we a lord?
ldr r0,=#0x3004E50 @active unit
ldr r0,[r0]
ldr r0,[r0]
ldr r0,[r0,#0x28]
ldr r1,=#0x3004E50 @active unit
ldr r1,[r1]
ldr r1,[r1,#4]
ldr r1,[r1,#0x28]
orr r0,r1

@check against bit 0x00002000
mov r1,#0x20
lsl r1,r1,#8
and r0,r1
cmp r0,#0
beq GoBack

EndMap:
@trigger end of map
ldr r0,=#0x8023021 @Seize command effect
mov r14,r0
.short 0xF800
mov r0,#0x94
b RealGoBack

GoBack:

ldr r0,=GetDeployedPlayerUnitCount
mov r14,r0
.short 0xF800
cmp r0,#0
beq EndMap
mov r0,#0x94

RealGoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align
