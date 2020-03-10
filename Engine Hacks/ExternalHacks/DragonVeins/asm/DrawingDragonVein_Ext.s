.thumb

  cmp r0, #0xD
  beq lightRune

  cmp r0, #0x3 @ +$4: Dragon Vein Trap Id
  bne continue
  
  b dragonVein

lightRune:
  mov r0, #0x66
  ldr r1, lightRunePalette
  
  b draw

dragonVein:
  mov r0, #0x65 @ +$10: Dragon Vein SMS Id
  ldr r1, allyPalette

draw:
  push {r1}
  push {r0}
  ldr r1, loopLoc
  ldrb    r0,[r4,#0x1]
  lsl     r0,#0x4
  
  b ret

continue:
  ldr r1, continueLoc

ret:
  bx r1

.align

loopLoc: 
  .long 0x08027321
continueLoc:
  .long 0x08027345
lightRunePalette:
  .long 0xFFFFB080
allyPalette:
  .long 0xFFFFC080
