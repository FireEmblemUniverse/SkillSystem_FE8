.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ BattleMapState, 0x202BCB0 
.equ CopyToPaletteBuffer, 0x8000DB8 

push {lr} 

mov r2, #0x80 
blh CopyToPaletteBuffer 

ldr r0, =0x859EE40 @ enemy pal 
mov r1, #0xE0 
lsl r1, #2
mov r2, #0x20 
blh CopyToPaletteBuffer 



ldr r0, =BattleMapState
ldrb r1, [r0, #4] 
mov r0, #0x40 

pop {r3} 
bx r3 
.ltorg 













