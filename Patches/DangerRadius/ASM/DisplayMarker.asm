@ Hook at 08027566. Adds an extra check, checking whether
@ FOW is active, and if not, prevent fog hiding tiledisplaymarker.
.thumb

@ Previously overwritten.
@ Need to return this.
lsl   r1, r2, #0x2

@ Check for FOW.
ldr		r0, =ChapterData
ldrb	r0, [r0,#0xD]
cmp		r0,	#0x0
beq		Return

  ldr   r0, =FogMap
  ldr   r0, [r0]
  add   r0, r1, r0
  ldr   r0, [r0]
  add   r0, r0, r3
  ldrb  r0, [r0]
  cmp   r0, #0x0
  bne   Return
  
    @ Tile in Fog, don't draw marker.
    ldr   r0, =0x80275C7
    mov   r14, r0

Return:
mov   r0, r1
bx		r14
