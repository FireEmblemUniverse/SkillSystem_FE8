@ Fill in FogMap or SubjectMap.
@ Seems like ItemRangeFix reserves r12,
@ So make sure it's not used!
.thumb

push  {r4-r7,r14}
lsl   r4, r0, #0x2
mov   r5, r1


@ Check for FOW.
ldr   r0, =ChapterData
ldrb  r0, [r0, #0xD]
cmp   r0, #0x0
bne   Vanilla

  @ Check if GameState DR-bit set.
  ldr   r0, =GameState
  ldrb  r0, [r0, #0x4]
  mov   r1, #0x8
  tst   r1, r0
  beq   Vanilla


@ New loop, storing values in FogMap.
ldr   r6, =FogMap

Loop:
  ldr   r0, [r6]
  ldr   r1, [r0, r4]
  mov   r0, #0x1
  strb  r0, [r1, r2]
  add   r2, #0x1
  cmp   r2, r3
  blt   Loop

b     Return


@ Original loop, storing values in SubjectMap.
Vanilla:
ldr   r6, =SubjectMap

Loop2:
  ldr   r0, [r6]
  ldr   r1, [r0, r4]
  ldrb  r0, [r1, r2]
  add   r0, r5
  strb  r0, [r1, r2]
  add   r2, #0x1
  cmp   r2, r3
  blt   Loop2


Return:
mov   r0, r3
pop   {r4-r7}
pop   {r1}
bx    r1
