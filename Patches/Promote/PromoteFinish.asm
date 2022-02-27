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


ldr r3, =CurrentUnit
ldr r3, [r3] 
cmp r3, #0 
beq Break
ldr r2, =MemorySlot 
ldr r0, [r2, #0x4*3] @ s3 
strh r0, [r3, #0x1E] @ Item slot 1 

Break: 


pop {r0}
bx r0 

.ltorg 
.align 

