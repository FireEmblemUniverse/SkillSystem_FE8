.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb @ based on $7CCC0 
.equ UnLZ77Decompress, 0x8012F50 

.type PoisonAnimHook, %function 
.global PoisonAnimHook

PoisonAnimHook:

push {lr}
ldr r0, =VortexAnimation
ldr r1, =0x6013800 @ obj tile to insert to 
blh UnLZ77Decompress 
ldr r0, =0x89AE204 @ poison animation palette 
mov r1, #0xA0 
lsl r1, #2 



pop {r3} 
bx r3 
.ltorg 




