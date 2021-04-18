@ Returns pointer to AreaBG.
.thumb

ldr   r0, =ChapterData
ldrb  r0, [r0, #0xE]

ldr   r1, =AreaBGTable                    @ Table of pointers to AreaBGs...
lsl   r0, #0x2
ldr   r0, [r1, r0]                        @ ...indexed by chapterID

bx    r14
