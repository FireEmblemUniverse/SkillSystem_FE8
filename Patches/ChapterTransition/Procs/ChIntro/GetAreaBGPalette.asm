@ Returns pointer to AreaBGPalette.
.thumb

ldr   r0, =ChapterData
ldrb  r0, [r0, #0xE]

ldr   r1, =gAreaBgPal                 @ Palettes of AreaBGs...
lsl   r0, #0x2 @ 4 bytes per poin 
add   r0, r1                              @ ...indexed by chapterID
ldr r0, [r0] @ it's a pointer 

bx    r14
