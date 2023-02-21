.thumb
.include "Definitions.h.s"

.set prUnitPushAnim_New,         EALiterals+0x00
.set prPushAnim_BeginTargetPush, EALiterals+0x04

PushAction:
	push {r4-r5, lr}
	
	ldr r4, =pActionStruct
	
	@ STEP 1: SETTING UP THE ANIMATIONS
	@ ---------------------------------
	
	@ Delete all current MOVEUNITs
	_blh prMOVEUNIT_DeleteAll
	
	ldr r0, =ppActiveUnit
	ldr r5, [r0]
	
	@ Prepare call of GetFacingDirectionId
	ldr r3, =prGetFacingDirectionId
	mov lr, r3

	@ From: Current Unit Position
	ldrb r0, [r5, #0x10]
	ldrb r1, [r5, #0x11]
	
	@ To: Target Position
	ldrb r2, [r4, #0x13]
	ldrb r3, [r4, #0x14]
	
	@ Call
	.short 0xF800
	
	ldrb r2, [r4, #0x13]
	ldrb r3, [r4, #0x14]
	
	@ _MakePair r2, r2, r3, r3
	lsl r3, #0x10
	orr r2, r3
	
	mov r1, r0 @ r1 = Facing Direction
	mov r0, r5 @ r5 = Target Unit Struct
	
	ldr r3, prUnitPushAnim_New
	_blr r3
	
	@ Decrement Sleep If Applicable
	mov r0, r4
	add r0, #0x0D @ Target unit
	ldrb r0, [r0]
	
	ldr r3, =prUnit_GetStruct
	_blr r3
	
	mov r3, r0
	add r3, #0x30
	ldrb r0, [r3] @ Status
	mov r1, #0xF 
	and r1, r0 @isolate status ID
	cmp r1, #2 @Sleep
	bne SkipDecrement
	lsr r1, r0, #4 @isolate status duration
	sub r1, #1 @subtract 1
	cmp r1, #0
	bne SkipClearStatus
	mov r0, #0
	SkipClearStatus:
	lsl r1, #4
	mov r2, #0xF
	and r0, r2
	orr r0, r1
	strb r0, [r3]
	
	SkipDecrement:
	@ Setting future call to animate push
	
	ldr r0, prPushAnim_BeginTargetPush
	mov r1, #0
	mov r2, #4
	_blh prCall_Future
	
	_blh prIDunnoReallyButIThinkItUpdatesStandingSprites
	
	@ Yield (6C), because if we don't the newly created MOVEUNITs will be deleted before the thread lock comes into play
	mov r0, #0
	
TestSkip:
	pop {r4-r5}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prUnitMoveAnim_New
	@ POIN prPushAnim_BeginTargetPush
