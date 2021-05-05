@ Modified from SkillSystems' DangerZone.s.
@ Replace DangerRadius.s and DangerRadius.dmp
@ with this .s and its corresponding .dmp to remove the following functionality:
@ When pressing select whilst hovering over a non-enemy unit or no-unit tile either:
@ DR is enabled for all enemy units if it was disabled for all enemy units
@ Or DR is disabled for all enemy units if it was enabled for at least one enemy unit
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
beq		Continue		@ No unit.

@ Check if enemy
ldrb	r1, [r0, #0xB]	@ Deployment byte.
mov		r2, #0x80		@ Enemy.
tst		r1, r2
beq		Continue		@ Ignore if not enemy.

ldr r3, m4aSongNumStart @ Call m4aSongNumStart function.
mov r0,#0x68
bl GOTO_R3

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
