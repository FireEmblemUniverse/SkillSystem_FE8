.thumb

push  {r4-r7, r14}

@ Load AreaBG stuff
@ Load AreaBG image into part of Tiles1 and Tiles2 (#0x6005800)
bl    GetAreaBG
mov   r1, #0x6
lsl   r1, #0x18
mov   r2, #0x58
lsl   r2, #0x8
orr   r1, r2
ldr   r5, =UnLZ77Decompress
bl    GOTO_R5

@ Load AreaBG palette
bl    GetAreaBGPalette             
mov r4, r0            
mov   r1, #0x0  @ Overwrite BG palette 0-1, 4-15
mov r2, #2 @ 2 palette rows  
lsl r2, #5 
@ // Leave paletteslot 2 and 3 empty for text and chatbubble if 224-col BG.
ldr   r5, =CopyToPaletteBuffer
bl    GOTO_R5
mov r0, #0x40 
add r0, r4 
mov r1, #4 @ start at row 4 
lsl r1, #5 
mov r2, #0xC @ 0xC rows 
lsl r2, #5 
bl GOTO_R5 


@ Set up Screenblock (TSA)
ldr   r1, =gpBG1MapBuffer
mov   r6, #0x60                           @ Start right past chapter title tiles in tiles 1
mov   r3, #0x0
mov   r4, #0x28
lsl   r4, #0x4
sub   r4, #0x1                            @ BGTileSize

Loop:
  add   r0, r3, r6
  strh  r0, [r1]
  add   r1, #0x2
  add   r3, #0x1
  
  cmp   r3, r4
  ble   Loop
  
mov   r0, #0x1
ldr   r5, =EnableBackgroundSyncById 
bl    GOTO_R5

pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
