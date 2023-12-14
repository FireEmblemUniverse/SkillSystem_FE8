@ Recalc DR when cancelling a move.
@ Hooked at 0x1D014
@   r2: 0202BE48, gActiveUnitPosition
.thumb

push  {r4-r6, r14}
mov   r4, r2
ldr   r5, =ActiveUnit
ldr   r5, [r5]


ldrh  r0, [r4]
ldrb  r1, [r5, #0x10]
ldrh  r2, [r4, #0x2]
ldrb  r3, [r5, #0x11]
strb  r0, [r5, #0x10]           @ Vanilla updates
strb  r2, [r5, #0x11]           @ these values like this.
mov   r6, #0x0
cmp   r0, r1
bne   L2
  cmp   r2, r3
  bne   L2
    b     L3
L2:
mov   r6, #0x1
L3:


@ Vanilla.
mov   r0, r5
ldr   r4, =ApplyUnitMovement
bl    GOTO_R4
ldr   r0, [r5, #0xC]
mov   r1, #0x2
bic   r0, r1
str   r0, [r2, #0xC]


@ Skip if unit didn't move.
cmp   r6, #0x0
beq   Return


ldr   r4, =RefreshFogAndUnitMaps
bl    GOTO_R4

@ Recalc DR if it's active.
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
ldrb  r0, [r0]
cmp   r0, #0x0
beq   L1

  @ Re-add active unit to gMapUnit to update DR during movement.
  @ Calculate active unit's location.
  ldr   r1, =ActiveUnit
  ldr   r1, [r1]
  ldrb  r0, [r1, #0x10]                     @ X-coordinate.
  ldrb  r2, [r1, #0x11]                     @ Y-coordinate.
  lsl   r2, #0x2                            @ Quadruple for row pointers.
  ldrb  r1, [r1, #0xB]                      @ Deployment slot.
  ldr   r3, =UnitMap
  ldr   r3, [r3]
  ldr   r3, [r3, r2]                        @ Go to Y-coordinate.
  add   r3, r0                              @ Go to X-coordinate.

  @ 'Overflow' check. Make sure we're still in gMapUnitPool.
  ldr   r0, =gMapTerrainPool
  cmp   r3, r0
  bge   L1

    @ Re-add active unit.
    strb  r1, [r3]
    
    @ Calculate DR
    bl    InitializeDR
    
    @ Remove active unit from unit map again.
    ldr   r0, =UnitMap
    ldr   r0, [r0]
    mov   r1, #0x0
    ldr   r4, =ClearMapWith
    bl    GOTO_R4
    ldr   r4, =UpdateUnitMapAndVision
    bl    GOTO_R4
	
	@ to fix canto+ purple squares 
	ldr r0, =0x202e4e4 @ range map 
	ldr r0, [r0] 
	mov   r1, #0x0
    ldr   r4, =ClearMapWith
	bl    GOTO_R4
    b     Return
    
L1:

ldr   r4, =UpdateGameTilesGraphics
bl    GOTO_R4


Return:
pop   {r4-r6}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
