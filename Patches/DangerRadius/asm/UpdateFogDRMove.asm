@ Updates DR after moving a unit and before committing to an action.
.thumb

.equ ApplyUnitMovement,		0x801849D
.equ RefreshFogAndUnitMaps,	0x801A1F5
.equ prGotoMovGetter,		0x8019225
.equ GetUnitMovCostTable,	0x8018D4D
.equ SetMovCostTable,		0x801A4CD
.equ MapFillMovement,		0x801A4ED
.equ ClearMapWith,			0x080197E5

.equ ChapterData,			0x202BCF0
.equ GameState,				0x202BCB0
.equ gActiveUnitPosition,	0x202BE48
.equ MovementMap,			0x202E4E0
.equ ActiveUnit,			0x3004E50 @ Pointer_to_work_memory_operation_of_character.


push {r14}

@ Mimic 0801D484
ldr		r0,[r4]
ldr		r2,=ApplyUnitMovement
bl		GOTO_R2

@check for FOW
ldr		r2, =ChapterData
ldrb	r2, [r2,#0xD]
cmp		r2,	#0x0
bne		NoDR

@ Call RefreshFogAndUnitMaps to update DR mid-action.
ldr		r2,=RefreshFogAndUnitMaps
bl		GOTO_R2

@ Re-fill active unit's movement map based on previous coordinates
@ Mimics FillMovementMapForUnitAndMovement, 0x0801A3CC
push	{r4, r5}
ldr		r0, =MovementMap
ldr		r0, [r0]
mov		r1, #0x1
neg		r1, r1
ldr		r2, =ClearMapWith
bl		GOTO_R2

mov		r0, #0x3E
ldr		r1, =GameState
ldr		r1, [r1, r0]
ldr		r0, =ActiveUnit
ldr		r0, [r0]
ldr		r2, =prGotoMovGetter
bl		GOTO_R2
mov		r1, r0
lsl		r1, r1, #0x18
lsr		r1, r1, #0x18
ldr		r0, =ActiveUnit
ldr		r0, [r0]

mov		r5, r0
mov		r4, r1
ldr		r3, =GetUnitMovCostTable
bl		GOTO_R3
ldr		r3, =SetMovCostTable
bl		GOTO_R3

ldr		r1, =gActiveUnitPosition
ldrh	r0, [r1]		@ original x-coord
ldrh	r1, [r1, #0x2]	@ original y-coord
mov		r3, #0xB
ldsb	r3, [r5, r3]	@ deployment byte
mov		r2, r4			@ movement
ldr		r4, =MapFillMovement
bl		GOTO_R4
pop		{r4, r5}

NoDR:
ldr		r0,[r4]
ldr		r0,[r0,#0xC]
mov		r1,#0x40

pop		{r2}
GOTO_R2:
bx		r2
GOTO_R3:
bx		r3
GOTO_R4:
bx		r4
