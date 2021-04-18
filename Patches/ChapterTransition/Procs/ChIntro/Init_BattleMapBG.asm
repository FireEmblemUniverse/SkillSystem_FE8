@ Prepares The BG settings for the battle map
.thumb

push  {r4-r7, r14}

@ Reset the ScreenBlocks to their previous position
ldr   r6, =LocScreenBlockBG0
ldr   r5, =gpDISPCNTbuffer
add   r5, #0xD                          @ BG0CNT
mov   r7, #0xC                          @ ScreenBlock, also loop iterator because registerscarcity
mov   r0, #0x6
lsl   r0, #0x18
mov   r1, #0x8
lsl   r1, #0x8
mov   r2, #0x60
lsl   r2, #0x8

Loop:
  add   r3, r0, r2
  str   r3, [r6]                          @ Update LocScreenBlockBG0-3
  ldrb  r3, [r5]
  lsr   r3, #0x5                          @ Not any registers left for a mask, so I'll just shift 'em off
  lsl   r3, #0x5
  add   r3, r7
  strb  r3, [r5]                          @ Update Screen Base Block in BG0CNT
  add   r5, #0x4
  add   r7, #0x1
  add   r6, #0x4
  add   r2, r1
  mov   r3, #0xF
  cmp   r7, r3
  ble   Loop


@ Disable 256 colour mode in BG1
ldr   r2, =gpDISPCNTbuffer
add   r2, #0x10
ldrb  r0, [r2]
mov   r1, #0x80
mvn   r1, r1
and   r0, r1
strb  r0, [r2]


@ Unset all DisplayBG and DisplayOBJ
ldr   r2, =gpDISPCNTbuffer
ldrb  r1, [r2, #0x1]
mov   r0, #0xE0
and   r1, r0
strb  r1, [r2, #0x1]


@ Set BG0, BG1 & BG2 to Tiles1, BG1 & BG3 to Tiles2 for setting up battlemap
mov   r0, #0x0
mov   r1, #0x0                            @ Assumes Tiles1 is at 06000000 (vanilla)
ldr   r5, =SetBackgroundTileDataOffset
bl    GOTO_R5
mov   r0, #0x1
mov   r1, #0x0                            @ Assumes Tiles1 is at 06000000 (vanilla)
ldr   r5, =SetBackgroundTileDataOffset
bl    GOTO_R5
mov   r0, #0x2
mov   r1, #0x0                            @ Assumes Tiles1 is at 06000000 (vanilla)
ldr   r5, =SetBackgroundTileDataOffset
bl    GOTO_R5
mov   r0, #0x3
mov   r1, #0x2
lsl   r1, #0xE                            @ Assumes Tiles2 is at 06008000 (vanilla)
ldr   r5, =SetBackgroundTileDataOffset
bl    GOTO_R5

pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
