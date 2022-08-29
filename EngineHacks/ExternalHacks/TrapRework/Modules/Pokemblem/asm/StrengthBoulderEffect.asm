.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetTrapAt,0x802e1f0
.equ gCurrentUnit, 0x3004E50 
.equ CurrentUnitFateData, 0x203A958 
.equ RefreshTerrainBmMap, 0x8019A64
.equ RemoveTrap, 0x802EA90 @ 2E2FC other version that does not care about terrain ? 
.equ EventEngine, 0x800D07C 
.equ MemorySlot,0x30004B8

.type StrengthBoulderEffect, %function 
.global StrengthBoulderEffect 
StrengthBoulderEffect:
push {r4-r7, lr}
@But first, we need to find the event associated with this location.
ldr r0, =gCurrentUnit
ldr r0, [r0]
cmp r0, #0 
beq Exit 

bl GetAdjacentTrap
cmp r0, #0 
beq Exit 
mov r4, r0  
mov r5, r1 @ direction 

	// right, down, left, up are all defined in EA already 
	// (1 2 0 3)


ldr r0, =gCurrentUnit
ldr r0, [r0] @ unit 
mov r1, #0 
ldsb r6, [r4, r1] @ xx 
mov r2, #1
ldsb r7, [r4, r2] @ yy 

cmp r5, #0 
beq Left 
cmp r5, #1 
beq Right 
cmp r5, #2 
beq Down 
cmp r5, #3 
beq Up 
b Exit 
Left: 
sub r6, #1 
b Continue 
Right: 
add r6, #1 
b Continue 
Down: 
add r7, #1 
b Continue 
Up: 
sub r7, #1 

Continue: 

mov r1, r6 
mov r2, r7 

blh CanUnitBeOnPosition @(Unit* unit, int x, int y) 
cmp r0, #1 
bne Exit 
mov r0, r6 @ xx 
mov r1, r7 @ yy 
blh GetTrapAt 
cmp r0, #0 
beq NotBoulderReceptacle 
ldrb r2, [r0, #2] @ trap id 
ldr r1, =BoulderReceptacleID 
lsl r1, #24 
lsr r1, #24 
cmp r1, r2 
bne NotBoulderReceptacle 
@ we have trap with coords of trap to delete in r0 
ldrb r1, [r0, #4] @ yy 
ldrb r0, [r0, #3] @ xx 

ldr r3, =MemorySlot 
add r3, #0x0B*4 
strh r0, [r3] @ XX 
strh r1, [r3, #2] @ YY 

blh GetTrapAt 
cmp r0, #0 
beq NotBoulderReceptacle @ nothing found 
@blh RemoveTrap @ remove the corresponding rock 
mov r0, r6 @ xx 
mov r1, r7 @ yy 
blh GetTrapAt 
blh RemoveTrap @ also remove the receptacle i guess  





ldr r0, =RemoveRockEvent 
mov r1, #1 
blh EventEngine 

NotBoulderReceptacle: 



ldr r0, =gCurrentUnit
ldr r0, [r0]
bl GetAdjacentTrap
mov r4, r0 @ we must find the trap again after removing traps, 
@ as removing traps moves all traps to fill in any empty spaces 
strb r6, [r4, #0] 
strb r7, [r4, #1] 
blh RefreshTerrainBmMap @ this includes UpdateAllLightRunes 



Exit:
ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x10
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4-r7}
pop {r1}
bx r1

.ltorg 



GetAdjacentTrap: @r0 = unit we're checking for adjacency to
push {r4-r7,r14}
mov r4,r0

ldr r4,=#0x3004E50
ldr r0,[r4]

mov r4, r0

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord
ldr r7, =StrengthBoulderTrapID
lsl r7, #24 
lsr r7, #24 



mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt
mov r1, #0 @ left 
ldrb r2,[r0,#2]
cmp r7, r2 
beq RetTrap 

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt
mov r1, #3 @ up 
ldrb r2,[r0,#2]
cmp r7, r2 
beq RetTrap 

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt
mov r1, #1 @ right 
ldrb r2,[r0,#2]
cmp r7, r2 
beq RetTrap 

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt
mov r1, #2 @ down 
ldrb r2,[r0,#2]
cmp r7, r2 
beq RetTrap 

@ false 
mov r0,#0	@no trap so return 0


RetTrap:
pop {r4-r7}
pop {r2}
bx r2

.ltorg 

