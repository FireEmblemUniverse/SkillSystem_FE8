.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CheckEventId,0x8083da8
	.equ SetEventId, 0x8083d80 
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ BattleActor, 0x203A4EC 
	.equ EventEngine, 0x800D07C
	.equ EnsureCameraOntoPosition,0x08015e0d
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430

	.global RefreshActiveUnit
	.type   RefreshActiveUnit, function

@ 800CEF5 -> 800DC99 
@ 800DB2F
@ TeleportActiveUnit2 


@ PlayerPhase_InitUnitMovementSelect at 801CC1C 
@ 1CC2C as NOP'd out makes the range display not appear 

@ 
@ ORG 0x801CC20 
@ callHackr0(DecideToHideActiveUnitRangeDisplay) 

.equ DisplayActiveUnitEffectRange, 0x0801cc7c 

.equ MuCtr_CreateWithReda,0x800FEF5 @r0 = char struct, target x coord, target y coord
.align 4 
	.global FastMoveUnit
	.type   FastMoveUnit, function
FastMoveUnit:
	push {r4-r7, lr} 

@ 10850 CheckCursor 
mov r7, r0 

mov r0, #0xAC @ Flag used 
blh CheckEventId 
cmp r0, #0 
beq End

ldr r3, =0x202BCB0 @ BattleMapState -> 
ldrh r0, [r3, #0x14] @ gCursorMapPosition XX 
ldrh r1, [r3, #0x16] @ gCursorMapPosition YY 

mov r4, r0 @ XX 
mov r5, r1 @ YY 

ldr r3, =CurrentUnit
ldr r3, [r3] 
cmp r3, #0 
beq End
mov r6, r3 

@ Store new coordinate 
strb r4, [r6, #0x10] @ XX
strb r5, [r6, #0x11] @ YY

@ This is to update your cursor when you move an enemy / npc 
@ the called event runs SET_CURSOR_SB 
@ when SET_ACTIVE 0 is used, it moves the cursor to the main unit 
ldr r3, =MemorySlot
strh r4, [r3, #4*0x0B+0] @ XX
strh r5, [r3, #4*0x0B+2] @ YY 



@ldr r0, =SetNoActiveUnitEvent
@mov r1, #1 @ Wait for events 
@blh EventEngine 

@b End


@ Stuff below here might be useful if you want to not use SET_ACTIVE 
@ 

@ Remove the blue arrow 
ldr r3, =#0x203A990  @ gMovementArrowData
mov r0, #0 
ldr r2, =#0x203AA04 @ gAiData 
ClearMovementArrowDataLoop:
cmp r3, r2 
bge BreakLoop 
str r0, [r3] 
add r3, #4 
b ClearMovementArrowDataLoop
BreakLoop: 

blh 0x80790a4 @MU_EndAll @ Removes the active unit's MMS
blh 0x801d6fc @PlayerPhase_ReloadGameGfx @ Removes range/attack map




@ This is to update your cursor when you press B 
@ 202BE48
ldr r3, =0x202BE48 
strh r4, [r3] @ XX 
strh r5, [r3, #2] @ YY 

@ Reset action taken I think 
@ldr  r0,=#0x0203A954      @gActionData      {J}
ldr  r3,=#0x0203a958      @gActionData      {U}
strb r4, [r3, #0xe]       @gActionData.X
strb r5, [r3, #0xf]       @gActionData.Y
mov	r0, #0x00
strb	r0, [r3,#0x10]	@clear steps taken this turn



ldr r3, =MemorySlot
str r6, [r3, #4*0x01] @ s1 as unit ram *pointer*
mov r0, #4*0x0B+0
strb r4, [r3, r0] @ sB as Target XX 
mov r0, #4*0x0B+2
strb r5, [r3, r0] @ sB as Target YY 


ldr r0, =ASMC_MuCtr_CreateWithReda_Event
mov r1, #1 @ Wait for events 
blh EventEngine 

@@ From Sme's FreeMovement Hack 
@@ I guess this allocates space 
@sub sp,#0x1C
@mov r0,#0
@str r0,[sp]
@str r0,[sp,#0x4]
@str r0,[sp,#0x8]
@str r0,[sp,#0xC]
@str r0,[sp,#0x10]
@str r0,[sp,#0x14]
@str r0,[sp,#0x18]
@str r0,[sp,#0x1C]
@@ And these are the parameters 
@mov r0,r6 @ Unit 
@mov r1,r4 @ Target XX 
@mov r2,r5 @ Target YY 
@mov r3,#0 @redundant some of the time but not always
@@ Note that walking through impassible terrain will crash the game with this sometimes 
@@ That's why we already updated our coordinate to this location 
@@ This only updates the MMS sprite to be in the correct place. 
@@ I don't know a different way to do that. 
@blh MuCtr_CreateWithReda
@add sp,#0x1C

@make the camera follow your movement
mov r0,#0
mov r1,r4
mov r2,r5
blh EnsureCameraOntoPosition


bl RunMiscBasedEvents

blh 0x8027A40 @ Reset map sprite hover timer ? 


blh  0x0801a1f4   @RefreshFogAndUnitMaps 
blh  0x080271a0   @SMS_UpdateFromGameData
@blh  0x08019c3c   @UpdateGameTilesGraphics

@ldr r0, =SetNoActiveUnitEvent
@mov r1, #1 @ Wait for events 
@blh EventEngine 

b End

End:
mov r0, r7 

pop {r4-r7}
pop {r1}
bx r1



	.global ASMC_MuCtr_CreateWithReda
	.type   ASMC_MuCtr_CreateWithReda, function

ASMC_MuCtr_CreateWithReda:
push {lr}



@ From Sme's FreeMovement Hack 
@ I guess this allocates space 
sub sp,#0x1C
mov r0,#0
str r0,[sp]
str r0,[sp,#0x4]
str r0,[sp,#0x8]
str r0,[sp,#0xC]
str r0,[sp,#0x10]
str r0,[sp,#0x14]
str r0,[sp,#0x18]
str r0,[sp,#0x1C]
@ And these are the parameters 
ldr r3, =MemorySlot

mov r0, #4*0x0B+0
ldrb r1, [r3, r0] @ sB as Target XX 
mov r0, #4*0x0B+2
ldrb r2, [r3, r0] @ sB as Target YY 
ldr r0, [r3, #4*0x01] @ s1 as unit ram *pointer*
mov r3,#0 @redundant some of the time but not always
@ Note that walking through impassible terrain will crash the game with this sometimes 
@ That's why we already updated our coordinate to this location 
@ This only updates the MMS sprite to be in the correct place. 
@ I don't know a different way to do that. 
blh MuCtr_CreateWithReda
add sp,#0x1C

pop {r0} 
bx r0 






.equ UnsetEventId, 0x8083d94

.equ gChapterData,0x0202bcf0
.equ GetChapterEventDataPointer,0x080346b1
.equ CheckEventDefinition,0x08082ec5
.equ ClearActiveEventRegistry,0x080845a5
.equ CallEventDefinition,0x08082e81
.equ CheckNextEventDefinition,0x08082f29
.equ RunLocationEvents,0x080840C5


RunMiscBasedEvents:
push {r4-r5,r14}
sub sp,#0x1C
mov r4,r0
mov r5,r1
ldr r0,=gChapterData
ldrb r0,[r0,#0xE]
blh GetChapterEventDataPointer
ldr r0,[r0,#0xC]
str r0,[sp]
mov r1,sp
strb r4,[r1,#0x18]
strb r5,[r1,#0x19]
mov r0,r13
blh CheckEventDefinition
cmp r0,#0
beq ExitMiscBasedLoop
blh ClearActiveEventRegistry
EventCallLoop:
mov r0,r13
mov r1,#1
blh CallEventDefinition
mov r0,r13
blh CheckNextEventDefinition
cmp r0,#0
bne EventCallLoop

ExitMiscBasedLoop:
add sp,#0x1C

pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align


