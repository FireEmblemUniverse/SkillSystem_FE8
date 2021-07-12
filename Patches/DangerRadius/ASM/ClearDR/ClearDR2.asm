@ Remove DR from an enemy that died after map battle.
@ Hooks at 0x18400, in Phantom_Check. Replaces the routine.
@ Also checks if unit is being captured.
@
@ Structure:
@ if Unit == Ally
@   if Unit == phantom
@     Clear UnitPointer
@   else
@     Kill Unit
@     Clear Supports
@ else
@   if Unit == Enemy
@     Clear DR
@   if Unit is captured
@     Kill Unit
@     Clear Supports
@   else
@     Clear UnitPointer
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


@ Check if unit is Ally.
ldrb  r1, [r2, #0xB]
mov   r0, #0xC0
tst   r1, r0
bne   L1

  @ Unit is Ally.
  @ Check if unit is phantom.
  ldr   r0, [r2, #0x4]
  ldrb  r0, [r0, #0x4]
  cmp   r0, #0x51
  beq   ClearUnitPointer

    @ Unit is Ally and not phantom.
    @ Kill unit.
    b   KillUnit

@ Check if unit is Enemy.
L1:
mov   r0, #0x80
tst   r1, r0
beq   L2

  @ Unit is Enemy.
  @ Check if DR-bit is set.
  ldrb  r1, [r2, r5]
  tst   r1, r6
  beq   L2
  
    @ DR-bit is set.
    @ Unset and decrement DR counter.
    eor   r1, r6
    strb  r1, [r2, r5]
    ldrb  r1, [r7]
    sub   r1, #0x1
    strb  r1, [r7]

@ Unit is Enemy or NPC.
@ Check if rescued (technically captured).
L2:
ldr   r0, [r2, #0xC]
mov   r1, #0x20
tst   r0, r1
beq   ClearUnitPointer

  @ Unit is captured.
  @ Kill unit.
  @b     KillUnit


KillUnit:
// check if flag is on or not lol 
ldr   r0, [r2, #0xC]
mov   r1, #0x9 		@ prev 0x05 for dead, 0x09 is undeployed 
orr   r0, r1
str   r0, [r2, #0xC]
mov   r0, r2
@ldr   r4, =ClearUnitSupports	@ No need to clear on casual mode 
@bl    GOTO_R4
b     Return

  ClearUnitPointer:
  mov   r0, #0x0
  str   r0, [r2]


Return:
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
