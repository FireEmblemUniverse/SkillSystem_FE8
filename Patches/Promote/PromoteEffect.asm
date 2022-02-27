

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ CurrentUnit, 0x3004E50
.equ MemorySlot,0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 

push {lr}

ldr r0, PromotionMenuEvent 
mov r1, #1 
blh EventEngine 

mov r0, #0x17 


pop {r1}
bx r1 


.ltorg
.align 4

PromotionMenuEvent:
