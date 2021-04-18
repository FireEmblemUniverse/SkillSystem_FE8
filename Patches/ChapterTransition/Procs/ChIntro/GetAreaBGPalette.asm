@ Returns pointer to AreaBGPalette.
.thumb

ldr   r0, =ChapterData
ldrb  r0, [r0, #0xE]

ldr   r1, =AreaBGPalettes                 @ Palettes of AreaBGs...
lsl   r0, #0x9                            @ 16 32-byte palettes per area
add   r0, r1                              @ ...indexed by chapterID

bx    r14
