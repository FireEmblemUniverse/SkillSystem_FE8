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
.equ gMapSize, 0x202E4D4

.global PostBattleMovementCalcLoopFunc
.type PostBattleMovementCalcLoopFunc, %function 
PostBattleMovementCalcLoopFunc:
push {r4, lr} 
mov r4, r0

ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne SkipPostBattleCalcLoop @ only update coords if attacked this turn 

bl MovementCalcLoopFunc

ldr r3, =Attacker 
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq SkipAttacker
ldr r1, =Attacker
ldrh r2, [r1, #0x10] 
strh r2, [r0, #0x10] @ copy attacker's coords to real unit 
SkipAttacker: 

ldr r3, =Defender
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq SkipDefender
ldr r1, =Defender
ldrh r2, [r1, #0x10] 
strh r2, [r0, #0x10] @ copy defender's coords to real unit 
SkipDefender: 


ldr r0, =UnitMap
ldr r0, [r0] 
mov r1, #0
blh FillMap 
blh UpdateUnitMapAndVision 
blh UpdateTrapHiddenStates 
blh SMS_UpdateFromGameData
blh UpdateGameTilesGraphics 

SkipPostBattleCalcLoop:


ldrb r0, [r4, #4] 
ldr r1, =gActionData 
ldrb r1, [r1, #0x10] @ tiles moved 
blh BWL_AddTilesMoved

pop {r4} 
ldr r5, [r6] @ vanilla 
pop {r0}
bx r0 
.ltorg 


.global MovementCalcLoopFunc
.type MovementCalcLoopFunc, %function 
MovementCalcLoopFunc:
push {r4-r7, lr} 
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

pop {r4-r7} 
pop {r0}
bx r0 
.ltorg 


.global MovementCalcLoopMMSUpdate
.type MovementCalcLoopMMSUpdate, %function 
MovementCalcLoopMMSUpdate:
push {r4, lr}
bl MovementCalcLoopFunc

ldr r0, =0x89A2C48 @gProc_MoveUnit
ldr r1, =UpdateMMSCoord
blh ForEach6C

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
push {r4-r5, lr}
mov r4, r0 @ MMS proc 
add r0, #0x2C 
ldr r5, [r0] @ unit struct 
cmp r5, #0 
beq ExitUpdateMMSCoord
ldrb r0, [r5, #0x10] @ XX 

lsl r0, #8 
mov r2, r4 
add r2, #0x4C @ XX * 256 
strh r0, [r2] 
ldrb r0, [r5, #0x11] @ YY

lsl r0, #8 
strh r0, [r2, #2] @ YY  


ExitUpdateMMSCoord: 

pop {r4-r5}
pop {r0}
bx r0 

.ltorg 


CanWeMoveThere:
push {r4-r6, lr}
mov r5, r0 @ XX 
mov r6, r1 @ YY  
mov r4, r2 @ unit struct

ldr r3, =gMapSize
ldrh r2, [r3] @ XX +1
ldrh r3, [r3, #2] @ YY+1 
sub r2, #1 
sub r3, #1 
cmp r0, r2 
bgt CannotMoveThere
cmp r1, r3 
bgt CannotMoveThere 

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


.global KnockbackEffect
.type KnockbackEffect, %function 
KnockbackEffect: @ knocks back the defender if the attacker has a specific weapon 
push {r4-r7, lr} 
mov r7, sp 
sub sp, #4 


ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne ExitKnockbackEffect @ only do stuff if attacked this turn 

ldr r0, =Attacker 
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

ldr r3, =Attacker
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitKnockbackEffect
mov r4, r0 
ldr r3, =Defender
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitKnockbackEffect
mov r5, r0 

mov r0, r5 
add r0, #0x41 @ ai4 byte 
ldrb r0, [r0] 
mov r1, #0x20 @ bossAI 
tst r0, r1 
bne ExitKnockbackEffect 

ldrh r0, [r5, #0x10] @ defaults to coordinates they were already at 
str r0, [r7] 




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
ldr r3, =Defender
strh r0, [r3, #0x10] @ XXYY 

ExitKnockbackEffect: 


add sp, #4 
pop {r4-r7}
pop {r0}
bx r0 
.ltorg 


.global PullBackEffect
.type PullBackEffect, %function 
PullBackEffect:
push {r4-r7, lr} 
mov r7, sp 
sub sp, #4 

ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne ExitPullBackEffect @ only do stuff if attacked this turn 

ldr r0, =Attacker 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r3, =PullBackItemList
sub r3, #1 
PullBackLoop:
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0 
beq ExitPullBackEffect 
cmp r0, r1 
bne PullBackLoop 


ldr r3, =Attacker
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitPullBackEffect
mov r4, r0 
ldr r3, =Defender
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitPullBackEffect
mov r5, r0 

ldrh r0, [r4, #0x10] @ defaults to coordinates you were already at 
strh r0, [r7] 
strh r0, [r7, #2] @ target goes to where you were  




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
beq ContinuePullBack
ldr r3, KNOCKBACK_ADJACENT_ONLY 
cmp r3, #1 
beq ExitPullBackEffect 
ContinuePullBack: 
cmp r0, r1 @ act on X or Y difference? 
beq Diagonal2
cmp r0, r1 
bgt XAxis2

YAxis2: 
ldrb r0, [r4, #0x11]
ldrb r1, [r5, #0x11]
cmp r0, r1 
blt PullDown
add r0, #2 
PullDown:
sub r0, #1 
strb r0, [r7, #0x1] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPullBackEffect 
b StorePullBack 



XAxis2:
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt PullRight
add r0, #2 
cmp r0, #0 
blt ExitPullBackEffect 
PullRight:
sub r0, #1 
strb r0, [r7] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPullBackEffect 
b StorePullBack 

Diagonal2: @ same as XAxis. Then goes to YAxis 
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt PullRight2
add r0, #2 
cmp r0, #0 
blt ExitPullBackEffect 
PullRight2:
sub r0, #1 
strb r0, [r7] @ store 
@ now we run FindFreeTile?  
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPullBackEffect 
b YAxis2

StorePullBack:
ldrh r0, [r7] @ XXYY 
ldrh r1, [r7, #2] @ XXYY  
ldr r2, =Attacker
ldr r3, =Defender
strh r0, [r2, #0x10] @ XXYY 


mov r0, r5 
add r0, #0x41 @ ai4 byte 
ldrb r0, [r0] 
mov r2, #0x20 @ bossAI 
tst r0, r2 
bne ExitPullBackEffect 

strh r1, [r3, #0x10] @ XXYY 


ExitPullBackEffect: 

add sp, #4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.global HitAndRunEffect
.type HitAndRunEffect, %function 
HitAndRunEffect:
push {r4-r7, lr} 
mov r7, sp 
sub sp, #4 

ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne ExitHitAndRunEffect @ only do stuff if attacked this turn 

ldr r0, =Attacker 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r3, =HitAndRunItemList
sub r3, #1 
HitAndRunLoop:
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0 
beq ExitHitAndRunEffect 
cmp r0, r1 
bne HitAndRunLoop 


ldr r3, =Attacker
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitHitAndRunEffect
mov r4, r0 
ldr r3, =Defender
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitHitAndRunEffect
mov r5, r0 

ldrh r0, [r4, #0x10] @ defaults to coordinates you were already at 
strh r0, [r7] 
strh r0, [r7, #2] @ target goes to where you were  




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
beq ContinueHitAndRun
ldr r3, KNOCKBACK_ADJACENT_ONLY 
cmp r3, #1 
beq ExitHitAndRunEffect 
ContinueHitAndRun: 
cmp r0, r1 @ act on X or Y difference? 
beq Diagonal3
cmp r0, r1 
bgt XAxis3

YAxis3: 
ldrb r0, [r4, #0x11]
ldrb r1, [r5, #0x11]
cmp r0, r1 
blt RunDown
add r0, #2 
RunDown:
sub r0, #1 
strb r0, [r7, #0x1] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitHitAndRunEffect 
b StoreHitAndRun 



XAxis3:
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt RunRight
add r0, #2 
cmp r0, #0 
blt ExitHitAndRunEffect 
RunRight:
sub r0, #1 
strb r0, [r7] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitHitAndRunEffect 
b StoreHitAndRun 

Diagonal3: @ same as XAxis. Then goes to YAxis 
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt RunRight2
add r0, #2 
cmp r0, #0 
blt ExitHitAndRunEffect 
RunRight2:
sub r0, #1 
strb r0, [r7] @ store 
@ now we run FindFreeTile?  
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitHitAndRunEffect 
b YAxis3

StoreHitAndRun:
ldrh r0, [r7] @ XXYY 
ldrh r1, [r7, #2] @ XXYY  
ldr r2, =Attacker
strh r0, [r2, #0x10] @ XXYY 


ExitHitAndRunEffect: 

add sp, #4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


.global PivotEffect
.type PivotEffect, %function 
PivotEffect:
push {r4-r7, lr} 
mov r7, sp 
sub sp, #4 

ldr r3, =gActionData
ldrb r0, [r3, #0x11] 
cmp r0, #2 
bne ExitPivotEffect @ only do stuff if attacked this turn 

ldr r0, =Attacker 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r3, =PivotItemList
sub r3, #1 
PivotLoop:
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0 
beq ExitPivotEffect 
cmp r0, r1 
bne PivotLoop 


ldr r3, =Attacker
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitPivotEffect
mov r4, r0 
ldr r3, =Defender
ldrb r0, [r3, #0x0B] @ deployment byte 
blh GetUnit 
cmp r0, #0 
beq ExitPivotEffect
mov r5, r0 

ldrh r0, [r4, #0x10] @ defaults to coordinates you were already at 
strh r0, [r7] 
strh r0, [r7, #2] @ target goes to where you were  




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
beq ContinuePivot
ldr r3, KNOCKBACK_ADJACENT_ONLY 
cmp r3, #1 
beq ExitPivotEffect 
ContinuePivot: 
cmp r0, r1 @ act on X or Y difference? 
beq Diagonal4
cmp r0, r1 
bgt XAxis4

YAxis4: 
ldrb r0, [r4, #0x11]
ldrb r1, [r5, #0x11]
cmp r0, r1 
blt PivotDown
sub r1, #2 
cmp r1, #0 
blt ExitPivotEffect 
PivotDown:
add r1, #1 
strb r1, [r7, #0x1] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPivotEffect 
b StorePivot 



XAxis4:
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt PivotRight
sub r1, #2 
cmp r1, #0 
blt ExitPivotEffect 
PivotRight:
add r1, #1 
strb r1, [r7] @ store 
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPivotEffect 
b StorePivot 

Diagonal4: @ same as XAxis. Then goes to YAxis 
ldrb r0, [r4, #0x10]
ldrb r1, [r5, #0x10]
cmp r0, r1 
blt PivotRight2
sub r1, #2 
cmp r1, #0 
blt ExitPivotEffect 
PivotRight2:
add r1, #1 
strb r1, [r7] @ store 
@ now we Pivot FindFreeTile?  
mov r2, r5 @ unit struct 
ldrb r0, [r7] 
ldrb r1, [r7, #1] 
bl CanWeMoveThere 
cmp r0, #1 
bne ExitPivotEffect 
b YAxis4

StorePivot:
ldrh r0, [r7] @ XXYY 
ldr r2, =Attacker
strh r0, [r2, #0x10] @ XXYY 


ExitPivotEffect: 

add sp, #4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 



KNOCKBACK_ADJACENT_ONLY:

