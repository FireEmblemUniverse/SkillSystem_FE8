@ Using SkipIntroTable, skips the intro screen for certain chapters.
.thumb

push  {r14}

ldr   r1, =ChapterData
ldrb  r1, [r1, #0xE]
ldr   r2, =SkipIntroTable
ldrb  r1, [r2, r1]
cmp   r1, #0x0
beq   Return

  @ Skip chapter intro
  mov   r1, #0x1
  ldr   r3, =Goto6CLabel
  bl    GOTO_R3

Return:
pop   {r0}
bx    r0
GOTO_R3:
bx    r3
