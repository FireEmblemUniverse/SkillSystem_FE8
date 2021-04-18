@ Mostly Idk what I'm doing, but copying vanilla.
.thumb

push  {r4-r5, r14}

mov   r0, #0x4              @ Fade-out rate, greater means slower fade-out
ldr   r5, =SoundStuff1
bl    GOTO_R5

mov   r0, #0x1
ldr   r5, =SoundStuff2
bl    GOTO_R5

pop   {r4-r5}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
