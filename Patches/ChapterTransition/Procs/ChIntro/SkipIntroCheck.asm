@ Skips intro screen if:
@ - Flag in r0 is set
@ - If chapter should be skipped according to SkipIntroTable.
.thumb

push  {r4-r7,r14}
mov   r5, r1


@mov r11, r11 @ [2025888+0x4C..2025888+0x4F]!!?
@mov r11, r11 @ [2025888+0x64..2025888+0x69]!!?
@ [2025378+0x50..2025378+0x53]!!?
@ [20257B0+0x50..20257B0+0x53]!!?

@ Disable BG3
ldr   r2, =gpDISPCNTbuffer
ldrb  r3, [r2, #0x1]
mov   r1, #0xF7
and   r3, r1
strb  r3, [r2, #0x1]

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
