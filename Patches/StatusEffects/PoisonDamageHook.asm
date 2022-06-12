.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb 
.type PoisonDamageHook, %function 
.global PoisonDamageHook
PoisonDamageHook:
push {lr}

ldsb r6, [r2, r6] 
ldrb r3, [r2, #0x12] @ Max HP 
add r3, #7 @ you should never have less than 1 max hp 
lsr r3, #3 @ 1/8th max hp as damage of poison/burn/entangled 

pop {r2} 
bx r2
.ltorg 




