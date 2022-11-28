@ Updates DR after moving a unit and before committing to an action.
.thumb

push {r4-r7, r14}



@ Check if unit moved
ldr   r4, =ActionData
ldr   r5, =ActiveUnit
ldr   r5, [r5]
ldrb  r6, [r4, #0xE]
ldrb  r7, [r5, #0x10]
ldrb  r2, [r4, #0xF]
ldrb  r3, [r5, #0x11]
strb  r6, [r5, #0x10]           @ Vanilla updates
strb  r2, [r5, #0x11]           @ these values like this.

mov r0, r6 @ x1 
mov r1, r2 @ y1 
mov r2, r7 @ x2
sub   r0, r2 @ X difference 
sub   r1, r3 @ Y difference 

@ Take coordinates'
@ absolute values.				
asr r3, r0, #31
add r0, r0, r3
eor r0, r3

asr r3, r1, #31
add r1, r1, r3
eor r1, r3

add r0, r1 
strb r0, [r4, #0x10] @ tiles moved in ActionData to be updated for LineOfSight 


mov r0, r6 
mov r1, r7 
ldrb  r2, [r4, #0xF]
ldrb  r3, [r5, #0x11]

mov   r6, #0x0
cmp   r0, r1
bne   L3
  cmp   r2, r3
  bne   L3
    b     L4
L3:
mov   r6, #0x1
L4:


@ Vanilla.
mov   r0, r5
ldr   r4, =ApplyUnitMovement
bl    GOTO_R4


@ Skip if unit didn't move.
cmp   r6, #0x0
beq   Return
  @ Check for FOW.
  ldr   r0, =ChapterData
  ldrb  r0, [r0, #0xD]
  cmp   r0, #0x0
  bne   Return
    @ Is DR active?
    ldr   r0, =DRCountByte
    lsl   r0, #0x5
    lsr   r0, #0x5
    ldrb  r0, [r0]
    cmp   r0, #0x0
    beq   Return
    
      @ Update DR mid-action.
      @ Re-add active unit to gMapUnit to update DR during movement.
      @ Check if active unit is NPC or enemy.
      ldrb  r0, [r5, #0xB]
      mov   r2, #0xC0
      tst   r0, r2
      bne   L2

        @ Check if active unit died/retreated.
        ldrb  r0, [r5, #0xC]
        mov   r2, #0xC
        tst   r0, r2
        bne   L2

          @ Calculate active unit's location.
          ldrb  r0, [r5, #0x10]                     @ X-coordinate.
          ldrb  r2, [r5, #0x11]                     @ Y-coordinate.
          lsl   r2, #0x2                            @ Quadruple for row pointers.
          ldrb  r1, [r5, #0xB]                      @ Deployment slot.
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
            
            @ Re-enable DR.
            ldr   r0, =FogMap
            ldr   r0, [r0]
            mov   r1, #0x0
            ldr   r4, =ClearMapWith
            bl    GOTO_R4
            bl    InitializeDR
            
            @ Remove active unit from unit map again.
            ldr   r0, =UnitMap
            ldr   r0, [r0]
            mov   r1, #0x0
            ldr   r4, =ClearMapWith
            bl    GOTO_R4
            ldr   r4, =UpdateUnitMapAndVision
            bl    GOTO_R4


      @ Re-fill active unit's movement map based on previous coordinates.
      @ Mimics FillMovementMapForUnitAndMovement, 0x1A3CC.
      ldr   r0, =MovementMap
      ldr   r0, [r0]
      mov   r1, #0x1
      neg   r1, r1
      ldr   r4, =ClearMapWith
      bl    GOTO_R4
      
      @ Check if Modular Stat Getters exist.
      ldr   r1, =MSG
      lsl   r1, #0x5
      lsr   r1, #0x5
      cmp   r1, #0x0
      beq   L1
      
        @ MSG defined, get mov.
        mov   r0, r5
        ldr   r4, =prGotoMovGetter
        bl    GOTO_R4
        mov   r7, r0
        b     L2
      
      L1:
      
        @ MSG not defined, calc mov.
        @ Mimics 0x1CB76.
        ldr   r1, [r5, #0x4]
        ldrb  r1, [r1, #0x12]                     @ Class movement.
        ldrb  r2, [r5, #0x1D]                     @ Movement bonus.
        add   r1, r2
        ldr   r2, =ActionData
        ldrb  r2, [r2, #0x10]                     @ Squares moved.
        sub   r7, r1, r2
      
      L2:
      lsl   r7, r7, #0x18
      lsr   r7, r7, #0x18
      mov   r0, r5
      ldr   r4, =GetUnitMovCostTable
      bl    GOTO_R4
      ldr   r4, =SetMovCostTable
      bl    GOTO_R4

      ldr   r1, =gActiveUnitPosition
      ldrh  r0, [r1]                              @ original x-coord.
      ldrh  r1, [r1, #0x2]                        @ original y-coord.
      mov   r3, #0xB
      ldsb  r3, [r5, r3]                          @ deployment byte.
      mov   r2, r7                                @ movement.
      ldr   r4, =MapFillMovement
      bl    GOTO_R4


Return:
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
