.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CantoPlusID, SkillTester+4
.thumb
push	{r4, lr}
@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check if current chracter
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x1E @check if found enemy in the fog
beq End
ldrb  r0, [r6,#0x0C]  @allegiance byte of the current character taking action
ldrb  r1, [r4,#0x0B]  @allegiance byte of the character we are checking
cmp r0, r1    @check if same character
bne End



@check if waited
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x1
ble End

@check if moved all the squares
ldr	r0,=#0x8019224	@mov getter
mov	lr, r0
mov	r0, r4		@attacker
.short	0xF800
ldrb 	r1, [r6,#0x10]	@squares moved this turn
cmp	r0,r1
beq	End

blh 0x801A1F5 @first refresh the entity map
ldr	r1,=#0x8018BD8	@check if can move again
mov	lr, r1
.short	0xF800
lsl	r0, #0x18
cmp	r0, #0x00
beq	End

@check if already cantoing, and is not in a ballista
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x21
lsl	r1, #0x06 	@has moved already and is in a ballista
and	r0, r1
cmp	r0, #0x00
bne	End

@check for skill
mov	r0, r4
ldr	r1, CantoPlusID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	End

@ if this is off, only refresh unit if player 
ldr r3, =CantoAI_Label
ldr r3, [r3] 

@check if enemy or not
ldrb r2, [r4,#0x0B]
lsr r2,r2,#6
cmp r3, #1 
beq Refresh 
cmp r2, #0 
bne End @ no canto ai and not a player 
Refresh: 
@if canto, unset 0x2 and set 0x40
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x02
mvn	r1, r1
and	r0, r1		@unset bit 0x2
mov	r1, #0x40	@set canto bit
orr	r0, r1
str	r0, [r4,#0x0C]
cmp r2, #0 
beq End @ player who has been refreshed, so no need for ai 

mov r0, r4 @ unit 
add r0, #0x41 
ldrb r0, [r0] 
mov r1, #0x20 
tst r0, r1 
bne End @ do not canto if cannot move 

@ instead of trying to get the AI to play nice, just make the unit move to the safest tile via a ASMCs in an event 
@add unit to the AI list so enemies act twice
@ldr	r0,=#0x203AA04
@ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
@mov r3, #0 @ counter 
@sub r3, #1 
@
@AddAILoop:
@add r3, #1 
@ldrb r2, [r0, r3] 
@cmp	r2, #0x00
@bne	AddAILoop
@@ found our last entry 
@cmp r3, #0 
@beq StoreNow 
@
@AddAILoop_2: 
@sub r3, #1 @ 
@ldrb r2, [r0, r3] 
@add r3, #1 
@strb r2, [r0, r3] @ store down 1 space 
@sub r3, #1 
@cmp r3, #0 
@ble StoreNow 
@b AddAILoop_2 
@
@StoreNow: 
@strb	r1, [r0]



@ debuff movement while finding the ideal place to move to after attacking 
ldr r0, =CurrentUnit 
ldr r0, [r0] 
bl GetUnitDebuffEntry 
mov r4, r0 @ entry 
ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
mov r5, r0 @ value 
ldrb r0, [r6, #0x10] @ squares moved this turn 
mov r3, #0 
sub r3, r0 
mov r0, r4 @ entry 
ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl PackData_Signed 



bl CopyAIScript11_Move_Towards_Safety @ based on current unit, should return r0 XX r1 YY coords 
ldr r3, =MemorySlot 
strh r0, [r3, #0x0B*4]
strh r1, [r3, #0x0B*4+2]


mov r0, r4 @ entry 
ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r3, r5 @ value 
bl PackData_Signed 




ldr r0, =MoveActiveTo_sBCoords
mov r1, #1 @ cutscene 
blh EventEngine 






End:
pop {r4}
pop	{r0}
bx	r0
.ltorg


.global MoveActorToCoords_sB
.type MoveActorToCoords_sB, %function 
MoveActorToCoords_sB: 
push {r4, lr} 
mov r4, r0 @ event engine 
ldr r3, =MemorySlot 
ldrh r1, [r3, #0x0B*4]
ldrh r2, [r3, #0x0B*4+2]
blh TryPrepareEventUnitMovement @ r0 = parent proc 

ldr r0, =CurrentUnit 
ldr r0, [r0] 
ldr r3, =MemorySlot 
ldrh r1, [r3, #0x0B*4]
ldrh r2, [r3, #0x0B*4+2]
sub sp, #4 
mov r3, #0 
str r3, [sp] 
mov r3, #5 
blh MuCtr_StartMoveTowards, r4 
add sp, #4 


@mov r2, #5 @ Wait 
@bl SetAIToWaitAtCoords
ldr r3, =MemorySlot 
ldrh r0, [r3, #0x0B*4]
ldrh r1, [r3, #0x0B*4+2]
bl SetActorCoords
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.equ TryPrepareEventUnitMovement, 0x800FC90   
.equ gProcEventEngine, 0x8591AC0 
.equ MoveUnit,0x807A014 @r0 = unit struct, r1 = x coord, r2 = y coord, r3 = some constant (always 1? is this speed?)
.equ MuCtr_StartMoveTowards, 0x8079DDC
.equ EventEngine, 0x800D07C
.equ MemorySlot,0x30004B8
.equ gActionStruct, 0x203A958
.equ MMS_EndAll, 0x80790a4
.equ SetCursorMapPosition, 0x8015BBC 
@.equ BattleMapState, 0x202BCB0 @ SetCursorMapPosition sets this 
.equ ChapterData, 0x202BCF0 
.equ UnitPos_BPress, 0x202BE48 
.equ CurrentUnit, 0x3004E50
.equ CurrentUnitFateData, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ gMoveMap, 0x202E4E0 
.equ gUnitMap, 0x202E4D8
.equ FillMap, 0x080197E4	
.equ UpdateUnitMapAndVision, 0x8019FA0 
.equ ProcFind, 0x8002E9C
.equ gProc_MoveUnit, 0x89A2C48

.global SetActorCoords 
.type SetActorCoords, %function 
SetActorCoords:
push {lr} 
@ given r0 = xx, r1 = yy 
ldr r2, =gActionStruct 
strb r0, [r2, #0xE] @ XX ActionStruct 
strb r1, [r2, #0xF]
mov r3, #0 
strb r3, [r2, #0x10] @ tiles moved  
ldr r3, =Attacker 
strb r0, [r3, #0x10] 
strb r1, [r3, #0x11] 

blh SetCursorMapPosition @ r0 = xx, r1 = yy 
ldr r1, =CurrentUnitFateData	@from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]

ldr r0, =gMoveMap 
ldr r0, [r0] 
mov r1, #0xFF
blh FillMap

ldr r0, =gUnitMap @ unit map 
ldr r0, [r0] 
mov r1, #0x0
blh FillMap
blh UpdateUnitMapAndVision 

ldr r0, =gProc_MoveUnit
blh ProcFind 
cmp r0, #0 
beq SkipHidingInProc
add r0, #0x40 @this is what MU_Hide does @MU_Hide, 0x80797D5
mov r1, #1 
strb r1, [r0] @ store back 0 to show active MMS again aka @MU_Show, 0x80797DD

SkipHidingInProc: 

@blh MMS_EndAll 
 
pop {r0} 
bx r0 
.ltorg 




.equ AiSetDecision, 0x8039C20
.equ CurrentUnit, 0x3004E50
.equ FindSafestTileAI, 0x803B808  
@ Based on 803CDD4 
@ 803B808 FindSafestTileAI from 803CDE7
CopyAIScript11_Move_Towards_Safety: 
push {r4, lr}
sub sp, #0x10 @ allocate space 
ldr r0, =CurrentUnit 
ldr r0, [r0] 
add r4, sp, #0x0C @ stack address to save something to  ? 
mov r1, r4 
blh FindSafestTileAI @0x803B809  

@ returns true or false 
@ if false, don't do AiSetDecision 
@ at a glance, it always returned true 
@ so I don't know what criteria it returns false for 
@ maybe if it failed in some way... ? 
lsl r0, #24 
lsr r0, #24 @ bool is a byte 
@add r0, sp, #0x0C @ stack address to save something to
mov r2, #0 
ldsh r0, [r4, r2] 
mov r2, #2
ldsh r1, [r4, r2] 
@ then it stores stuff into the sp and runs AiSetDecision 
add sp, #0x10 
pop {r4}
pop {r2} 
bx r2 

.ltorg 

SetAIToWaitAtCoords:
@ given r0 = XX and r1 = YY, and r2 = ActionType, wait at coords. 
push {r4, lr}
mov r4, r2 @ Action type 
sub sp, #0xC 
@ r0 = XX 
@ r1 = YY 

@ some of this is probably unnecessary 
@ it could be trimmed down 

@ sanity check that we aren't going to try and move to [0,0] if something is empty 
ldr r2, =0x203AA96 @ AI decision +0x92 (XX) 
ldrh r2, [r2, #0x0] @ XX,YY
ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r2, #0 
bne ContinueSetAIToWaitAtCoords
mov r1, #0x10 
ldrh r0, [r3, r1] @ Current unit coords  
ldr r2, =0x203AA96 @ AI decision +0x92 (XX) 
strh r0, [r2, #0] @ 
ldr r2, =0x203A958 @ Action struct 
mov r1, #0x13
strh r0, [r2, r1] @ Action Struct @ 203A958

ldrb r0, [r3, #0x10] @ No decision made by move towards enemy 
ldrb r1, [r3, #0x11] @ so put in our current coords 
ContinueSetAIToWaitAtCoords:

@mov r2, #0 @ Action: noop @ when they move to a coord, it had 0 here (but runs the range event in some other way I guess) 
@mov r11, r11 
@ #0x00 - noop (does not trigger range events) 
@ #0x01 - attacks target? but since I have no target it just crashes the game 
@ #0x02 - moved two tiles to the left 
@ #0x03 - gold was stolen 
@ #0x04 - the village was destroyed 
@ #0x05 - wait, I guess? it ran the range event, which is good enough for me
@ #0x07 - targets something but no crash 
@ #0x08 - targets something but no crash 
@ #0x09 - wait ? 
@ #0xFF - targets & crashes 
@ is #5 is staffwait? @ 803a204 CpPerform_StaffWait
mov r2, r4 @ Usually #0x05 (Wait), but is given as parameter in r2 to this function now 
mov r3, #0 @ store into item slot / X / Y coord 
str r3, [sp, #0] @ Item slot 
str r3, [sp, #4] @ X Coord2 (0 is fine) 
str r3, [sp, #8] @ Y Coord2 (0 is fine)
mov r3, #0 @ Target 
blh AiSetDecision, r4 @0x8039C21 
add sp, #0xC 
@ breaks once per enemy with this AI, so perfect 
@ but doesn't actually 'wait' at the spot, so it doesn't trigger range events.. 
@ so we manually trigger them now 
@ but first, let's put the active unit's coord into sB and their unit id in s2 
pop {r4} 
pop {r1}
bx r1 

.ltorg 








.align
SkillTester:
@POIN SkillTester
@WORD CantoPlusID
