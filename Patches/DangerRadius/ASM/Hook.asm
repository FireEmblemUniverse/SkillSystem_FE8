@ Put where PlayerPhase_MainLoop checks for start input, 0x1CAD4.
@ Checks for select input, and activates DR when detected.
.thumb

push  {r4-r7,r14}


ldr   r0, =KeyStatusBuffer
ldrh  r1, [r0, #0x8]
mov   r2, #0x8
tst   r1, r2
bne   Return                      @ Return (KeyStatusBuffer) if start was pressed.

  @ Start wasn't pressed.
  @ Return address is 0x1CB38.
  ldr   r2, =0x801CB39
  mov   r3, sp
  str   r2, [r3, #0x10]
  mov   r2, #0x4
  tst   r1, r2
  beq   Return                    @ Return if select wasn't pressed.

    @ Select was pressed.
    bl    DetermineDR
    

Return:
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
