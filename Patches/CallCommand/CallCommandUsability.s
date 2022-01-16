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
.equ SkillTester, Get2ndFreeUnit+4

.equ MaxUnitsCallable, 5
	
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
ldr r2, SkillTester 
cmp r2, #0 
beq CheckFlagID

mov r0, r3 @ unit struct 
ldrb r1, [r4, #3] @ skill ID 
cmp r1, #0 
beq CheckFlagID
blh_EALiteral SkillTester 
cmp r0, #1 
bne UsabilityLoop 

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

