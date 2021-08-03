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

RefreshActiveUnit:
push {lr} 
@mov r0, #0x86 @ Refresh Active Unit Flag 
@blh CheckEventId 
@cmp r0, #0 
@beq End 

ldr r2, =MemorySlot
ldr r2, [r2, #4*0x0C] @ Cursor position from CHECK_CURSOR 
@mov r11, r11 
lsr r1, r2, #16 @ YY 
lsl r0, r2, #24 
lsr r0, r0, #24 @ XX 

ldr r3, =CurrentUnit
ldr r3, [r3] 
strb r0, [r3, #0x10] @ XX
strb r1, [r3, #0x11] @ YY


ldr	r2,=#0x203A958
mov	r0, #0x00
strb	r0, [r2,#0x10]	@clear steps taken this turn

@unset 0x2 and 0x40, set 0x400, write to status
ldr	r0, [r3,#0x0C]	@status bitfield
mov	r1, #0x42
mvn	r1, r1
and	r0, r1		@unset bits 0x42
mov	r1, #0x04
lsl	r1, #0x08
orr	r0, r1
str	r0, [r3,#0x0C]

blh  0x0801a1f4   @RefreshFogAndUnitMaps 
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics
blh 0x80790a4 @MU_EndAll
End:
pop	{r0}
bx	r0







@ 800CEF5 -> 800DC99 
@ 800DB2F
@ TeleportActiveUnit2 


@ PlayerPhase_InitUnitMovementSelect at 801CC1C 
@ 1CC2C as NOP'd out makes the range display not appear 

@ 
@ ORG 0x801CC20 
@ callHackr0(DecideToHideActiveUnitRangeDisplay) 

.equ DisplayActiveUnitEffectRange, 0x0801cc7c 

.align 4 
	.global DecideToHideActiveUnitRangeDisplay
	.type   DecideToHideActiveUnitRangeDisplay, function

DecideToHideActiveUnitRangeDisplay:
push {lr} 
ldrb r1, [r5, #4] @ Copied vanilla code 
mov r0, #2 
orr r0, r1 
strb r0, [r5, #4] 
ldr r4, =CurrentUnit @ Copied vanilla code

mov r0, #0xAA @ Flag used 
blh CheckEventId 
cmp r0, #0 
bne SkipDisplayingRange

ldr r0, [r4] @ Copied vanilla code
blh DisplayActiveUnitEffectRange
SkipDisplayingRange:


pop {r3}
bx r3 


.align 4

	.global InsertEventOnTileSelect
	.type   InsertEventOnTileSelect, function
InsertEventOnTileSelect:

push {lr} 
lsl r0, r5, #3 
add r0, r7 
ldr r1, [r0] 
mov r0, r4  
bl BXR1 

@ 3007D98
@ 844e1
ldr r3, =0x3007D98 
cmp r4, r3 
bne SkipTeleportActiveUnit 

blh TeleportActiveUnit2
@mov r11, r11

SkipTeleportActiveUnit:
cmp r0, #1 

pop {r1}
BXR1:
bx r1 


@ to 844e1 with r0 as 0 so it will try to execute 



@ Hook in CheckEventDefinitions at 8082EC4 

@ Break at 8082EF2 - r2 is 3 ? 
@ r0 is 3007D98 ? 


@ in PlayerPhase_RangeDisplayIdle at 801CD1C 
@ hook somewhere in here? 

@ 80033D1 @ bxr1 
@ 8002CCD proc interrupt script 
@ 800D0C3 @ ProcStart 
@ 800D0A9 @ StartMapEventEngine 
@ 8015B71 @ obj insert safe 

@ 8083DB9 as lr 
@ 8082EF7 as lr 


@ 8083831 




@ EvCheck01_AFEV at 8083834 
@ This happens when a target coord is selected but only if there's a valid event in Dunno2 

//ORG 0x83834 
//jumpToHack_r1(EvCheck01_AFEV) 

.align 4

	.global EvCheck01_AFEV
	.type   EvCheck01_AFEV, function
EvCheck01_AFEV: 
push {r4-r5, lr} 
mov r5, r0 
ldr r4, [r5] 

mov r11, r11
blh TeleportActiveUnit2



ldr r0, [r4, #0x8] 
cmp r0, #0 
beq SkipCheckEventId 
cmp r0, #0x64 
beq SkipCheckEventId 
blh CheckEventId 
lsl r0, #24 
lsr r0, #24 
cmp r0, #1 
bne False
SkipCheckEventId:
ldr r0, [r4, #4] 
str r0, [r5, #4] 
ldrh r0, [r4, #2] 
str r0, [r5, #8] 
mov r0, #1 
b Exit 
False:
mov r0, #0 
Exit: 
pop {r4-r5}
pop {r1}
bx r1 


.equ MuCtr_CreateWithReda,0x800FEF5 @r0 = char struct, target x coord, target y coord
.align 4 
	.global TeleportActiveUnit2
	.type   TeleportActiveUnit2, function
TeleportActiveUnit2:
	push {r4-r7, lr} 

@mov r11, r11
@ 10850 CheckCursor 
mov r7, r0 

mov r0, #0xAA @ Flag used 
blh CheckEventId 
cmp r0, #0 
bne End4 

ldr r3, =0x202BCB0 @ BattleMapState -> 
ldrh r0, [r3, #0x14] @ gCursorMapPosition XX 
ldrh r1, [r3, #0x16] @ gCursorMapPosition YY 

mov r4, r0 @ XX 
mov r5, r1 @ YY 

ldr r3, =CurrentUnit
ldr r3, [r3] 
cmp r3, #0 
beq End4 
mov r6, r3 

@ Store new coordinate 
strb r4, [r6, #0x10] @ XX
strb r5, [r6, #0x11] @ YY

@ This is to update your cursor when you move an enemy / npc 
@ the called event runs SET_CURSOR_SB 
@ when SET_ACTIVE 0 is used, it moves the cursor to the main unit 
ldr r3, =MemorySlot
strh r4, [r3, #4*0x0B+0]
strh r5, [r3, #4*0x0B+2]

ldr r0, =SetNoActiveUnitEvent
mov r1, #1 @ Wait for events 
blh EventEngine 

b End4

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
mov r0,r6 @ Unit 
mov r1,r4 @ Target XX 
mov r2,r5 @ Target YY 
mov r3,#0 @redundant some of the time but not always
@ Note that walking through impassible terrain will crash the game with this sometimes 
@ That's why we already updated our coordinate to this location 
@ This only updates the MMS sprite to be in the correct place. 
@ I don't know a different way to do that. 
blh MuCtr_CreateWithReda
add sp,#0x1C

@make the camera follow your movement
mov r0,#0
mov r1,r4
mov r2,r5
blh EnsureCameraOntoPosition

blh 0x8027A40 @ Reset map sprite hover timer ? 


blh  0x0801a1f4   @RefreshFogAndUnitMaps 
blh  0x080271a0   @SMS_UpdateFromGameData
@blh  0x08019c3c   @UpdateGameTilesGraphics

End4:
mov r0, r7 

pop {r4-r7}
pop {r1}
bx r1



.align 4
	.global TeleportActiveUnit
	.type   TeleportActiveUnit, function
TeleportActiveUnit:
push {r4-r7, lr} 
@mov r0, #0x86 @ Refresh Active Unit Flag 
@blh CheckEventId 
@cmp r0, #0 
@beq End2 


ldr r2, =MemorySlot
ldr r2, [r2, #4*0x0C] @ Cursor position from CHECK_CURSOR 
lsr r1, r2, #16 @ YY 
lsl r0, r2, #24 
lsr r0, r0, #24 @ XX 
mov r4, r0 @ XX 
mov r5, r1 @ YY 

ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r6, r3 
strb r0, [r3, #0x10] @ XX
strb r1, [r3, #0x11] @ YY



@ This is to update your cursor when you press B 
@ 202BE48
ldr r3, =0x202BE48 
strh r4, [r3] @ XX 
strh r5, [r3, #2] @ YY 

@ 
@ldr  r0,=#0x0203A954      @gActionData      {J}
ldr  r3,=#0x0203a958      @gActionData      {U}
strb r4, [r3, #0xe]       @gActionData.X
strb r5, [r3, #0xf]       @gActionData.Y
mov	r0, #0x00
strb	r0, [r3,#0x10]	@clear steps taken this turn

mov r0, r6 



ldr	r2,=#0x203A958
mov	r0, #0x00
strb	r0, [r2,#0x10]	@clear steps taken this turn

@unset 0x2 and 0x40, set 0x400, write to status
ldr	r0, [r3,#0x0C]	@status bitfield
mov	r1, #0x42
mvn	r1, r1
and	r0, r1		@unset bits 0x42
mov	r1, #0x04
lsl	r1, #0x08
orr	r0, r1
str	r0, [r3,#0x0C]


@ldr r3, =#0x203A990  @ gMovementArrowData
@mov r0, #0 
@ldr r2, =#0x203AA04 @ gAiData 
@ClearMovementArrowDataLoop:
@cmp r3, r2 
@bge BreakLoop 
@str r0, [r3] 
@add r3, #4 
@b ClearMovementArrowDataLoop
@BreakLoop: 


@blh 0x80792f8 @MU_DisplayAsSMS this did crazy screen scrolling stuff 

@ PROC_CALL_ROUTINE($8027A41) // reset map sprite hover timer
blh 0x8027A40 @ Reset map sprite hover timer ? 

@ blh 0x801da60 @DestructMoveLimitView @ Does nothing different ? idk 
@blh 0x80790a4 @MU_EndAll @ Removes the active unit's MMS
blh 0x080271a0 @SMS_UpdateFromGameData
 
@808948c Loop6C_8A00B20_UpdateOAMData
 

blh 0x801d6fc @PlayerPhase_ReloadGameGfx @ Removes range/attack map 

@blh 0x801dacc @HideMoveRangeGraphics @ Removes range/attack map 
@blh 0x8079190 @MU_AllRestartAnimations

@blh prClearRangeAndMoveMap @ From StanHax common 

blh 0x080311a8 @ReloadGameCoreGraphics

blh  0x0801a1f4   @RefreshFogAndUnitMaps 
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics
@blh 0x80790a4 @MU_EndAll
End2:
pop {r4-r7}
pop	{r0}
bx	r0

.align 4
	.global UsableTrueTest
	.type   UsableTrueTest, function
UsableTrueTest:
push {lr} 
ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r1, #0x03 
strb r1, [r3, #0x13] @ hp i think 

@mov r0, r3 
@blh 0x80797d5 @ Hide
@blh 0x8079190 @MU_AllRestartAnimations
@ldr r3, =BattleActor




mov r2, #0x20  
mov r1, #0x41 @ AI4
@strb r2, [r3, r1] 

ldr r3, =BattleActor
mov r2, #0x0
mov r1, #0x52 @ Cannot counter 
@strb r2, [r3, r1] 

@blh 0x801dacc @HideMoveRangeGraphics

@ldr r0, =TeleportActiveUnitPrepEvent
mov r1, #1 @ Wait for events 
blh EventEngine

@ 0801cc7c DisplayActiveUnitEffectRange
@0x090E87F0 @prClearRangeMap
@0x090E880C @prClearMoveMap
@0x090E8828 @prClearRangeAndMoveMap
@blh prClearRangeAndMoveMap @ From StanHax common 


@ blh 0x8030184 @ LockGameGraphicsLogic - locks map / fog layers i guess and hides sms 
@ mms, range map, and wiggly arrow are still shown 



End3:
mov r0, #1 @ Always true 
pop	{r1}
bx	r1




@0801cff0 PlayerPhase_CancelAction
@0801d008 .thumb
@0801d008 PlayerPhase_BackToMove
@0801d084 .thumb
@0801d084 PlayerPhase_PreAction
@0801d0cc .dbl:0004
@0801d0cc jpt_801D0C0
@0801d244 .thumb
@0801d244 TryMakeCantoUnit
@0801d300 .thumb
@0801d300 MaybeRunPostActionEvents
@0801d31c .thumb
@0801d31c EnsureCameraOntoActiveUnitPosition
@0801d470 .thumb
@0801d470 PlayerPhase_ApplyUnitMovement





