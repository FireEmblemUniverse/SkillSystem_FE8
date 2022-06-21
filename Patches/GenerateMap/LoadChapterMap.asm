.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

PUSH {r4,r5,r6,lr}   //LoadChapterMap LoadChapterMap
MOV r4 ,r0
MOV r6 ,r1
MOV r0 ,r6
blh 0x08034640   //Examine address of stage map mapdata
push {r0} 
MOV r1 ,r4
cmp r6, #0x58
beq Skip
pop {r0} 
blh 0x08012F50   //UnLZ77Decompress
b Skip2 
Skip: 
mov r1, r4 @ destination 
pop {r0} @ source 
blh 0x08012F50   //UnLZ77Decompress

mov r0, r4 
blh DebugMap_ASMC

Skip2: 
LDR r5, =0x202E4D4 @  # pointer:080198FC -> 0202E4D4 (gMapSize )
LDRB r0, [r4, #0x0]
STRH r0, [r5, #0x0]   //gMapSize
LDRB r0, [r4, #0x1]
STRH r0, [r5, #0x2]   //MapSize@MapSize.Height
ldr r4, =0x8019900
ldr r4, [r4]  @ # pointer:08019900 -> 0913892C (map_config_address )
MOV r0 ,r6
blh 0x08034618   //GetChapterDefinition r0=Address of map setting r0=map ID you want to examine:MAPCHAPTER
LDRB r0, [r0, #0x7]
LSL r0 ,r0 ,#0x2
ADD r0 ,r0, R4
LDR r0, [r0, #0x0] @ pointer:0913892C (map_config_address ) -> 00000000
LDR r1, =0x2030B8C @ (gTileConfigBuffer )
blh 0x08012F50   //UnLZ77Decompress
ldr r1, =0x202BCB0 @ (BattleMapState@gGameState.boolMainLoopEnded )
MOV r2, #0x0
LDSH r0, [r5, r2] @ pointer:0202E4D4 (gMapSize )
LSL r0 ,r0 ,#0x4
SUB r0, #0xF0
STRH r0, [r1, #0x28]   //gSomeRealCameraOffsetTarget
MOV r2, #0x2
LDSH r0, [r5, r2] @ pointer:0202E4D6 (MapSize@MapSize.Height )
LSL r0 ,r0 ,#0x4
SUB r0, #0xA0
STRH r0, [r1, #0x2A]
POP {r4,r5,r6}
POP {r0}
BX r0

.ltorg 
