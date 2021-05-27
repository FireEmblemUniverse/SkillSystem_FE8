@ If no FOW: Invert fog tile marks: 0: nofog, 1: fog.
@ Hooks at 0x19B3C.
.thumb


@ Previously overwritten.
ldr   r0, =FogMap
ldr   r0, [r0]
ldr   r0, [r0, r2]
ldrb  r0, [r0, r3]

@ Check for FOW.
ldr   r1, =ChapterData
ldrb  r1, [r1,#0xD]
cmp   r1, #0x0
bne   Return

  @ FOW not active, flip r0.
  cmp   r0, #0x0
  beq   L1
    mov   r0, #0x0
    b     Return
  L1:
    mov   r0, #0x1


Return:
ldr   r1, =0x8019B45
bx    r1
