@ Apply filter to palette before
@ copying to palette buffer. Args:
@ r0 = dst 
@   r1: RModifier, [-31, 31]
@   r2: GModifier, [-31, 31]
@   r3: BModifier, [-31, 31]
@   [sp]: Palette address
.thumb
.equ palette_buffer, 0x020228A8
.global FilterPalette
.type FilterPalette, %function 
FilterPalette: 
push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}
mov   r8, r1
mov   r9, r2
mov   r10, r3


@ldr   r3, =palette_buffer @ 0x020228A8
@add   r3, r0
mov r3, r0 

mov   r0, sp
ldr   r4, [r0, #0x24]
ldr r5, [r0, #0x28] @ sp+4 - size in WORDs 

lsl r5, #2 @ size in BYTEs 
mov   r2, #0x1F
mov   r6, #0x0

Loop:
  @ Pick next colour
  ldrh  r7, [r4, r6]
  
  
  @ Red
  mov   r0, r7
  and   r0, r2
  add   r0, r8
  cmp   r0, r2
  bgt   L7
    cmp   r0, #0x0
    blt   L8
      b     L9
  L7:
  mov   r0, #0x1F
  b     L9
  L8:
  mov   r0, #0x0
  L9:
  mov   r1, r0
  
  
  @ Green
  lsr   r0, r7, #0x5
  and   r0, r2
  add   r0, r9
  cmp   r0, r2
  bgt   L4
    cmp   r0, #0x0
    blt   L5
      b     L6
  L4:
  mov   r0, #0x1F
  b     L6
  L5:
  mov   r0, #0x0
  L6:
  lsl   r0, #0x5
  add   r1, r0
  
  
  @ Blue
  lsr   r0, r7, #0xA
  add   r0, r10
  cmp   r0, r2
  bgt   L1
    cmp   r0, #0x0
    blt   L2
      b     L3
  L1:
  mov   r0, #0x1F
  b     L3
  L2:
  mov   r0, #0x0
  L3:
  lsl   r0, #0xA
  add   r1, r0
  
  
  @ New colour
  strh  r1, [r3, r6]
  
  add   r6, #0x2
  cmp   r6, r5
  blt   Loop


pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r0}
bx    r0
.ltorg 
