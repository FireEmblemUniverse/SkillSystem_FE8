@ Intended to be called as ASMC. Arguments: none.
@ Every enemy within NearbyTiles tiles of nearest
@ ally or NPC will have their Danger Radius set.
.thumb

push  {r4-r7,r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r6, r0, #0x5
ldr   r0, =NearbyTiles
lsl   r0, #0x5
lsr   r0, #0x5
mov   r8, r0


@ Iterate over all enemy units.
mov   r4, #0x81
mov   r0, #0x0
mov   r9, r0

Loop:
  mov   r0, r4
  ldr   r2, =GetUnitStruct
  bl    GOTO_R2
  cmp   r0, #0x0
  beq   NextIteration

    ldr   r1, [r0]
    cmp   r1, #0x0
    beq   NextIteration
    
      @ Check if DR-bit already set.
      ldrb  r1, [r0, r5]
      tst   r1, r6
      bne   L1
    
        @ Iterate over all allies and NPCS.
        @ Check whether any is within
        @ NearbyTiles tiles of enemy.
        mov   r2, #0x10
        mov   r3, #0x11
        ldsb  r1, [r0, r3]
        ldsb  r0, [r0, r2]
        mov   r10, r0                                 @ Enemy X.
        mov   r11, r1                                 @ Enemy Y.
        mov   r7, #0x1
        
        Loop2:
          mov   r0, r7
          ldr   r2, =GetUnitStruct
          bl    GOTO_R2
          cmp   r0, #0x0
          beq   NextIteration2

            ldr   r1, [r0]
            cmp   r1, #0x0
            beq   NextIteration2
          
              @ Check if unit is nearby
              mov   r2, #0x10
              mov   r3, #0x11            
              ldsb  r1, [r0, r3]                      @ Ally or NPC Y.
              ldsb  r0, [r0, r2]                      @ Ally or NPC X.
              mov   r2, r10
              mov   r3, r11
              sub   r0, r2
              sub   r1, r3
              
              @ Take coordinates'
              @ absolute values.
              cmp   r0, #0x0
              bge   L2
                neg   r0, r0
              L2:
              cmp   r1, #0x0
              bge   L3
                neg   r1, r1
              L3:
              add   r0, r1
              cmp   r0, r8
              ble   L1                                @ Break.
          
          NextIteration2:
          add   r7, #0x1
          cmp   r7, #0x7F
          ble   Loop2
        b     NextIteration
      
      L1:
      @ Set DR-bit and increment DRCounter.
      mov   r1, #0x1
      add   r9, r1
      mov   r0, r4
      ldr   r2, =GetUnitStruct
      bl    GOTO_R2
      ldrb  r1, [r0, r5]
      orr   r1, r6
      strb  r1, [r0, r5]

  NextIteration:
  add   r4, #0x1
  cmp   r4, #0xBF
  ble   Loop


ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
mov   r1, r9
strb  r1, [r0]            @ Reset DRCountByte.

bl    InitializeDR


pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R2:
bx    r2
