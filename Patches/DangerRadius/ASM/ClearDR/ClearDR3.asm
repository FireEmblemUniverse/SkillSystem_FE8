@ Clear DRCountByte when units are cleared.
@ Replaces ClearUnits, 0x177C4.
.thumb

push  {r4-r7,r14}


@ Clear DRCountByte.
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
mov   r1, #0x0
strb  r1, [r0]


@ Vanilla.
ldr   r4, =ClearUnitStruct
mov   r5, #0x0
ldr   r7, =RAMSlotTable

Loop:
  lsl   r0, r5, #0x2
  ldr   r6, [r0, r7]
  cmp   r6, #0x0
  beq   L1
  
    mov   r0, r6
    bl    GOTO_R4
    strb  r5, [r6, #0xB]
    
  L1:
  add   r5, #0x1
  cmp   r5, #0xFF
  ble   Loop


pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
