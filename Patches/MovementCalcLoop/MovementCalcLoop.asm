.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ CurrentUnit, 0x3004E50
.equ MemorySlot, 0x30004B8
.equ BWL_AddTilesMoved, 0x80A481C 
.equ gActionData, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ Defender, 0x203A56C
.equ GetUnit, 0x8019430
.equ UnitMap, 0x202E4D8 
.equ CanUnitCrossTerrain, 0x801949c 
.equ TerrainMap, 0x202E4DC
.equ FillMap, 0x080197E4 
.equ UpdateUnitMapAndVision, 0x08019FA0   
.equ UpdateTrapHiddenStates, 0x0801A1A0   
.equ SMS_UpdateFromGameData, 0x080271a0   
.equ UpdateGameTilesGraphics, 0x08019c3c  
.equ ProcFind, 0x08002E9C
.equ ForEach6C, 0x8002F98 
.equ gMapAnimStruct, 0x203E1F0

.global MovementCalcLoopFunc
.type MovementCalcLoopFunc, %function 
MovementCalcLoopFunc:
push {r4-r7, lr} 
mov r7, r0
ldr r4, =Attacker
ldr r5, =Defender

ldr r6, =MovementCalcLoop 
sub r6, #4 
CalcLoop:
add r6, #4 
ldr r2, [r6] 
cmp r2, #0 
beq BreakLoop 
mov lr, r2 
mov r0, r4 @ atkr 
mov r1, r5 @ dfdr 
.short 0xf800 
b CalcLoop 

BreakLoop:


ldr r0, =UnitMap
ldr r0, [r0] 
mov r1, #0
blh FillMap 
blh UpdateUnitMapAndVision 
blh UpdateTrapHiddenStates 
blh SMS_UpdateFromGameData
blh UpdateGameTilesGraphics 


