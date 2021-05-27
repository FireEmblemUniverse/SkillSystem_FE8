@ Intended to be called as ASMC. Arguments: UnitID.
@ Unsets the Danger Radius for unitID in mem slot 0x2
@ or unit of coord xxyy in mem slot 0xB.
.thumb

push  {r4-r7,r14}
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r6, r0, #0x5
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r7, r0, #0x5


@ Get argument.
ldr		r0, =Slot0+0x8
ldr		r0, [r0]
ldr		r4, =GetUnitStructFromEventParameter
bl		GOTO_R4


@ Check if enemy unit.
ldrb	r1, [r0, #0xB]
mov		r2, #0x80
tst		r1, r2
beq		L1

  @ Check if DR-bit is set.
  ldrb  r1, [r0, r5]
  tst   r1, r6
  beq   L1
  
    @ DR-bit set.
    @ Unset DR-bit, decrement DR counter.
    eor   r1, r6
    strb  r1, [r0, r5]
    ldrb  r0, [r7]
    sub   r0, #0x1
    strb  r0, [r7]
    
L1:
ldr		r4, =RefreshFogAndUnitMaps
bl		GOTO_R4
ldr		r4, =UpdateGameTilesGraphics
bl    GOTO_R4


pop   {r4-r7}
pop		{r0}
bx		r0
GOTO_R4:
bx		r4
