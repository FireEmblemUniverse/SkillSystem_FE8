@ Intended to be called as ASMC. Arguments: none.
@ Unsets every enemy's Danger Radius.
.thumb

push  {r4-r7,r14}
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r6, r0, #0x5
mvn   r6, r6


@ Iterate over all enemy units and unset DR-bit.
ldr   r4, =GetUnitStruct
mov   r7, #0x81

Loop:
  mov   r0, r7
  bl    GOTO_R4
  cmp   r0, #0x0
  beq   NextIteration

    ldr   r1, [r0]
    cmp   r1, #0x0
    beq   NextIteration

      @ Unset DR-bit
      ldrb  r1, [r0, r5]
      and   r1, r6
      strb  r1, [r0, r5]

  NextIteration:
  add   r7, #0x1
  cmp   r7, #0xBF
  ble   Loop


ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
mov   r1, #0x0
strb  r1, [r0]            @ Reset DRCountByte.

ldr   r4, =RefreshFogAndUnitMaps
bl    GOTO_R4
ldr		r4, =UpdateGameTilesGraphics
bl    GOTO_R4


pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
