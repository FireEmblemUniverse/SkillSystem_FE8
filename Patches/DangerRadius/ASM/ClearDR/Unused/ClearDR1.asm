@ Remove DR from an enemy that died after animated battle.
@ Hooks at 0x32808, in BATTLE_ProbablyMakesTheDeadUnitDissapear (sic).
@ Unused, because there's a hook that works for both map and animated battle.
.thumb

push  {r4-r7,r14}
ldr   r1, =DRUnitByte
lsl   r1, #0x5
lsr   r5, r1, #0x5
ldr   r1, =DRUnitBitMask
lsl   r1, #0x5
lsr   r6, r1, #0x5
ldr   r1, =DRCountByte
lsl   r1, #0x5
lsr   r7, r1, #0x5


@ If unit is not enemy, return.
ldrb  r1, [r0, #0xB]
mov   r2, #0x80
tst   r1, r2
beq   Return

  @ Check if DR-bit is set.
  ldrb  r1, [r0, r5]
  tst   r1, r6
  beq   Return
  
    @ DR-bit is set.
    @ Unset and decrement DR counter.
    eor   r1, r6
    strb  r1, [r0, r5]
    ldrb  r1, [r7]
    sub   r1, #0x1
    strb  r1, [r7]

Return:
ldr   r1, [r0, #0xC]
mov   r2, #0x1
orr   r1, r2
str   r1, [r0, #0xC]
ldr   r4, =TryRemoveUnitFromBallista
bl    GOTO_R4


pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
