@ Replaces MapMenuCommand_DangerZoneUnusedEffect.
@ No need to return anything; We're not used as menu command.
.thumb

push	{r4-r7,r14}

ldr   r0, =ActiveUnit
ldr   r7, [r0]
mov   r1, #0x0
str   r1, [r0]
ldr   r6, =GameState
mov   r5, r6
add   r5, #0x3E
strb  r1, [r5]

b L1 @ Never fow 

@ Check for FOW.
ldr   r0, =ChapterData
ldrb  r0, [r0, #0xD]
cmp   r0, #0x0
beq   L1

  @ FOW is active, let PlayerPhase proc handle it.
  ldr   r0, =Procs_PlayerPhase
  ldr   r4, =Find6C
  bl    GOTO_R4
  mov   r1, #0xC
  ldr   r4, =Goto6CLabel
  bl    GOTO_R4
  b     Return

L1:
  @ FOW not active, we handle it.
  @ Mimic PlayerPhase_DisplayDangerZone, 0x1CCB4.
  
  @ Update GameState.
  ldrb  r1, [r6, #0x4]
  mov   r0, #0x8
  orr   r0, r1
  mov   r1, #0xFD
  and   r0, r1
  strb  r0, [r6, #0x4]
  
  @ Apply Fog.
  ldr   r0, =FogMap
  ldr   r0, [r0]
  mov   r1, #0x0
  ldr   r4, =ClearMapWith
  bl    GOTO_R4
  ldrb  r1, [r5]
  mov   r0, #0x1
  and   r0, r1
  
  bl PokemblemGenerateDangerZoneRange
  @ldr   r4, =ApplyStuffToRangeMaps @FillRangeMapForDangerZone
  @bl    GOTO_R4
  ldr   r0, =MovementMap
  ldr   r0, [r0]
  mov   r1, #0x1
  neg   r1, r1
  ldr   r4, =ClearMapWith
  bl    GOTO_R4
  

  
  
  @ Set GameState and Active Unit back.
  ldrb  r1, [r6, #0x4]
  mov   r0, #0xF7 @ 0x08 : danger zone? viewing attack range?
  and   r0, r1
  strb  r0, [r6, #0x4]
  ldr   r0, =ActiveUnit
  str   r7, [r0]
  
  
  @@ Check GameState.
  @ldrb  r1, [r6, #0x4]
  @mov   r0, #0x8
  @and r0, r1 
  @cmp r0, #0 
  @bne Return @ Don't update graphics when turning DR off 
  @@ Only update if pressed select or used ASMC I guess 
  
  @ Update Game Tile Gfx.
  ldr		r4, =UpdateGameTilesGraphics
  bl		GOTO_R4




Return:




pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4

.equ	gMapRange, 0x0202E4E4
