@ Remove DR from a unit that's being cleared.
@ Hooked at 0x177F8, in ClearUnitStruct, replaces this routine.
.thumb

push  {r4-r7,r14}
sub   sp, #0x4
ldr   r1, =DRUnitByte
lsl   r1, #0x5
lsr   r5, r1, #0x5
ldr   r1, =DRUnitBitMask
lsl   r1, #0x5
lsr   r6, r1, #0x5
ldr   r1, =DRCountByte
lsl   r1, #0x5
lsr   r7, r1, #0x5


@ Check if unit is Enemy.
ldrb  r1, [r0, #0xB]
mov   r1, #0x80
tst   r1, r0
beq   L1

  @ Unit is Enemy.
  @ Check if DR-bit is set.
  ldrb  r1, [r0, r5]
  tst   r1, r6
  beq   L1
  
    @ DR-bit is set.
    @ Unset and decrement DR counter, if it's
    @ not 0 (which it can be due to this routine
    @ being called upon loading a suspend save).
    eor   r1, r6
    strb  r1, [r0, r5]
    ldrb  r1, [r7]
    cmp   r1, #0x0
    beq   L1
      sub   r1, #0x1
      strb  r1, [r7]


@ Vanilla, clear RAM unit struct, except for allegiance byte.
L1:
mov   r4, r0
ldrb  r5, [r4, #0xB]
mov   r0, #0x0
strh  r0, [sp]
ldr   r2, =0x1000024
mov   r0, sp
mov   r1, r4
swi   0xB                       @ CpuSet
strb  r5, [r4, #0xB]


add   sp, #0x4
pop   {r4-r7}
pop   {r0}
bx    r0
