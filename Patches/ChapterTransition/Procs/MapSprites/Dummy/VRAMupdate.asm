@ Arguments:
@ r0: MMS gfx location
@ r1: index indicating which MMS should be drawn, 0-3
@ r2: index indicating which 32x32 VRAM block should updated, 0-63...
@ ...however, 52 and above are ignored, due to the gems being in VRAM
@ Returns:
@ 0 for success, 1 for failure
.thumb

push  {r4-r7, r14}
mov   r6, r1

mov   r3, #0x1                  @ Failure, VRAM is full
mov   r1, #0x34
cmp   r2, r1
bge   Return                    @ Ignore 52 and above
mov   r1, #0x32
cmp   r2, r1
blt   Continue
add   r2, #0x6                  @ Next six 32x32 blocks of VRAM are used by gems, skip those

Continue:
mov   r7, r2
  
@ Decompress image into buffer
ldr   r1, =gGenericBuffer
ldr   r5, =UnLZ77Decompress
bl    GOTO_R5
mov   r1, r6
mov   r2, r7

@ VRAM index
lsr   r6, r2, #0x3
lsl   r7, r2, #0x1D
lsr   r7, #0x1D
lsl   r7, #0x7                  @ VRAM Horizontal index
lsl   r6, #0xC                  @ VRAM Vertical index
add   r6, r7

@ Load MMS into VRAM
ldr   r0, =gGenericBuffer
lsl   r1, #0x9
add   r0, r1
ldr   r1, =VRAMaddress
ldr   r5, =CpuFastSet
add   r1, r6
mov   r6, #0x4
lsl   r6, #0x8
mov   r3, #0x80
mov   r2, #0x20  
mov   r7, #0x0

Loop:
  push  {r0-r3}
  bl    GOTO_R5
  pop   {r0-r3}
  add   r0, r3
  add   r1, r6
  add   r7, #0x1
  cmp   r7, #0x3
  ble   Loop

mov   r3, #0x0                @ Success
Return:
mov   r0, r3
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R5:
bx    r5
