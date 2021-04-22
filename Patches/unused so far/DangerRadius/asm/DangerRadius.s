@ Modified from SkillSystems' DangerZone.s.
.thumb
.org 0x00000000

Dangerzone_Hack_Start:
@ Mimic $0801CAE2.
ldrh r1,[r2,#0x4]
mov r0,#0x4
and r0,r1
cmp r0,#0x0
beq Select_Not_Pressed

@ Check for FOW.
ldr		r3, ChapterData
ldrb	r3, [r3,#0xD]
cmp		r3,	#0x0
beq		DR

@ FOW.
ldr r3, Clear_Screen
bl GOTO_R3
b Continue

DR:
ldr		r3, m4aSongNumStart @ Call m4aSongNumStart function.
mov		r0,#0x68
bl		GOTO_R3

@ Check if unit
ldr		r2, MS_R2
mov		r3, #0x16
ldsh	r0, [r2, r3]	@ gCursorMapPosition Y-coordinate (row).
ldr		r1, Something_2
ldr		r1, [r1]
lsl		r0 ,r0 ,#0x2
add		r0 ,r0, r1
mov		r3, #0x14
ldsh	r1, [r2, r3]	@ gCursorMapPosition X-coordinate.
ldr		r0, [r0]
add		r0 ,r0, r1
ldrb	r0, [r0, #0x0]	@ Character index.
ldr		r3, GetUnitStruct
bl		GOTO_R3
cmp		r0, #0x0
beq		ResetAllDR1		@ No unit.

@ Check if enemy
ldrb	r1, [r0, #0xB]	@ Deployment byte.
mov		r2, #0x80		@ Enemy.
tst		r1, r2
beq		ResetAllDR1		@ Reset if not enemy.
b		Continue

ResetAllDR1:
push {r4-r7}
ldr		r6, DRCounter
ldrb	r5, [r6]
cmp		r5, #0x0
beq		ResetAllDR2 @Previously SetAllDR here

@ UnsetAllDR
ldr		r0, Fog
ldr		r0, [r0]
mov		r1, #0x0
ldr		r3, ClearMapWith
bl		GOTO_R3
mov		r4, #0x0
b		ResetAllDR2

SetAllDR:
mov		r4, #0x40		@ Replace with a different bit in unit struct, if in use.

ResetAllDR2:
@ If not hovering over enemy unit, enable/disable all DR
@ disable if at least one enemy has DR enabled.
@ enable if no enemies have DR enabled.
ldr		r6, DRCounter
mov		r5, #0x0		
mov		r7, #0x40		@ Replace with a different bit in unit struct, if in use.
mov		r3,	#0x32
mov		r2,	#0x81
Loop:
mov		r0, r2
push	{r2-r3}
ldr		r3, GetUnitStruct
bl		GOTO_R3
pop		{r2-r3}
mov		r1, r0
cmp		r1, #0x0
beq		NextIteration

ldr		r0, [r1]
cmp		r0, #0x0
beq		NextIteration

@ Set/Unset DR-bit and increment/don't change DRCounter
lsr		r0, r4, #0x6
add		r5, r0

ldrb	r0, [r1, r3]
orr 	r0, r7			@ Set DR-bit.
and		r0, r4			@ Either set or unset it
strb	r0, [r1, r3]

NextIteration:
add		r2, #0x1
cmp		r2, #0xBF		@ Max enemy unit count.
ble		Loop

strb	r5, [r6] 		@ Reset DRCounter
pop {r4-r7}

Continue:
ldr r2, MS_R2
ldr r1, [r2,#0x18]
ldr r0, [r2,#0x14]
ldr r3, MS_Hook
bl MS_GOTO_R3
ldr r3, Dangerzone
bl GOTO_R3

ldr r3,Back
bx r3

.align
Dangerzone:
.long 0x080226F9
m4aSongNumStart:
.long 0x080D01FD
Clear_Screen:
.long 0x0808D151
MS_R2:
.long 0x0202BCB0
MS_Hook:
.long 0x08027ACB
GetUnitStruct:
.long 0x08019431
DRCounter:
.long 0x03000006
ClearMapWith:
.long 0x080197E5
Fog:
.long 0x0202E4E8

Select_Not_Pressed:
ldr r2, Something
mov r1, #0x16
ldsh r0,[r2,r1]
ldr r1, Something_2
ldr r1,[r1]
ldr r3, Start_cont
b GOTO_R3

.align
Something:
.long 0x0202BCB0
Something_2:
.long 0x0202E4D8
ChapterData:
.long 0x0202BCF0
Start_cont:
.long 0x0801CAF7
Back:
.long 0x0801CB39

MS_GOTO_R3:
push {r4,r14}
GOTO_R3:
bx r3
