@ Returns index to VSBG palette.
.thumb

ldr   r0, =ChapterData
ldrb  r0, [r0, #0xE]
ldr   r1, =VSBGPaletteTable               @ Table of indices for VSBG palettes...
ldrb  r0, [r1, r0]                        @ ...indexed by chapterID

bx    r14
