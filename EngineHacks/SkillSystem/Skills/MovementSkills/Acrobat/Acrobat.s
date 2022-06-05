.thumb
.org 0x0
	.equ CheckEventId,0x8083da8
.equ AcrobatID, SkillChecker+4
@r0=movement cost table. Function originally at 1A4CC, now jumped to here (jumpToHack)
push  {r4,r5,r14}
mov   r4,r0
ldr 	r0, =CheckEventId
mov   r14,r0
ldr   r0,CurrentCharPtr
ldr   r0,[r0]
cmp   r0, #0
bne   NoDZ
mov   r0, r2 @if the active unit is 0, we're being called from dangerzone
NoDZ:
ldr   r0,MarshbadgeObtained
.short  0xF800

ldr   r1,CurrentCharPtr
ldr   r1,[r1]
ldrb r1, [r1, #0x0B] @ deployment byte 
lsr r1, #6 @ NPC/Enemies only 
cmp r1, #0 
beq Player
mov r0, #1 @ enemies always have acrobat i guess lol 
Player:
mov   r1,#0x0       @counter
ldr   r5,MoveCostLoc
Loop1: @ store each value into the movement table in ram  
add   r2,r4,r1
add   r3,r5,r1
ldrb  r2,[r2]
cmp   r0,#0x0
beq   NoAcrobat
cmp   r2,#0xFF
beq   NoAcrobat
mov   r2,#0x1
NoAcrobat:
strb  r2,[r3]
add   r1,#0x1
cmp   r1,#0x40
ble   Loop1
pop   {r4-r5}
pop   {r0}
bx    r0

.ltorg 
.align
CurrentCharPtr:
.long 0x03004E50
MoveCostLoc:
.long 0x03004BB0
MarshbadgeObtained:
@WORD MarshbadgeObtained
@WORD AcrobatID
