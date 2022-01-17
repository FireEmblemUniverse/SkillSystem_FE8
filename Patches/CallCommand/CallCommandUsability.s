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
 
.equ Call_ExceptionsList, CallUsability_List+4
.equ FindFreeTile, Call_ExceptionsList+4
.equ CheckUnitIsInDanger, FindFreeTile+4
.equ PokemblemOrNot, CheckUnitIsInDanger+4 
.equ SkillTester, PokemblemOrNot+4 

.equ MaxUnitsCallable, 5
	
.global CallCommandUsability
.type CallCommandUsability, %function

CallCommandUsability:
push {r4-r6, lr}





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


@ Now loop through units to check if any are within X tiles and not dead/undeployed/cantoing/hide

mov r5, #0 


LoopThroughUnits:
add r5, #1  @ deployment byte 
cmp r5, #0x3F 
bgt Usability_False 

mov r0,r5
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

ldr r3, Call_ExceptionsList
ldr r2, [r6] @ unit pointer 
ldrb r0, [r2, #4] @ unit ID 
UnitListLoop: 

ldrh r1, [r3] @ terminator? 
ldr r2, =0xFFFF 
cmp r1, r2 
beq BreakUnitListLoop 

ldrb r1, [r3] 
cmp r1, r0 
beq LoopThroughUnits @ If unit ID matches, they cannot be called. 
add r3, #2
b UnitListLoop 
BreakUnitListLoop: 

ldr r3, Call_ExceptionsList
ldr r2, [r6, #4] @ class pointer 
ldrb r0, [r2, #4] @ class ID 
ClassListLoop: 
ldrh r1, [r3] @ terminator? 
ldr r2, =0xFFFF 
cmp r1, r2 
beq BreakClassListLoop 
ldrb r1, [r3, #1] 
cmp r1, r0 
beq LoopThroughUnits @ If class ID matches, they cannot be called. 
add r3, #2 
b ClassListLoop 
BreakClassListLoop: 


ldr r2, =CurrentUnit 
ldr r2, [r2] @ Current unit ram struct pointer 

ldrb r0, [r6, #0x10] @ XX 
ldrb r1, [r2, #0x10] @ XX 
sub r0, r1 
asr r1, r0, #31
add r0, r0, r1
eor r0, r1 @ Abs(X1-X2)

ldrb r1, [r6, #0x11] @ YY 
ldrb r2, [r2, #0x11] @ YY 
sub r1, r2 
asr r2, r1, #31
add r1, r1, r2
eor r1, r2 @ Abs(Y1-Y2)
add r0, r1 @ Distance between two units 
ldrb r1, [r4, #4] @ Max distance to call units from 
cmp r0, r1 
bgt LoopThroughUnits 




mov r0, #1 
mov r1, r4 @ table entry we're using 
b Exit 

Usability_False:
mov r0, #3 @ False usability 
mov r1, #0 


Exit: 
pop {r4-r6}
pop {r2} 
bx r2 

.align 
.ltorg 

CallUsability_List:

