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

mov r0, #0xAC @ Another flag used 
blh CheckEventId
cmp r0, #0 
@bne SkipDisplayingRange 

ldr r0, [r4] @ Copied vanilla code
blh DisplayActiveUnitEffectRange
b DisplayRange
SkipDisplayingRange:



@ Doesn't work here - too early 
@@ Remove the blue arrow 
@ldr r3, =#0x203A990  @ gMovementArrowData
@mov r0, #0 
@ldr r2, =#0x203AA04 @ gAiData 
@ClearMovementArrowDataLoop2:
@cmp r3, r2 
@bge BreakLoop2 
@str r0, [r3] 
@add r3, #4 
@b ClearMovementArrowDataLoop2
@BreakLoop2: 
@ldr r0, [r4] @ Copied vanilla code

DisplayRange:



pop {r3}
bx r3 

.equ GetUnit, 0x8019430

.align 4
@ Hooks CheckEventDefinitions at 8082EC4
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
@ this seems to be the ram address used 
@ when Dunno2 / "When player has selected coordinate to move to" is hit 
@stack: 3007d50 + 1c 
mov r3, sp 
add r3, #0x1C @ player? 3007D6C 
cmp r4, r3 
bne SkipParaCheck1
mov r11, r11
ldr r2, =0x202BCF0
ldrb r1, [r2, #0xF] @ Phase 
cmp r1, #0 
bne SkipParaCheck1 @ If not player phase, exit 

ldr r1, =CurrentUnit
ldr r1, [r1]
cmp r1, #0 
beq SkipParaCheck1
bl CheckForParalysis
SkipParaCheck1:

@ldr r3, =0x3007D70 @ ai? 
@cmp r4, r3 
@bne SkipParaCheck2
@push {r0} @ idk 
@ldr r1, =0x203AA95 @ current AI actor's deployment byte  
@ldrb r0, [r1] 
@blh GetUnit
@mov r1, r0 
@pop {r0} 
@bl CheckForParalysis
@SkipParaCheck2:

ldr r3, =0x3007D98 
cmp r4, r3 
bne SkipTeleportActiveUnit 

blh TeleportActiveUnit
blh FastMoveUnit

SkipTeleportActiveUnit:
cmp r0, #1 

pop {r1}
BXR1:
bx r1 

.ltorg 
.align 

CheckForParalysis:
push {r4-r5, lr} 
mov r4, r0 @ Parent proc maybe? idk 
mov r5, r1 @ unit 

ldr r1, =ParalyzeStatusID_Link 
ldr r1, [r1] 
mov r2, #0x36 @ have we done this already this turn? 
ldrb r2, [r5, r2] @ Support5 
mov r3, #1 @ if we have, this is 1 
and r2, r3 
cmp r2, #1 
beq FalseParalysis 
mov r0, r5 @ unit 
bl IsStatusApplicable @ r0 / r1 as unit struct / status id 
cmp r0, #1 
bne FalseParalysis 

mov r3, #0x36 @ have we done this already this turn? 
ldrb r0, [r5, r3] @ Support5 
mov r1, #1 
orr r0, r1 
strb r0, [r5, r3] @ only check once per unit per turn 

blh 0x8000c64 @NextRN_100
ldr r1, =PlayerParalyzeChanceLink
ldr r1, [r1] 
cmp r0, r1
bgt FalseParalysis


ldr r3, =MemorySlot
ldrb r0, [r5, #0x10]
ldrb r1, [r5, #0x11]
strh r0, [r3, #4*0x0B+0] @ XX
strh r1, [r3, #4*0x0B+2] @ YY 
ldr r0, [r5, #0xC] @ State 
mov r1, #2 @ Acted 
orr r0, r1 
str r0, [r5, #0xC] @ Acted already 

@ remove from AI list? 


ldr r0, =ParalyzedUnitEvent
mov r1, #1 @ Wait for events 
blh EventEngine 

FalseParalysis:



mov r0, r4 
pop {r4-r5}
pop {r1}
bx r1 


.ltorg 
.align 

.equ MuCtr_CreateWithReda,0x800FEF5 @r0 = char struct, target x coord, target y coord
.align 4 
	.global TeleportActiveUnit
	.type   TeleportActiveUnit, function
TeleportActiveUnit:
	push {r4-r7, lr} 

@ 10850 CheckCursor 
mov r7, r0 

mov r0, #0xAA @ Flag used 
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

ldr r0, =SetNoActiveUnitEvent
mov r1, #1 @ Wait for events 
blh EventEngine 

b End


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

End:
mov r0, r7 

pop {r4-r7}
pop {r1}
bx r1

.equ UnsetEventId, 0x8083d94
.align 4 
	.global ToggleFlagAA
	.type   ToggleFlagAA, function
ToggleFlagAA:
	push {lr} 
mov r0, #0xAA 
blh CheckEventId
cmp r0, #0 
beq TurnFlagOn
mov r0, #0xAA 
blh UnsetEventId
b Term 
TurnFlagOn:
mov r0, #0xAA 
blh SetEventId
@blh 0x80311a8 @ReloadGameCoreGraphics

Term:
mov   r0, #0x17 @ This removes a graphical glitch and I have no idea why 
				@ Copied what Huichelaar did in Suspendx2 
pop {r1}
bx r1


.align 4 
	.global DisplayIfFlagAB
	.type   DisplayIfFlagAB, function
DisplayIfFlagAB:
push {lr} 
mov r0, #0xAB 
blh CheckEventId
cmp r0, #1 
beq Skip 
mov r0, #3 @ False 
Skip:
pop {r1}
bx r1
