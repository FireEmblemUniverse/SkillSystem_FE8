.thumb

push  {r4-r7, r14}
mov   r4, r0
sub   sp, #0x4

@ Move the ScreenBlocks to a more favourable position
ldr   r6, =LocScreenBlockBG0
ldr   r5, =gpDISPCNTbuffer
add   r5, #0xD                          @ BG0CNT
mov   r7, #0x6                          @ ScreenBlock, also loop iterator because registerscarcity
mov   r0, #0x6
lsl   r0, #0x18
mov   r1, #0x8
lsl   r1, #0x8
mov   r2, #0x30
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
  mov   r3, #0x9
  cmp   r7, r3
  ble   Loop


@ Enable 256 colour mode in BG1
ldr   r2, =gpDISPCNTbuffer
add   r2, #0x10
ldrb  r0, [r2]
mov   r1, #0x80
orr   r0, r1
strb  r0, [r2]


@ Set video mode to 0 (BG0, BG1, BG2, BG3 text mode)
ldr   r2, =gpDISPCNTbuffer                  @ DISPCNT
ldrh  r1, [r2]
mov   r0, #0x8
neg   r0, r0
and   r1, r0                                @ Video mode 0

@ Display BG0, BG1 OBJ
mov   r0, #0x1F
lsl   r0, #0x8
mvn   r0, r0
and   r1, r0                                @ Clear Displaybits
mov   r0, #0x12                             @ Enable BG1 & OBJ
lsl   r0, #0x8
orr   r1, r0
strh  r1, [r2]

@ init Fade-in, set screen to black
mov   r0, #0xE0
mov   r1, #0x4C                             @ +0x4C byte reserved for fading-in
strb  r0, [r4, r1]
ldr   r6, =FadeInOutByte
strb  r0, [r6]
mov   r0, #0x1
mov   r1, #0x4D                             @ +0x4D byte reserved, don't move to seg2 until unset
strb  r0, [r4, r1]

@ Unset BLDCNT
mov   r0, #0x0
mov   r1, #0x0
mov   r2, #0x0
mov   r3, #0x0
ldr   r5, =SetSpecialColourEffectsParam
bl    GOTO_R5

@ Unset BLDCNT target 1
mov   r6, #0x0
str   r6, [sp]
mov   r0, #0x0
mov   r1, #0x0
mov   r2, #0x0
mov   r3, #0x0
ldr   r5, =SetBLDCNT1stTargets
bl    GOTO_R5

@ Unset BLDCNT target 2
mov   r6, #0x0
str   r6, [sp]
mov   r0, #0x0
mov   r1, #0x0
mov   r2, #0x0
mov   r3, #0x0
ldr   r5, =SetBLDCNT2ndTargets
bl    GOTO_R5

@ Set BG1 to start at tiles1, just past the chapter title tiles.
mov   r1, #0x40
lsl   r1, r1, #0x8                          @ Use part of Tiles1 and most of Tiles2
mov   r0, #0x1
ldr   r5, =SetBackgroundTileDataOffset
bl    GOTO_R5

@ Set BG1 priority to 3
ldr   r2, =gpDISPCNTbuffer
ldrb  r3, [r2, #0x10]                       @ BG1CNT
mov   r0, #0x4
neg   r0, r0
and   r0, r3
mov   r3, #0x3
orr   r0, r3                                @ priority 3
strb  r0, [r2, #0x10]


@ Set BG1 screen size to 256x256
ldrb  r1, [r2, #0x11]
mov   r0, #0x3F
and   r1, r0
strb  r1, [r2, #0x11]

add   sp, #0x4
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
