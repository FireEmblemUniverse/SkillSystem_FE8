@ Mimics 0x1D9DC, but adds
@ more palette options.
.thumb

.global CopyToPaletteBuffer
.type   CopyToPaletteBuffer, function
.set    CopyToPaletteBuffer, 0x08000DB9

.global GetGameClock
.type   GetGameClock, function
.set    GetGameClock, 0x08000D29


@ Graphics
.global RangeSquareBluePalette
.set    RangeSquareBluePalette, 0x8A02F34

.global RangeSquareRedPalette
.set    RangeSquareRedPalette, 0x8A02F94

.global RangeSquareGreenPalette
.set    RangeSquareGreenPalette, 0x8A02FF4


push  {r4-r7, r14}
mov   r5, r0


ldr   r4, =GetGameClock
bl    GOTO_R4

ldr   r4, =CopyToPaletteBuffer
add   r5, #0x4A
ldrh  r5, [r5]
lsr   r6, r0, #0x1
mov   r0, #0x1F
and   r6, r0
ldr   r7, =PaletteFlags

Loop:

  @ Check for terminator.
  ldr   r0, [r7]
  cmp   r0, #0x0
  blt   Return
  
    @ Check if flag is set.
    ldrh  r0, [r7]
    tst   r0, r5
    beq   L1
      
      @ Load palette.
      ldr   r0, [r7, #0x4]
      lsl   r1, r6, #0x1
      add   r0, r1
      ldrh  r1, [r7, #0x2]
      mov   r2, #0x20
      bl    GOTO_R4
    
    L1:
    add   r7, #0x8
    b     Loop


Return:
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4


.align
PaletteFlags:
.short 0x1
.short 0x82
.word RangeSquareBluePalette
.short 0x2
.short 0xA2
.word RangeSquareRedPalette
.short 0x4
.short 0xA2
.word RangeSquareGreenPalette
.short 0x10
.short 0xA2
.word RangeSquareBluePalette
.short 0x20
.short 0xA2
.word RangeSquarePurplePalette
.word 0xFFFFFFFF
.word 0xFFFFFFFF