ldrb r0, [r7, #4] 
ldr r1, =gActionData 
ldrb r1, [r1, #0x10] @ tiles moved 
blh BWL_AddTilesMoved

pop {r4-r7} 
ldr r5, [r6] @ vanilla 
pop {r0}
bx r0 
.ltorg 


.global KnockbackEffect
.type KnockbackEffect, %function 
KnockbackEffect: @ knocks back the defender if the attacker has a specific weapon 
push {r4-r7, lr} 
mov r7, sp 
sub sp, #4 


ldr r4, =Attacker
ldr r5, =Defender

ldrh r0, [r5, #0x10] @ defaults to coordinates you were already at 
str r0, [r7] 

ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne ExitKnockbackEffect @ only do stuff if attacked this turn 

ldrb r0, [r5, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitKnockbackEffect
mov r6, r0 

mov r0, r4 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r3, =KnockbackItemList
sub r3, #1 
KnockbackLoop:
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0 
beq ExitKnockbackEffect 
cmp r0, r1 
bne KnockbackLoop 


ldrb r0, [r4, #0x10]
ldrb r1, [r4, #0x11]
ldrb r2, [r5, #0x10]
ldrb r3, [r5, #0x11]

@ Take coordinates'
@ absolute values.			
sub   r0, r2 @ X difference 
sub   r1, r3 @ Y difference 	
asr r3, r0, #31
add r0, r0, r3
eor r0, r3
asr r3, r1, #31
add r1, r1, r3
eor r1, r3

mov r2, r0 
add r2, r1 @ total distance 
cmp r2, #1 
beq ContinueKnockback
ldr r3, KNOCKBACK_ADJACENT_ONLY 
cmp r3, #1 
beq ExitKnockbackEffect 
ContinueKnockback: 

cmp r0, r1 @ act on X or Y difference? 
beq Diagonal
cmp r0, r1 
bgt XAxis

YAxis: 
ldrb r0, [r4, #0x11]
ldrb r1, [r5, #0x11]
cmp r0, r1 
blt ShoveDown
sub r1, #2 
cmp r1, #0 
blt ExitKnockbackEffect 
ShoveDown:
add r1, #1 
strb r1, [r7, #0x1] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitKnockbackEffect 
b StoreKnockback 



XAxis:
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt ShoveRight
sub r1, #2 
cmp r1, #0 
blt ExitKnockbackEffect 
ShoveRight:
add r1, #1 
strb r1, [r7] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitKnockbackEffect 
b StoreKnockback 

Diagonal: @ same as XAxis. Then goes to YAxis 
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt ShoveRight2
sub r1, #2 
cmp r1, #0 
blt ExitKnockbackEffect 
ShoveRight2:
add r1, #1 
strb r1, [r7] @ store 
@ now we run FindFreeTile?  
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitKnockbackEffect 
b YAxis 

StoreKnockback:
ldrh r0, [r7] @ XXYY 
strh r0, [r6, #0x10] @ XXYY 

ldr r3, =MemorySlot
add r3, #0x8*4 
ldr r2, =Defender @ only effect this unit 
str r2, [r3] 
str r0, [r3, #4] @ coords to place into 

ExitKnockbackEffect: 


add sp, #4 
pop {r4-r7}
pop {r0}
bx r0 
.ltorg 

.global MovementCalcLoopMMSUpdate
.type MovementCalcLoopMMSUpdate, %function 
MovementCalcLoopMMSUpdate:
push {r4, lr}

bl DigEffect 
ldr r0, =0x89A2C48 @gProc_MoveUnit
ldr r1, =UpdateMMSCoordDig
blh ForEach6C


ldr r3, =MemorySlot
mov r0, #0 
str r0, [r3, #4*0x08]
str r0, [r3, #4*0x09]

bl KnockbackEffect 

ldr r0, =0x89A2C48 @gProc_MoveUnit
ldr r1, =UpdateMMSCoord
blh ForEach6C



@ldr r3, =Attacker 
@ldrb r0, [r3, #0x0B] @ deployment byte 
@blh GetUnit 
@cmp r0, #0 
@beq SkipAttacker
@ldr r3, =Attacker 
@ldrh r1, [r3, #0x10] 
@strh r1, [r0, #0x10] @ overwrite coords 
@
@SkipAttacker: 
@ldr r3, =Defender
@ldrb r0, [r3, #0x0B] @ deployment byte 
@blh GetUnit 
@cmp r0, #0 
@beq BreakMoveUnitUpdate
@ldr r3, =Defender 
@ldrh r1, [r3, #0x10] 
@strh r1, [r0, #0x10] @ overwrite coords 


BreakMoveUnitUpdate: 
ldr r0, =gMapAnimStruct @ vanilla 
add r0, #0x58 
ldrb r1, [r0] 
lsl r0, r1, #2 
add r0, r1 
lsl r0, #2 @ end of vanilla stuff 

pop {r4}
pop {r3}
bx r3 
.ltorg 


.global UpdateMMSCoord
.type UpdateMMSCoord, %function 

UpdateMMSCoord: @ Copy unit struct coords over into MMS coords 
push {r4-r7, lr}
mov r4, r0 @ MMS proc 
add r0, #0x2C 
ldr r5, [r0] @ unit struct 
cmp r5, #0 
beq ExitUpdateMMSCoord

ldr r3, =MemorySlot
add r3, #0x8*4 
ldr r2, [r3] 
cmp r2, r5 
bne ExitUpdateMMSCoord
ldrb r0, [r3, #4] @ xx coords to place into 
@ldrb r0, [r5, #0x10] @ XX 

lsl r0, #8 
mov r2, r4 
add r2, #0x4C @ XX * 256 
strh r0, [r2] 
ldrb r0, [r3, #5] @ yy coords to place into 
@ldrb r0, [r5, #0x11] @ YY

lsl r0, #8 
strh r0, [r2, #2] @ YY  

ExitUpdateMMSCoord: 

pop {r4-r7}
pop {r0}
bx r0 

.ltorg 

.global UpdateMMSCoordDig
.type UpdateMMSCoordDig, %function 

UpdateMMSCoordDig: @ Copy unit struct coords over into MMS coords 
push {r4-r7, lr}
mov r4, r0 @ MMS proc 
add r0, #0x2C 
ldr r5, [r0] @ unit struct 
cmp r5, #0 
beq ExitUpdateMMSCoordDig
ldrb r0, [r5, #0x10] @ XX 

lsl r0, #8 
mov r2, r4 
add r2, #0x4C @ XX * 256 
strh r0, [r2] 
ldrb r0, [r5, #0x11] @ YY

lsl r0, #8 
strh r0, [r2, #2] @ YY  


ExitUpdateMMSCoordDig: 

pop {r4-r7}
pop {r0}
bx r0 

.ltorg 


CanWeMoveThere:
push {r4-r6, lr}
mov r5, r0 @ XX 
mov r6, r1 @ YY  
mov r4, r2 @ unit struct
mov r0, r5 
mov r1, r6 
@r0 x, r1 y coord to move unit to 
ldr	 r3, =UnitMap
ldr	 r3,[r3]			@Offset of map's table of row pointers
lsl	 r1,#0x2			@multiply y coordinate by 4
add	 r3,r1			@so that we can get the correct row pointer
ldr	 r3,[r3]			@Now we're at the beginning of the row data
add	 r3,r0			@add x coordinate
ldrb r1,[r3]			@load datum at those coordinates
cmp r1, #0 
bne CannotMoveThere

mov r0, r5 
mov r1, r6 
@ Given r0 = x, r1 = y, r2 = unit struct
ldr	 r3, =TerrainMap @ Terrain map	@Load the location in the table of tables of the map you want
ldr	 r3,[r3]			@Offset of map's table of row pointers
lsl	 r1,#0x2			@multiply y coordinate by 4
add	 r3,r1			@so that we can get the correct row pointer
ldr	 r3,[r3]			@Now we're at the beginning of the row data
add	 r3,r0			@add x coordinate
ldrb r1,[r3]			@load datum at those coordinates
mov r0, r5 @ unit struct 
blh CanUnitCrossTerrain @0x801949c @ r1 terrain type, r0 unit 
cmp r0, #1
bne CannotMoveThere
mov r0, #1 
b CanMoveThere 

CannotMoveThere:
mov r0, #0 
CanMoveThere: 

pop {r4-r6}
pop {r1}
bx r1 
.ltorg 

.global DigEffect
.type   DigEffect, function

DigEffect:	
push {r4-r7, lr} 
ldr r4, =Attacker
ldr r5, =Defender
ldr r6, =gActionData
mov r7, sp 
sub sp, #8 
@r4 = attacker, r5 = defender, r6 = action struct 



ldrb r0, [r6, #0x11] 
cmp r0, #2 
bne Exit @ only do stuff if attacked this turn 
mov r0, r4 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r6, =DigItemList
sub r6, #1 
Loop:
add r6, #1 
ldrb r1, [r6] 
cmp r1, #0 
beq Exit 
cmp r0, r1 
bne Loop 
@ it was equal, so now we teleport the unit 

@ check that we are at least 1 tile away, as no reason to teleport if we aren't farther away 
ldrb r0, [r4, #0x10]
ldrb r1, [r4, #0x11]
ldrb r2, [r5, #0x10]
ldrb r3, [r5, #0x11]

@ Take coordinates'
@ absolute values.			
sub   r0, r2 @ X difference 
sub   r1, r3 @ Y difference 	
asr r3, r0, #31
add r0, r0, r3
eor r0, r3
asr r3, r1, #31
add r1, r1, r3
eor r1, r3

add r0, r1 
cmp r0, #1 
ble Exit @ exit if already nearby 

mov r11, r11 
ldrh r0, [r4, #0x10] @ XXYY 
push {r0} 
ldrh r0, [r5, #0x10] 
strh r0, [r4, #0x10] 

mov r0, r4 @ Unit to place 
mov r1, r7 @ XX 
add r2, r1, #4 @ YY 
ldr r3, =0xFFFFFFFF @ (-1) as failed value 
str r3, [r1]
str r3, [r2] 
bl FindFreeTile @FindFreeTile(struct Unit *unit, int* xOut, int* yOut)

ldr r1, [r7] @ X
ldr r2, [r7, #4] @ Y 
pop {r0} @ original coords 

lsr r3, r1, #8 
cmp r3, #0 
beq Store @ we succeeded 

@ if we failed to find a proper place for the called unit, leave them where they were 
ldr r3, =CurrentUnit
ldr r3, [r3] 
strh r0, [r3, #0x10] @ store original coords back if failed 
b Exit 

Store: 
ldr r3, =CurrentUnit
ldr r3, [r3] 
strb r1, [r3, #0x10]
strb r2, [r3, #0x11]
strb r1, [r4, #0x10] 
strb r2, [r4, #0x11] 
ldr r3, =gActionData 
strb r1, [r3, #0xE] 
strb r2, [r3, #0xF] 

Exit: 
add sp, #8 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

KNOCKBACK_ADJACENT_ONLY:

