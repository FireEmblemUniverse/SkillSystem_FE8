.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ SaveGame, 0x80A5010|1
.equ ChapterData, 0x202BCF0 
.global SaveGame_ASMC
.type SaveGame_ASMC, %function 
SaveGame_ASMC: 
push {lr} 
ldr r0, =ChapterData 
ldrb r0, [r0, #0x0C] @ save slot ID 
blh SaveGame 
pop {r0} 
bx r0 
.ltorg 

