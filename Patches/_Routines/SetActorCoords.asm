
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ MemorySlot,0x30004B8
.equ gActionStruct, 0x203A958
.equ MMS_EndAll, 0x80790a4
.equ SetCursorMapPosition, 0x8015BBC 
@.equ BattleMapState, 0x202BCB0 @ SetCursorMapPosition sets this 
.equ ChapterData, 0x202BCF0 
.equ UnitPos_BPress, 0x202BE48 
.equ CurrentUnit, 0x3004E50
.equ CurrentUnitFateData, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ gMoveMap, 0x202E4E0 
.equ gUnitMap, 0x202E4D8
.equ FillMap, 0x080197E4	
.equ UpdateUnitMapAndVision, 0x8019FA0 
@ [202BCCC..202BCCF]!!
.type SetActorCoords, %function 
.global SetActorCoords 
SetActorCoords:
push {lr} 
ldr r3, =MemorySlot
add r3, #4*0x0B 
ldr r2, =gActionStruct 
ldrh r0, [r3]
ldrh r1, [r3, #2]
strb r0, [r2, #0xE] @ XX ActionStruct 
strb r1, [r2, #0xF]
mov r3, #0 
strb r3, [r2, #0x10] @ tiles moved  
ldr r3, =UnitPos_BPress 
ldr r2, =ChapterData 
strh r0, [r3] @ actor dest 
strb r0, [r2, #0x12] @ cursor pos 
strh r1, [r3, #2] 
strb r1, [r2, #0x13] @ cursor pos 
ldr r3, =Attacker 
strb r0, [r3, #0x10] 
strb r1, [r3, #0x11] 

blh SetCursorMapPosition @ r0 = xx, r1 = yy 

@ldr r3, =CurrentUnit 
@ldr r3, [r3] 
@cmp r3, #0 
@beq Exit 

@ldr r0, [r3, #0x0C] @ state 
@mov r1, #0x42 
@orr r0, r1 
@str r0, [r3, #0x0C] @ acted 

ldr r1, =CurrentUnitFateData	@from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]

ldr r0, =gMoveMap 
ldr r0, [r0] 
mov r1, #0xFF
blh FillMap

ldr r0, =gUnitMap @ unit map 
ldr r0, [r0] 
mov r1, #0x0
blh FillMap
blh UpdateUnitMapAndVision 

blh MMS_EndAll 
 
pop {r0} 
bx r0 
.ltorg 

