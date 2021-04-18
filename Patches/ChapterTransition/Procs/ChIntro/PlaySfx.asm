.thumb

push  {r4, r14}

ldr   r0, =ChapterData
add   r0, #0x41
ldrb  r0, [r0]
lsl   r0, #0x1E
cmp   r0, #0x0
blt   Return

ldr   r0, =IntroSfx
ldr   r4, =m4aSongNumStart
bl    GOTO_R4

Return:
pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
