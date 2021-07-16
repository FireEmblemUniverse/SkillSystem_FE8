@ Updates DR after moving a unit and before committing to an action.
.thumb

push {r4-r7,r14}


@ Vanilla.
ldr   r5, =ActiveUnit
ldr   r5, [r5]
mov   r0, r5
ldr   r4, =ApplyUnitMovement
bl    GOTO_R4
@b NoDR

@ Check for FOW.
ldr   r0, =ChapterData
ldrb  r0, [r0, #0xD]
cmp   r0, #0x0
bne   NoDR

  @ Update DR mid-action.
  @ RefreshFogAndUnitMaps is hooked to do DetermineDR and InitializeDR etc. 
  ldr   r4, =RefreshFogAndUnitMaps
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


@ Vanilla.
NoDR:
ldr   r0, [r5, #0xC]
mov   r1, #0x40
and   r0, r1


pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
