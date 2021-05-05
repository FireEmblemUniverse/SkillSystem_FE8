@ Hook at MapMenuCommand_DangerZoneUnusedEffect.
@ Also calls PlayerPhase_DisplayDangerZone display fog.
@ If not called by RefreshFogAndUnitMaps, then:
@ Flips the DR-bit in unit struct of the unit the cursor is hovering over.
@ We're using the 7th lsb from byte Unit struct+#0x32 as DR-bit.

.thumb

.equ BattleMapState,				0x0202BCB0
.equ DRCounter,						0x03000006 @ Free space used to count how many DR's are active.
.equ gMapUnit,						0x0202E4D8
.equ Fog,							0x0202E4E8
.equ ActiveUnit,					0x03004E50 @ Pointer_to_work_memory_operation_of_character.
.equ PlayerPhase_DisplayDangerZone,	0x0801CCB5
.equ GetUnitStruct,					0x08019431
.equ ClearMapWith,					0x080197E5
.equ RefreshFogAndUnitMapsCall,		0x0801A213

.equ ChapterData,					0x0202BCF0
.equ Procs_PlayerPhase,				0x0859AAD8
.equ Find6C,						0x08002E9D
.equ Goto6CLabel,					0x08002F25

push	{r14}

@ Check for FOW.
ldr		r1, =ChapterData
ldrb	r1, [r1,#0xD]
cmp		r1,	#0x0
beq		DR

@ FOW is active.
@ Previously overwritten.
ldr		r0,=ActiveUnit
mov		r1,#0x0
str		r1,[r0]
ldr		r0,=BattleMapState
add		r0,#0x3E
strb	r1,[r0]
ldr		r0, =Procs_PlayerPhase
ldr		r2, =Find6C
bl		GOTO_R2
mov		r1, #0xC
ldr		r2, =Goto6CLabel
bl		GOTO_R2
pop		{r0}
bx		r0

DR:
@ Previously overwritten.
ldr		r0,=ActiveUnit
ldr		r1,[r0] @ Load pointer_to_work_memory_of_operation_character.
push	{r1}
mov		r1,#0x0
str		r1,[r0]

ldr		r0,=BattleMapState
add		r0,#0x3E
strb	r1,[r0]

@ Don't (un)set DR if we're called by RefreshFogAndUnitMaps/UpdateFogDR.
ldr		r0, =RefreshFogAndUnitMapsCall
ldr		r1, [sp, #0xC]
cmp		r0, r1
beq		Return

@ Get Unit Struct from cursor position.
ldr		r2, =BattleMapState
mov		r3, #0x16
ldsh	r0, [r2, r3]	@ gCursorMapPosition Y-coordinate (row).
ldr		r1, =gMapUnit
ldr		r1, [r1]
lsl		r0 ,r0 ,#0x2
add		r0 ,r0, r1
mov		r3, #0x14
ldsh	r1, [r2, r3]	@ gCursorMapPosition X-coordinate.
ldr		r0, [r0]
add		r0 ,r0, r1
ldrb	r0, [r0]	@ Character index.
ldr		r2, =GetUnitStruct
bl		GOTO_R2
cmp		r0, #0x0
beq		Return			@ No unit.

@ Set/Unset enemy unit's DR-bit.
ldrb	r1, [r0, #0xB]	@ Deployment byte.
mov		r2, #0x80		@ Enemy.
tst		r1, r2
beq		Return			@ Ignore if not enemy.

mov		r1, #0x32
ldrb	r1, [r0, r1]	@ Replace with a different bit...
mov		r2,	#0x40		@ ...in unit struct, if in use.
eor		r1, r2			@ Flip the bit.

mov		r3, #0x32
strb	r1, [r0, r3]
tst		r1, r2
bne		Increment

@ Decrement DRCounter.
mov		r1, #0x1
ldr		r0, =DRCounter
ldrb	r2, [r0]
sub		r2, r1
strb	r2, [r0]

@ Clear fog when DR-bit has been unset.
ldr		r0, =Fog
ldr		r0, [r0]
mov		r1, #0x0
ldr		r2, =ClearMapWith
bl		GOTO_R2
b		Return

@ Increment DRCounter.
Increment:
mov		r1, #0x1
ldr		r0, =DRCounter
ldrb	r2, [r0]
add		r2, r1
strb	r2, [r0]

Return:
ldr		r0,=PlayerPhase_DisplayDangerZone
bl		GOTO_R0

ldr		r0,=ActiveUnit
pop		{r1}
str		r1,[r0] @ Set the unitpointer back.

pop     {r0}
GOTO_R0:
bx      r0 @ The end
GOTO_R2:
bx      r2
