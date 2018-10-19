.set ActiveUnitPtr, 0x3004e50
.set AddToTargetList, 0x804f8bc
.set GetCharData, 0x8019430
 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
 
.macro blm to, from=origin
  .equ func_\to, . + \to - \from
  bl func_\to
.endm
