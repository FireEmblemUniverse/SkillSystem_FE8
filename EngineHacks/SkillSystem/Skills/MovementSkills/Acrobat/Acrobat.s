.thumb
.org 0x0

.equ AcrobatID, SkillChecker+4
@r0=movement cost table. Function originally at 1A4CC, now jumped to here (jumpToHack)
push  {r4,r5,r14}
mov   r4,r0
ldr   r0,SkillChecker
mov   r14,r0
ldr   r0,CurrentCharPtr
ldr   r0,[r0]
cmp   r0, #0
bne   NoDZ
mov   r0, r2 @if the active unit is 0, we're being called from dangerzone
NoDZ:
ldr   r1,AcrobatID
.short  0xF800
mov   r1,#0x0       @counter
ldr   r5,MoveCostLoc
Loop1:
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

.align
CurrentCharPtr:
.long 0x03004E50
MoveCostLoc:
.long 0x03004BB0
SkillChecker:
@POIN SkillChecker
@WORD AcrobatID
