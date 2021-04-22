@ Hook at RefreshFogAndUnitMaps.
@ Updates the danger radius.
.thumb

.equ ChapterData,							              0x202BCF0
.equ UnitMap,								                0x202E4D8
.equ Fog,									                  0x202E4E8
.equ Hidden,								                0x202E4EC
.equ gMapTerrainPool,                       0x202ECAC

.equ ActiveUnit,							              0x3004E50 @ Pointer_to_work_memory_operation_of_character.
.equ DRCounter,								              0x3000006 @ Free space used to count how many DR's are active.

.equ GetUnitStruct,							            0x8019431
.equ ClearMapWith,							            0x80197E5

.equ UpdateUnitMapAndVision,				        0x8019FA1
.equ UpdateTrapHiddenStates,				        0x801A1A1
.equ UpdateTrapFogVision,  					        0x801A175

.equ MapMenuCommand_DangerZoneUnusedEffect,	0x80226F9


push {r14}

@ Check for FOW.
ldr		r0, =ChapterData
ldrb	r0, [r0,#0xD]
cmp		r0,	#0x0
beq		DR

@ Previously overwritten.
ldr		r0,=Fog
ldr		r0,[r0]
mov		r1,#0x0
ldr		r2,=ClearMapWith
bl		GOTO_R2
ldr     r2,=UpdateTrapFogVision
bl      GOTO_R2
ldr     r2,=UpdateUnitMapAndVision
bl      GOTO_R2
ldr     r2,=UpdateTrapHiddenStates
bl      GOTO_R2
b		Return

@ Check whether we should update dangerzone or not.
DR:
ldr		r2, =DRCounter
ldrb	r2, [r2] @ Is fog/dangerzone active?
cmp		r2, #0x0
beq		NoDR

ldr		r2, =ChapterData
ldrb	r2, [r2, #0xF] @ Are we on playerphase?
cmp		r2, #0x0
bne		NoDR

b		L1 @ None of the above

NoDR:
@ Danger radius not active/We're not playerphase/No enemies present.
ldr		r2, =DRCounter
mov		r0, #0x0
strb	r0, [r2] @ ensure dangerzone is disabled

@ Iterate over all enemy units (maybe neutral units too, not sure) and unset DR-bit.
mov		r3,	#0x81
Loop:
mov		r0, r3
ldr		r2, =GetUnitStruct
bl		GOTO_R2
mov		r1, r0
cmp		r1, #0x0
beq		NextIteration

ldr		r0, [r1]
cmp		r0, #0x0
beq		NextIteration

mov		r0, #0x32
ldrb	r0, [r1, r0]	@ Replace with a different bit...
mov		r2,	#0x40		@ ...in unit struct, if in use.
mvn		r2,	r2
and		r0, r2			@ Unset DR-bit.
mov		r2, #0x32
strb	r0, [r1, r2]

NextIteration:
add		r3, #0x1
cmp		r3, #0xBF		@ Max unit count.
ble		Loop

ldr		r0,=Fog
ldr		r0,[r0]
mov		r1,#0x0
ldr		r2,=ClearMapWith
bl		GOTO_R2

L1:
@ Previously overwritten.
@ Fog is either present or not present.
ldr     r2,=UpdateTrapFogVision
bl      GOTO_R2
ldr     r2,=UpdateUnitMapAndVision
bl      GOTO_R2
ldr     r2,=UpdateTrapHiddenStates
bl      GOTO_R2

@ Re-add active unit to gMapUnit to update DR during movement.
ldr		r0,=ActiveUnit
ldr		r1,[r0] @ Load pointer_to_work_memory_of_operation_character.
cmp		r1,#0x0
beq		RepeatCheck @ No active unit, don't add active unit to gMapUnit.

ldrb	r0,[r1,#0xB]
mov		r2,#0xC0
and		r0,r2
lsr		r0,#0x6
cmp		r0,#0x1 
beq		RepeatCheck @ Active unit has NPC allegiance, don't add active unit to gMapUnit.
cmp		r0,#0x2
beq		RepeatCheck @ Active unit has enemy allegiance, don't add active unit to gMapUnit.
ldrb	r0,[r1,#0xC]
mov		r2,#0xC
and		r0,r2
cmp		r0,#0x0
bne		RepeatCheck @ Active unit died/retreated, don't add active unit to gMapUnit.

ldrb	r0,[r1,#0x10] @ X-coordinate.
ldrb	r2,[r1,#0x11] @ Y-coordinate.
lsl		r2,#0x2 @ Quadruple for row pointers.
ldrb	r1,[r1,#0XB] @ Deployment slot.
ldr		r3,=UnitMap
ldr		r3,[r3]
ldr		r3,[r3,r2] @ Go to Y-coordinate.
add		r3,r0 @ Go to X-coordinate.

@ 'Overflow' check, make sure we're still in gMapUnitPool
ldr   r0, =gMapTerrainPool
cmp   r3, r0
bge   RepeatCheck

strb	r1,[r3] @ Re-add active unit.

RepeatCheck:
@ Repeat check whether we should update dangerzone or not.
ldr		r2, =DRCounter
ldrb	r2,[r2] @ Is fog/danger radius active?
cmp		r2, #0x0
beq		Return

ldr		r2, =ChapterData
ldrb	r2,[r2,#0xF] @ Are we on playerphase?
cmp		r2, #0x0
bne		Return

ldr		r0,=Fog
ldr		r0,[r0]
mov		r1,#0x0
ldr		r2,=ClearMapWith
bl      GOTO_R2
ldr     r2,=MapMenuCommand_DangerZoneUnusedEffect @ Re-enable DR.
bl      GOTO_R2


@ Re-update in case active unit needs to be removed from gMapUnit again.
ldr		r0,=UnitMap
ldr		r0,[r0]
mov		r1,#0x0
ldr		r2,=ClearMapWith
bl		GOTO_R2

ldr		r0,=Hidden
ldr		r0,[r0]
mov		r1,#0x0
ldr		r2,=ClearMapWith
bl		GOTO_R2

ldr     r2,=UpdateTrapFogVision
bl      GOTO_R2
ldr     r2,=UpdateUnitMapAndVision
bl      GOTO_R2
ldr     r2,=UpdateTrapHiddenStates
bl      GOTO_R2

Return:
pop		{r2}
GOTO_R2:
bx		r2
