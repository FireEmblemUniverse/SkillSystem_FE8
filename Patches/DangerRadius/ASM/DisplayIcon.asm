@ Applies DR-Icon if DR-bit is set.
.thumb

push  {r4-r7,r14}
mov   r4, r0                    @ RAM Unit Struct.
mov   r5, r2                    @ ROM Unit Data.
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r6, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r7, r0, #0x5


@ Check whether FOW is active.
ldr   r0, =ChapterData
ldrb  r0, [r0, #0xD]
cmp   r0, #0x0
bne   Return

  @ Check whether NPC.
  ldrb  r0, [r4, #0xB]
  mov   r1, #0x40
  tst   r0, r1
  bne   Return
  
    @ Do not display icon if unit ID 0xF0 or greater.
  ldr 	r1, [r4] 
  ldrb  r0, [r1, #0x4]
  cmp 	r0, #0xF0 
  bge   Return

    @ Check whether DR-bit is set.
    ldrb  r0, [r4, r6]
    tst   r0, r7
    beq   Return

      @ Draw DR-Icon
      mov   r1, #0x10
      ldsb  r1, [r4, r1]          @ X-Coordinate.
      lsl   r1, r1, #0x4          @ Multiplied by 16 (maptiles are 16 by 16).
      ldr   r2, =GameState
      mov   r0, #0xC
      ldsh  r0, [r2, r0]          @ gCurrentRealCameraPos, lower short (seems X related).
      sub   r3, r1, r0            @ Subtract Xcamera pos from X-coordinate.
      mov   r0, #0x11
      ldsb  r0, [r4, r0]          @ Y-Coordinate.
      lsl   r0, r0, #0x4          @ Multiplied by 16.
      mov   r1, #0xE
      ldsh  r1, [r2, r1]          @ gCurrentRealCameraPos, higher short (seems Y related).
      sub   r2, r0, r1            @ Subtract Ycamera pos from Y-coordinate.
      mov   r1, r3
      add   r1, #0x10
      mov   r0, #0x80
      lsl   r0, r0, #0x1
      cmp   r1, r0                @ Off-screen, perhaps.
      bhi   Return
        mov   r0, r2
        add   r0, #0x10
        cmp   r0, #0xB0           @ Off-screen, perhaps.
        bhi   Return
          ldr   r0, =0x209
          add   r0, r3            @ X += #0x209 vanilla sets bit 9, despite...
          ldr   r1, =0x1FF
          and   r0, r1            @ X &= #0x1FF ...this mask zeroing it.
          ldr   r1, =0x100
          add   r1, r2            @ Y += #0x10F vanilla sets bit 8, despite...
          mov   r2, #0xFF
          and   r1, r2            @ Y &= #0xFF  ...this mask zeroing it.
          ldr   r2, =OAM8x8
          ldr   r3, =0x865        @ Icon location and priority=2.
          ldr   r6, =PushToSecondaryOAM
          bl    GOTO_R6


@ Overwritten stuff
Return:
ldr   r0, [r4, #0x4]            @ Class data.
ldr   r1, [r5, #0x28]           @ Character ability 1-4.
ldr   r0, [r0, #0x28]           @ Class ability 1-4.
orr   r1, r0
mov   r0, #0x80                 @ Boss Icon.
lsl   r0, r0, #0x8
tst   r1, r0
beq   L1

  @ Return to 0x27950
  ldr   r0, =0x8027951
  str   r0, [sp, #0x10]


L1:
mov   r0, r5                    @ Return ROM Unit Data pointer.
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R6:
bx    r6
