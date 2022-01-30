.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.macro blh_EALiteral to, reg=r3
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm

.equ CurrentUnitFateData, 0x203A958
	.equ CheckEventId,0x8083da8
	.equ SetEventId, 0x8083d80 
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
	.equ prMap_Fill,  0x080197E4 @ arguments: r0 = rows start ptr, r1 = value; returns: nothing

	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	.equ GetUnitDropLocation, 0x80184E1
	.equ UpdateRescueData, 0x8018371
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ TerrainMap, 0x202E4DC
	.equ RefreshTerrainMap, 0x08019a64 @RefreshTerrainMap


@ CallUsability_List, end of file +0
 
.equ CallLimit_UnitList, CallUsability_List+4
.equ CallLimit_ClassList, CallLimit_UnitList+4
.equ CallLimit_FlagList, CallLimit_ClassList+4
.equ FindFreeTile, CallLimit_FlagList+4
.equ CheckUnitIsInDanger, FindFreeTile+4
.equ PokemblemOrNot, CheckUnitIsInDanger+4 
.equ Get2ndFreeUnit, PokemblemOrNot+4

.equ MaxUnitsCallable, 5

	.global CallCommandEffect
	.type   CallCommandEffect, function

CallCommandEffect:
	push	{r4-r7,lr}



ldr r0, PokemblemOrNot
cmp r0, #1 
bne Start 

@ Set flags as per Pokemblem's preferences 
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

mov r4,#0 @ current deployment id
mov r5,#0 @ counter


LoopThroughUnits:
add r4, #1  @ deployment byte 
cmp r4, #0x3F 
bgt End 
ldrb r3, [r7, #MaxUnitsCallable]
cmp r5, r3 @ r5 as number of units that have been called  
bge End @ We have found all the units we need to act upon 


mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq LoopThroughUnits
ldr r3,[r0]
cmp r3,#0
beq LoopThroughUnits
ldr r3,[r0,#0xC] @ condition word
@ if you add +1 to include Hide (eg 0x4F), it'll ignore the active unit, which may be useful 
mov r2,#0x4F @ moved/dead/undeployed/cantoing/hide
tst r3,r2
bne LoopThroughUnits
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
mov r6, r0 


ldr r3, CallLimit_UnitList
ldr r2, [r6] @ unit pointer 
ldrb r0, [r2, #4] @ unit ID 
UnitListLoop: 
ldrb r1, [r3] 
cmp r1, #0 
beq BreakUnitListLoop 
cmp r1, r0 
beq LoopThroughUnits @ If unit ID matches, they cannot be called. 
add r3, #1 
b UnitListLoop 
BreakUnitListLoop: 

ldr r3, CallLimit_ClassList
ldr r2, [r6, #4] @ class pointer 
ldrb r0, [r2, #4] @ class ID 
ClassListLoop: 
ldrb r1, [r3] 
cmp r1, #0 
beq BreakClassListLoop 
cmp r1, r0 
beq LoopThroughUnits @ If class ID matches, they cannot be called. 
add r3, #1 
b ClassListLoop 
BreakClassListLoop: 




ldr r2, =CurrentUnit 
ldr r2, [r2] @ Current unit ram struct pointer 

ldrh r0, [r2, #0x10] 
strh r0, [r6, #0x10] @ So units have matching coords 

ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh   0x8019fa0 @RefreshUnitMapAndVision


ldr r0, =0x202E4E0 @ Movement map
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
blh_EALiteral FindFreeTile 	@FindFreeTile(struct Unit *unit, int* xOut, int* yOut)



ldr r3, =MemorySlot 
add r3, #4*0x0A @ sA 
ldr r1, [r3] @ X
ldr r2, [r3, #4] @ Y 
@ Store their new coordinates 
strb r1, [r6, #0x10] @ X
strb r2, [r6, #0x11] @ Y

add r5, #1 @ number of units that have been called 
b LoopThroughUnits

	
End:
ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics

ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??

pop {r4-r7}
pop {r1}
bx r1 
	
	
.ltorg
.align 





	
	
.global CallCommandUsability
.type CallCommandUsability, %function

CallCommandUsability:
push {r4, lr}

ldr r0, Get2ndFreeUnit
cmp r0, #0 
beq SkipCheckForAvailableUnit
blh_EALiteral Get2ndFreeUnit @ If no units that aren't dead/undeployed/cantoing/hide, then fail 
cmp r0, #0 
beq Usability_False 
SkipCheckForAvailableUnit: 



ldr r4, CallUsability_List
sub r4, #8 

UsabilityLoop:
add r4, #8 

ldr r0, [r4]
cmp r0, #0 
bne Continue
ldr r0, [r4, #4] 
cmp r0, #0 
bne Continue

b Usability_False

Continue:

ldrb r0, [r4]
ldr r3, =0x202BCF0 @ gChapterData 
ldrb r1, [r3, #0xE] @ chapter ID 
cmp r0, #0xFF 
beq CheckUnitID 
cmp r0, r1 
bne UsabilityLoop 

CheckUnitID: 
@ unit ID 
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r4, #1] 
cmp r0, #0 
beq CheckClassID 
ldr r1, [r3] @ unit pointer 
ldrb r1, [r1, #4] @ Unit ID 
cmp r0, r1 
bne UsabilityLoop 

CheckClassID: 
ldrb r0, [r4, #2] 
cmp r0, #0 
beq CheckSkillID 
ldr r1, [r3, #4] @ class pointer 
ldrb r1, [r1, #4] @ class ID 
cmp r0, r1 
bne UsabilityLoop 

CheckSkillID: 
ldrb r0, [r4, #3] @ skill ID 
mov r1, r3 @ unit struct 
@ blh_EALiteral SkillTester 
@ cmp r0, #1 
@ bne UsabilityLoop 

@ are any units matching criteria within X tiles ? 
@ function for this? 

CheckFlagID: 
ldrh r0, [r4, #6] @ Required Flag 
cmp r0, #0 
beq SkipFlagCheck 
blh CheckEventId
cmp r0, #1 
bne UsabilityLoop 
SkipFlagCheck: 



mov r0, #1 
mov r1, r4 @ table entry we're using 
b Exit 

Usability_False:
mov r0, #3 @ False usability 
mov r1, #0 


Exit: 
pop {r4}
pop {r2} 
bx r2 

.align 
.ltorg 

CallUsability_List:


