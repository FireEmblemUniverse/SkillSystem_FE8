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
	.equ EventEngine, 0x800D07C
.set prMap_Fill,                 0x080197E4 @ arguments: r0 = rows start ptr, r1 = value; returns: nothing

	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	.equ GetUnitDropLocation, 0x80184E1
	.equ UpdateRescueData, 0x8018371
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ TerrainMap, 0x202E4DC
	.equ RefreshTerrainMap, 0x08019a64 @RefreshTerrainMap
@ @ 32696
@ Seth [0202BE4C] @ [0202BE67]? yup 
	
	.global CallCommandEffect
	.type   CallCommandEffect, function

CallCommandEffect:
	push	{r4-r7,lr}
mov r4,#0 @ current deployment id
mov r5,#0 @ counter



mov r0, #1 @ Battle 
blh CheckEventId
cmp r0, #0 
bne SetNoCallFlag 

mov r0, #9 @ 1 turn til battle 
blh CheckEventId 
cmp r0, #0 
bne SetNoCallFlag

ldr r3, =CurrentUnit
ldr r3, [r3] @ Ram address 
ldrb r0, [r3, #0x11] @Y 
lsl r0, #16 @ --XX---- 
ldrb r1, [r3, #0x10] @ X
add r0, r1 
ldr r6, =MemorySlot
str r0, [r6, #0x0B*4] @ SlotB is used in CheckInDanger 

blh CheckUnitIsInDanger
add r6, #0xC*4 @ SlotC 
ldr r0, [r6] 
cmp r0, #0 
bne SetNoCallFlag

b Start 

SetNoCallFlag: 
mov r0, #8 @ Cannot call 
blh SetEventId

Start: 


LoopThroughFirst5Units:
add r4, #1  @ r4 also increases in NextUnit 
add r5, #1 
cmp r5, #7 
bge End @ We have found all the units we need to act upon 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
@cmp r0,#0
@beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldrb r3, [r3, #4] @ unit ID 
ldr r2, =ProtagID_Link 
ldr r2, [r2] 
cmp r2, r3 
beq NextUnit 
ldr r3,[r0,#0xC] @ condition word
@ if you add +1 to include Hide (eg 0x4F), it'll ignore the active unit, which may be useful 
mov r2,#0x4F @ moved/dead/undeployed/cantoing 
tst r3,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
mov r6, r0 


ldr r2, =CurrentUnit 
ldr r2, [r2] @ Current unit ram struct pointer 

ldrh r0, [r6, #0x10] 
push {r0} @ save original coords 

ldrh r0, [r2, #0x10] 
strh r0, [r6, #0x10] @ So units have matching coords 

ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates


	ldr r0, =0x202E4E0 @ 202E4F0
	ldr r0, [r0]
	
	mov r1, #1
	neg r1, r1
	
	blh prMap_Fill




mov r0, r6 @ Unit to place 
ldr r1, =MemorySlot 
add r1, #4*0x0A @ XX in sA
add r2, r1, #4 @ YY in sB 
ldr r3, =0xFFFFFFFF @ (-1) as failed value 
str r3, [r1]
str r3, [r2] 
bl FindFreeTile @FindFreeTile(struct Unit *unit, int* xOut, int* yOut)

ldr r3, =MemorySlot 
add r3, #4*0x0A @ sA 
ldr r1, [r3] @ X
ldr r2, [r3, #4] @ Y 
pop {r0} @ original coords 
lsr r3, r1, #8 
cmp r3, #0 @ if we failed to find a proper place for the called unit, put them at -1x, 0y 
beq Store

strh r0, [r6, #0x10] @ store original coords back if failed 

b LoopThroughFirst5Units


Store: 
strb r1, [r6, #0x10] @ X
strb r2, [r6, #0x11] @ Y




b LoopThroughFirst5Units
	
	@ 
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
@ If we've gone through all units and not found 5 free, we can end 
mov r0, #0
	
End:



ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics

ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics




	pop {r4-r7}
	pop {r1}
	bx r1 
	
	
.ltorg
.align 

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
	
.ltorg 
.align 
.global UndeployBadCoordMons
.type UndeployBadCoordMons, %function 
UndeployBadCoordMons:
push {r4, lr}

mov r4, #0 
UndeployLoop:
add r4, #1 
cmp r4, #0xC0 
bge BreakLoop 
mov r0, r4 
blh GetUnit 
cmp r0, #0 
beq UndeployLoop
ldr r3,[r0]
cmp r3,#0
beq UndeployLoop
ldr r3,[r0,#0xC] @ condition word
ldr r2, =#0x1000C @ escaped, benched/dead
tst r3,r2
bne UndeployLoop
mov r1, #0x10 
ldsb r1, [r0, r1] 
cmp r1, #0 
bge UndeployLoop
mov r1, #0 
strb r1, [r0, #0x11] @ YY as 0 

@ r3 is still state 
ldr r2, =0x210009 @ undeployed last ch, escaped, hide / undeploy 
orr r3, r2 
str r3, [r0, #0x0C] @ hide/undeploy unit 
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
b UndeployLoop

BreakLoop: 

pop {r4}
pop {r0}
bx r0 
.ltorg 
.align 
	
	
	.global CallCommandUsability
.type CallCommandUsability, %function

CallCommandUsability:
push {lr}

ldr r0, =DisableMenuOptionsRamLink
ldr r0, [r0] 
ldrb r0, [r0] 
mov r1, #8 @ Prevent call bitflag 
and r0, r1
cmp r0, #0 
bne Usability_False  

ldr r0, =CallCountdownFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne Usability_False

ldr r0, =PlayableCutsceneFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne Usability_False

ldr r0, =TrainerBattleActiveFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne Usability_False

blh Get2ndFreeUnit
cmp r0, #0 
beq Usability_False 
mov r0, #1 
b Exit 

Usability_False:
mov r0, #3 @ False is 3 for some reason  


Exit: 
pop {r1} 
bx r1 
