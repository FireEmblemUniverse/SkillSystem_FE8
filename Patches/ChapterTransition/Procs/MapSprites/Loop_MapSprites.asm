.thumb

push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}
sub   sp, #0x8

mov   r4, r0

@ Check time until next unit is activated
mov   r1, #0x29
ldrb  r6, [r4, r1]                @ Time until next Map Sprite will be drawn
cmp   r6, #0x0
bgt   DecrementTimer
ldr   r6, =TimePerUnit

@ Check whether next unit is valid
add   r2, r1, #0x1
ldrb  r0, [r4, r2]
ldr   r7, =gUnitArray

NextUnit:
  cmp   r0, #0x34
  bge   DecrementTimer              @ Indices past #0x33 aren't valid, don't acivate unit
  lsl   r3, r0, #0x6
  lsl   r5, r0, #0x3
  add   r0, #0x1
  add   r3, r5                      @ Multiply index by #0x48
  add   r3, r7
  
  push  {r0-r3}
  mov   r0, r3
  bl    DrawUnitCheck
  mov   r5, r0
  pop   {r0-r3}
  cmp   r5, #0x0
  beq   NextUnit
  
sub   r0, #0x1

@ Activate next unit
@ Alter initial start a little based on RN
push  {r0-r3}
mov   r0, #0x60
ldr   r5, =NextRN_N
bl    GOTO_R5
mov   r5, r0
pop   {r0-r3}

add   r3, r0, #0x1
strb  r3, [r4, r2]                @ Increment next unit index
lsl   r2, r0, #0x1
add   r2, #0x2C

cmp   r2, #0x6C
blt   Parent                      
sub   r2, #0x40                   @ Unit is in child, dummy proc.
ldr   r7, [r4, #0x18]
ldrh  r3, [r7, r2]
add   r3, #0x1
add   r3, r5
strh  r3, [r7, r2]
b     DecrementTimer

Parent:
ldrh  r3, [r4, r2]
add   r3, #0x1
add   r3, r5
strh  r3, [r4, r2]

DecrementTimer:
sub   r6, #0x1
strb  r6, [r4, r1]


@ Check whether or not VRAM should be updated, extensive
ldr   r5, =GetGameClock
bl    GOTO_R5
mov   r1, #0x26
ldr   r5, =_umodsi3
bl    GOTO_R5
mov   r1, #0x1

@ Check1
cmp   r0, #0x0
bne   Check2
mov   r9, r0
mov   r8, r1                      @ Bool indicating whether VRAM should be updated
b     MapSpriteLoop

Check2:
cmp   r0, #0xD
bne   Check3
mov   r0, #0x1
mov   r9, r0
mov   r8, r1
b     MapSpriteLoop

Check3:
cmp   r0, #0x13
bne   Check4
mov   r0, #0x2
mov   r9, r0
mov   r8, r1
b     MapSpriteLoop

Check4:
cmp   r0, #0x20
bne   MapSpriteLoop
mov   r0, #0x3
mov   r9, r0
mov   r8, r1


@ Mapsprite loop, updates VRAM and draws mapsprites
MapSpriteLoop:
mov   r0, #0x2C
mov   r1, #0x0
mov   r11, r1                     @ Unit index
Loop:

  @ Check whether or not to draw unit
  lsl   r0, #0x10
  lsr   r0, #0x10
  ldrh  r2, [r4, r0]
  lsl   r5, r2, #0x10
  add   r3, r0, r5
  mov   r10, r3                   @ Unit Location<<16 + Proc state var index
  
  lsl   r6, r2, #0x12
  lsr   r6, #0x12                 @ Horizontal location
  lsr   r7, r2, #0xE              @ Vertical location
  cmp   r6, #0x0
  beq   SkipUnit                  @ Unit isn't active, don't draw
  mov   r3, #0x18
  lsl   r3, #0x4
  cmp   r6, r3
  bge   SkipUnit                  @ Unit is offscreen, don't draw
  
  mov   r0, r11
  lsl   r1, r0, #0x6
  lsl   r3, r0, #0x3
  add   r1, r3                    @ Multiply index by #0x48
  ldr   r3, =gUnitArray
  add   r1, r3
  
  push  {r0-r3}
  mov   r0, r1
  bl    DrawUnitCheck
  mov   r5, r0
  pop   {r0-r3}
  cmp   r5, #0x0
  beq   SkipUnit
  ldr   r2, [r1, #0x4]
  
    @ Check whether or not VRAM should be updated, lite
    mov   r3, r8
    cmp   r3, #0x0
    beq   DrawUnit
    
      @ Update VRAM for unit
      ldrb  r0, [r2, #0x4]
      ldr   r5, =MMS_GetGfx
      bl    GOTO_R5
      
      mov   r1, r9
      mov   r2, r11
      bl    VRAMupdate
      cmp   r0, #0x0
      bne   Return                    @ VRAMupdate failed (should only happen when VRAM is full)
    
    DrawUnit:
    @ Update movement
    mov   r0, r11
    bl    CalcMov
    mov   r1, r10
    lsr   r1, #0x10
    add   r1, r0
    add   r6, r0
    mov   r0, r10
    lsl   r0, #0x10
    lsr   r0, #0x10
    strh  r1, [r4, r0]
    
    @ Prepare ROM OAM data (technically not in ROM this time)
    mov   r2, #0x1
    mov   r1, sp
    str   r2, [r1]
    mov   r2, #0x0
    str   r2, [r1, #0x4]
    
    @ Attribute 0
    mov   r1, #0xD
    mul   r1, r7
    mov   r5, #0x80
    sub   r5, r1                     @ Correct Y
    
    @ Attribute 1
    sub   r6, #0x80                  @ Correct X
    lsl   r6, #0x17
    lsr   r6, #0x17
    mov   r1, #0x1
    lsl   r1, #0xC
    orr   r6, r1                    @ Horizontal flip. Unit's going left-to-right
    mov   r1, #0x2
    lsl   r1, #0xE
    orr   r6, r1                    @ Sprite size, 32x32
    
    @ Attribute 2
    mov   r0, r11
    
    mov   r1, #0x32
    cmp   r0, r1
    blt   Continue
    add   r0, #0x6                  @ Next six 32x32 blocks of VRAM are used by gems, skip those
    Continue:
    
    lsl   r1, r0, #0x1D
    lsr   r1, r1, #0x1B
    lsr   r2, r0, #0x3
    lsl   r2, #0x7
    orr   r1, r2                    @ VRAM tile
    lsl   r7, #0xA
    orr   r7, r1                    @ Priority
    mov   r1, #0xC
    lsl   r1, #0xC
    orr   r7, r1                    @ Palette, player palette is still loaded
    
    @ Push to secondary OAM
    mov   r0, r6
    mov   r1, r5
    mov   r2, sp
    mov   r3, r7
    ldr   r5, =PushToSecondaryOAM
    bl    GOTO_R5
  
  SkipUnit:
  mov   r0, r11
  add   r0, #0x1
  mov   r11, r0
  mov   r0, r10
  add   r0, #0x2
  mov   r10, r0
  lsl   r1, r0, #0x10
  lsr   r1, #0x10
  mov   r2, #0x6C
  cmp   r1, r2
  blt   Loop
  
  @ Switch to child proc state
  sub   r0, #0x40
  mov   r10, r0
  ldr   r4, [r4, #0x18]
  cmp   r4, #0x0
  bne   Loop

Return:
add   sp, #0x8
pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
