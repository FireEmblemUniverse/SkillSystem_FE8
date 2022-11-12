@ Mostly mimic 0x20778, but load palette in slot 0xF
.thumb
.set    gpBG0MapBuffer, 0x02022CA8
.set    BG_Fill, 0x08001221
.set    ChapterData, 0x0202BCF0
.set    EnableBackgroundSyncById, 0x08001FBD
push  {r4-r6, r14}

ldr   r4, =gpBG0MapBuffer
mov   r1, #0x94
lsl   r1, #0x5
mov   r0, r4
ldr   r6, =BG_Fill
bl    GOTO_R6

mov   r0, #0x8
mov   r1, #0xF                    @ Paletteslot 15
ldr   r6, =0x080895B5
bl    GOTO_R6

ldr   r0, =ChapterData
ldr   r6, =0x0808979D
bl    GOTO_R6

mov   r5, r0
mov   r0, #0xA0
lsl   r0, #0x2
mov   r1, r5
ldr r2, =0x8012345
ldr   r6, =0x0808966D
bl    GOTO_R6

ldr   r0, =0x246
add   r0, r4
mov   r1, #0xF                    @ Paletteslot 15
mov   r2, r5
ldr   r6, =0x080896FD
bl    GOTO_R6

mov   r0, #0x0
ldr   r6, =EnableBackgroundSyncById
bl    GOTO_R6

pop   {r4-r6}
pop   {r0}
bx    r0
GOTO_R6:
bx    r6
