.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ ClearBG0BG1, 0x804E884 
@.equ MemorySlot,0x30004B8
@.equ CurrentUnit, 0x3004E50
.equ EventEngine, 0x800D07C
push {lr} 
blh ClearBG0BG1 
ldr r0, Give100ExpEvent 
mov r1, #1 
blh EventEngine 

Exit: 

pop {r0} 
bx r0 
.ltorg 

Give100ExpEvent: 


