.thumb
.org 0
@pointer to this hack goes at 801cdf8
@branch to 801ce30 if moving, else 801ce14 if bzzt

@eh screw it let's just check unit and in rangetable for now
ldr r3, CursorLoc
ldrb r0,[r3] @x
ldrb r1,[r3,#2] @y
ldr r3, RangeTable
lsl r2,r1,#2
ldr r2,[r3,r2] @row
ldrb r2,[r2,r0]
cmp r2,#0
beq ReturnFalse
ldr r3, UnitMap
ldr r3,[r3]
lsl r2,r1,#2
ldr r2,[r3,r2]
ldrb r2,[r2,r0]
cmp r2,#0
beq ReturnFalse
ldr r3, Move
bx r3

@check unit table
  @if ally/npc, are they in staff range or 1-range?
  @if enemy/snag, are they in attack/staff range?
  @if chest/door, are they in 1-range?

ReturnFalse:
ldr r3, NoMove
bx r3

.align
RangeTable:
.long 0x3000fd0
UnitMap:
.long 0x202e4d8
Move:
.long 0x801ce31
NoMove:
.long 0x801ce15
CursorLoc:
.long 0x202bcc4
