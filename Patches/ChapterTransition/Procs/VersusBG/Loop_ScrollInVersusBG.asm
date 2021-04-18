.thumb

push  {r4-r7, r14}
mov   r4, r0

@ Increment BG1HOFS
ldr   r0, =gpDISPCNTbuffer                @ DISPCNT
mov   r1, #0x24
ldrb  r2, [r0, r1]                        @ BG2HOFS
mov   r6, r2
add   r2, #0x10
strb  r2, [r0, r1]

lsl   r7, r2, #0x18
lsr   r7, #0x18


@ Update TSA
ldr   r1, =gpBG2MapBuffer
mov   r5, #0xE0
lsl   r5, #0x8                            @ Palette
lsr   r2, r6, #0x3
add   r2, #0x1E
lsl   r2, #0x1B
lsr   r2, #0x1B
lsl   r3, r2, #0x1
add   r1, r3
mov   r3, #0x80
mov   r6, #0x1
lsl   r6, #0x8
sub   r6, #0x1                            @ BGTileSize

Loop:
  add   r0, r3, r2
  add   r0, r5
  strh  r0, [r1]
  add   r3, #0x1
  add   r1, #0x2
  
  add   r0, r3, r2
  add   r0, r5
  strh  r0, [r1]
  add   r1, #0x3E
  add   r3, #0x1F
  
  cmp   r3, r6
  ble   Loop
  
cmp   r7, #0x0
bne   Return
  
@ BreakLoop
mov   r0, r4
ldr   r5, =Break6CLoop
bl    GOTO_R5

Return:
mov   r0, #0x2
ldr   r5, =EnableBackgroundSyncById 
bl    GOTO_R5

pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
