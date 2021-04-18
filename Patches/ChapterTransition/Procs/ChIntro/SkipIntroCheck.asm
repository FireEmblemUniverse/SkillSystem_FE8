@ Skips intro screen if:
@ - Flag in r0 is set
@ - If chapter should be skipped according to SkipIntroTable.
.thumb

push  {r4-r7,r14}
mov   r5, r1

@ Check if flag is set
ldr   r4, =CheckFlag
bl    GOTO_R4
cmp   r0, #0x0
bne   L1

  @ Check if chapter should be skipped
  ldr   r0, =ChapterData
  ldrb  r0, [r0, #0xE]
  ldr   r1, =SkipIntroTable
  ldrb  r0, [r1, r0]
  cmp   r0, #0x0
  beq   Return

@ Skip chapter intro
L1:
mov   r0, r5
mov   r1, #0x1
ldr   r4, =Goto6CLabel
bl    GOTO_R4

Return:
mov   r0, #0x1
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
