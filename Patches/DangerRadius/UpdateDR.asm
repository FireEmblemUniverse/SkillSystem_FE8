@ this file is unused 

@ Hook at RefreshFogAndUnitMaps.
@ Updates the danger radius.
.thumb
	.equ MemorySlot,0x30004B8
push {r4-r7,r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}

mov r8, r8 
mov  r11, r11 
mov r8, r8 

ldr   r0, =ActiveUnit
ldr   r0, [r0]
ldrb r0, [r0, #0x0B] 
lsr r0, #5 @ only want top two bits 
cmp r0, #0
bne ResetRamBit @ NPC / Enemy 

ldr r2, =0x203A958 @ Action taken this turn 
ldrb r1, [r2, #0x11] @ Action taken this turn 
cmp r1, #0 @ No action taken yet so do DR stuff 
beq ResetRamBit 

ldr r2, =#0x30017bb @ DRSingleRam
ldrb r1, [r2]
cmp r1, #0 
bne OnlyRefreshVanillaStuff
mov r1, #1 
strb r1, [r2] 
b DR 

OnlyRefreshVanillaStuff:

ldr   r4, =UpdateTrapFogVision
bl    GOTO_R4
ldr   r4, =UpdateUnitMapAndVision
bl    GOTO_R4
ldr   r4, =UpdateTrapHiddenStates
bl    GOTO_R4

b Return

ResetRamBit:
ldr r2, =#0x30017bb @ DRSingleRam
mov r0, #0 
strb r0, [r2] 

@ Not using FOW so skip 
b DR @ Vesly

@@ Check for FOW.
@ldr   r0, =ChapterData
@ldrb  r0, [r0, #0xD]
@cmp   r0, #0x0
@beq   DR
@
@  @ FOW active, vanilla behaviour.
@  ldr   r0,=FogMap
@  ldr   r0,[r0]
@  mov   r1,#0x0
@  ldr   r4, =ClearMapWith
@  bl    GOTO_R4
@  ldr   r4, =UpdateTrapFogVision
@  bl    GOTO_R4
@  ldr   r4, =UpdateUnitMapAndVision
@  bl    GOTO_R4
@  ldr   r4, =UpdateTrapHiddenStates
@  bl    GOTO_R4
@  b     Return

@ Check whether we should update Danger Radius or not.
@ Is DR active?
DR:

ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldrb  r2, [r5]
cmp   r2, #0x0
beq   NoDR


  @ Are we on playerphase?
  @ If not, turn off DR 
  ldr   r2, =ChapterData
  ldrb  r2, [r2, #0xF]
  cmp   r2, #0x0
  bne   NoDR
    
    @ None of the above.
    b     L1


NoDR:
@ Danger Radius not active/We're not playerphase/No enemies present.
@ Disable DR if it wasn't yet.
mov   r0, #0x0
strb  r0, [r5]

@ Iterate over all enemy units and unset DR-bit.
ldr   r4, =GetUnitStruct
mov   r6, #0x81
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r7, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r0, #0x5
mvn   r0, r0
mov   r8, r0

Loop:


  mov   r0, r6
  ldr   r4, =GetUnitStruct
  bl    GOTO_R4
  cmp   r0, #0x0
  beq   NextIteration

    ldr    r1, [r0]
    cmp    r1, #0x0
    beq    NextIteration

      ldrb  r1, [r0, r7]
      mov   r2, r8
      and   r1, r2
      strb  r1, [r0, r7]

  NextIteration:
  add    r6, #0x1
  cmp    r6, #0xBF
  ble    Loop

ldr   r0, =FogMap
ldr   r0, [r0]
mov   r1, #0x0
ldr   r4, =ClearMapWith
bl    GOTO_R4


L1:
@ Previously overwritten.
@ Fog is either present or not present.
@ Not using fog so sure 
@ldr   r4, =UpdateTrapFogVision
@bl    GOTO_R4
ldr   r4, =UpdateUnitMapAndVision
bl    GOTO_R4
ldr   r4, =UpdateTrapHiddenStates
bl    GOTO_R4

@ Active unit isn't on the gMapUnit map, so this puts them there 
@ Eg. without this part, it will display as if the enemy can walk through 
@ you whenever you select anywhere 

@ Re-add active unit to gMapUnit to update DR during movement.
@ Check if there is an active unit.
ldr   r0, =ActiveUnit
ldr   r1, [r0]
cmp   r1, #0x0
beq   L2

  @ Check if active unit is NPC or enemy.
  ldrb  r0, [r1, #0xB]
  mov   r2, #0xC0
  tst   r0, r2
  bne   L2

    @ Check if active unit died/retreated.
    ldrb  r0, [r1, #0xC]
    mov   r2, #0xC
    tst   r0, r2
    bne   L2

      @ Calculate active unit's location.
      ldrb  r0, [r1, #0x10]                     @ X-coordinate.
      ldrb  r2, [r1, #0x11]                     @ Y-coordinate.
      lsl   r2, #0x2                            @ Quadruple for row pointers.
      ldrb  r1, [r1, #0XB]                      @ Deployment slot.
      ldr   r3, =UnitMap
      ldr   r3, [r3]
      ldr   r3, [r3, r2]                        @ Go to Y-coordinate.
      add   r3, r0                              @ Go to X-coordinate.

      @ 'Overflow' check. Make sure we're still in gMapUnitPool.
      ldr   r0, =gMapTerrainPool
      cmp   r3, r0
      bge   L2

        @ Re-add active unit.
        strb  r1, [r3]


@ Repeat check whether we should update DR or not.
@ Is DR active?
L2:
ldrb  r0, [r5] 
cmp   r0, #0x0
beq   Return

  @ Are we on playerphase?
  ldr   r0, =ChapterData
  ldrb  r0, [r0, #0xF]
  cmp   r0, #0x0
  bne   Return

    @ Re-enable DR.
    ldr   r0, =FogMap
    ldr   r0, [r0]
    mov   r1, #0x0
    ldr   r4, =ClearMapWith
    bl    GOTO_R4
    bl    InitializeDR


@ Re-update in case active unit needs to be removed from gMapUnit again.
ldr   r0, =UnitMap
ldr   r0, [r0]
mov   r1, #0x0
ldr   r4, =ClearMapWith
bl    GOTO_R4

ldr   r0, =HiddenMap
ldr   r0, [r0]
mov   r1, #0x0
ldr   r4, =ClearMapWith
bl    GOTO_R4

ldr   r4, =UpdateTrapFogVision
bl    GOTO_R4
ldr   r4, =UpdateUnitMapAndVision
bl    GOTO_R4
ldr   r4, =UpdateTrapHiddenStates
bl    GOTO_R4



Return:

mov r8, r8 
mov r8, r8 
@mov  r11, r11 
mov r8, r8 

pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
