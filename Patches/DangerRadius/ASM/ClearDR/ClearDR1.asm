@ Remove DR from an enemy that died after battle.
@ Hooks at 0x18400, in Phantom_Check.
@ Also implements Capture's Should_Dead_Unit_Be_Cleared.
@   r2: killed unit's struct.
.thumb

push  {r4-r6}
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r4, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r6, r0, #0x5


@ Check if unit is Enemy.
mov   r0, #0x80
ldrb  r1, [r2, #0xB]
tst   r1, r0
beq   L1

  @ Unit is Enemy.
  @ Check if DR-bit is set.
  ldrb  r1, [r2, r4]
  tst   r1, r5
  beq   L1
  
    @ DR-bit is set.
    @ Unset and decrement DR counter.
    eor   r1, r5
    strb  r1, [r2, r4]
    ldrb  r1, [r6]
    sub   r1, #0x1
    strb  r1, [r6]
L1:


@ Should_Dead_Unit_Be_Cleared.
@ Return 0 if unit should not be cleared,
@ anything else if they should.
ldrb	r1,[r2,#0xB]
mov		r0,#0xC0
and		r1,r0
cmp		r1,#0
beq		GoBack		@ Player units don't get cleared.
ldr		r0,[r2,#0xC]
mov		r3,#0x20	@ Being rescued.
tst		r0,r3
beq		GoBack
mov		r1,#0
GoBack:
pop   {r4-r6}
ldr		r0,=#0x8018409
bx		r0
