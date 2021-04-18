.thumb

push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
push  {r4-r5}

mov   r4, r0
mov   r8, r0

mov   r1, #0x29
mov   r0, #0x0
mov   r7, #0x0                    @ Unitcount
strb  r0, [r4, r1]                @ Time until next Map Sprite will be drawn
add   r1, #0x1
strb  r0, [r4, r1]                @ Next unit's UnitStruct index
add   r1, #0x2
mov   r2, #0x0                    @ Unit Index, used to determine VRAM index
ldr   r3, =gUnitArray

Loop:
  strh  r0, [r4, r1]
  
  @ Change vertical placement
  lsr   r0, #0xE
  add   r0, #0x1                  @ Bits 0-13: Unit's horizontal placement
  lsl   r0, #0xE                  @ Bits 14-15: vertical placement & priority
  
  @ Obtain MMS Data
  lsl   r5, r2, #0x6
  lsl   r6, r2, #0x3
  add   r5, r6                    @ Multiply index by #0x48
  add   r5, r3
  
  @ Check whether unit should be drawn
  push  {r0-r3}
  mov   r0, r5
  bl    DrawUnitCheck
  mov   r6, r0
  pop   {r0-r3}
  cmp   r6, #0x0
  beq   NextIteration
  add   r7, #0x1

  ldr   r5, [r5, #0x4]
  ldrb  r5, [r5, #0x4]            @ Class ID
  
  push  {r0-r3}
  mov   r0, r5
  ldr   r5, =MMS_GetGfx
  bl    GOTO_R5
  mov   r1, #0x0                  @ index indicating which MMS should be drawn
  bl    VRAMupdate
  pop   {r0-r3}
  
  NextIteration:
  add   r2, #0x1
  add   r1, #0x2
  cmp   r1, #0x6C
  blt   Loop
  
  @ Switch to child proc state
  mov   r1, #0x2C
  ldr   r4, [r4, #0x18]
  cmp   r4, #0x0
  bne   Loop

@ Determine time until segment ends
ldr   r0, =TimePerUnit
mul   r7, r0                      @ 12 frames per unit
add   r7, #0x3C                   @ At least have a second to give player time to read the title

mov   r4, r8
ldr   r0, [r4, #0x14]
mov   r1, #0x4C
strh  r7, [r0, r1]                @ Parent uses this as timer

pop   {r4-r5}
mov   r8, r4
mov   r9, r5
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
