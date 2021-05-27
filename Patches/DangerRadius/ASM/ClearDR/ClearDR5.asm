@ Hooked at 0x18438, HandleAllegianceChange. Decrements DRCountByte
@ and unsets DR-bit if unit switching allegiances is enemy.
.thumb

push  {r4-r7,r14}
mov   r5, r0
mov   r6, r1
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r4, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r7, r0, #0x5
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r3, r0, #0x5


@ Check if unit is enemy.
ldrb  r0, [r5, #0xB]
mov   r1, #0x80
tst   r0, r1
beq   L1

  @ Check if DR-bit is set.
  ldrb  r0, [r5, r4]
  tst   r0, r7
  beq   L1
  
    @ DR-bit is set.
    @ Unset and decrement DR counter.
    eor   r0, r7
    strb  r0, [r5, r4]
    ldrb  r0, [r3]
    sub   r0, #0x1
    strb  r0, [r3]


@ Vanilla.
L1:
mov   r0, r6
ldr   r4, =GetNextFreeUnitStructPtr
bl    GOTO_R4
mov   r4, r0

ldr   r1, =ActiveUnit
ldr   r0, [r1]
cmp   r0, r5
bne   L2
  str   r4, [r1]
L2:


mov   r0, r4
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
