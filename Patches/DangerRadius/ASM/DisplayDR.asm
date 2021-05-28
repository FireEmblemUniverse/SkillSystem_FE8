@ Called at 0x1B870. Adds an extra check to this loop, checking the DR-bit,
@ to determine whether or not to display this unit's Danger Radius.
.thumb


@ Check for FOW.
ldr   r1, =ChapterData
ldrb  r1, [r1,#0xD]
cmp   r1, #0x0
bne   L1

  @ Check if we're called by DangerRadius
  @ Or something else (like CheckInDanger ASMC)
  ldr   r1, =GameState
  ldrb  r1, [r1, #0x4]
  mov   r2, #0x8
  tst   r1, r2
  beq   L2

    @ Check if Unit's DR-bit is set.
    ldr   r1, =DRUnitByte
    lsl   r1, #0x5
    lsr   r1, #0x5
    ldr   r2, =DRUnitBitMask
    lsl   r2, #0x5
    lsr   r2, #0x5
    ldrb  r3, [r0, r1]
    tst   r3, r2
    bne   L2
    
      @ DR-bit not set,
      @ Return to next iteration.
      ldr   r1, =0x801B931
      mov   r14, r1
      b     Return
  
  @ DR-bit set or not called by DangerRadius
  @ Return to next check.
  L2:
  ldr   r1, =0x801B88F
  mov   r14, r1
  b     Return

@ Vanilla behaviour if FOW set.
L1:
mov   r1, #0x11
ldsb  r1, [r0, r1]
ldr   r0, =FogMap
ldr   r0, [r0]
lsl   r1, #0x2
add   r0, r1

Return:
bx		r14
