
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ MemorySlot,0x30004B8
.equ gActionStruct, 0x203A958
.equ MMS_EndAll, 0x80790a4
.equ BattleMapState, 0x202BCB0 
.equ ChapterData, 0x202BCF0 
.equ UnitPos_BPress, 0x202BE48 
.equ CurrentUnit, 0x3004E50
.equ CurrentUnitFateData, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ gMoveMap, 0x202E4E0 
.equ FillMap, 0x080197E4	
.equ UpdateUnitMapAndVision, 0x8019FA0 
.equ HandleCursorMovement, 0x8015714 
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
ldr r3, =BattleMapState
strb r0, [r2, #0xE] @ XX ActionStruct 
strh r0, [r3, #0x14] @ XX 
strb r1, [r2, #0xF]
strh r1, [r3, #0x16] @ YY cursor pos 
@strh r0, [r3, #0x18] @ XX prev pos 
@strh r1, [r3, #0x1A] @ YY prev pos 
@strh r0, [r3, #0x10] 
@strh r1, [r3, #0x12] 
@strh r0, [r3, #0x24] 
@strh r1, [r3, #0x26] 


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

ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq Exit 




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

ldr r0, =0x202E4D8 @ unit map 
ldr r0, [r0] 
mov r1, #0x0
blh FillMap
blh UpdateUnitMapAndVision 

mov r0, #0 
@blh HandleCursorMovement 

blh MMS_EndAll 

Exit: 
pop {r0} 
bx r0 
.ltorg 

@struct BattleMapState {
@	/* 00 */ u8 boolMainLoopEnded; // Used by vblank handler to detect "lag"
@	/* 01 */ u8 proc2LockCount;
@	/* 02 */ u8 gfxLockCount;
@	/* 03 */ u8 _unk03;
@	/* 04 */ u8 statebits; // TODO: enumerate bits
@	/* 06 */ u16 savedVCount;
@	/* 08 */ u32 _unk08;
@	/* 0C */ struct Vec2u cameraRealPos;
@	/* 10 */ struct Vec2u _unk10;
@	/* 14 */ struct Vec2u cursorMapPos;
@	/* 18 */ struct Vec2u cursorMapPosPrev;
@	/* 1C */ struct Vec2u _unk1C;
@	/* 20 */ struct Vec2u cursorDisplayRealPos;
@	/* 24 */ struct Vec2 _unk24;
@	/* 28 */ u8 _pad28[0x3C - 0x28];
@	/* 3C */ u8 boolHasJustResumed;
@	/* 3D */ u8 partialActionTaken; // bits
@};


