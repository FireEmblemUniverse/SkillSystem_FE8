.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

push {r4-r6, lr}
mov r4, r0 @ lower bound mt 
mov r5, r1 @ upper bound mt 
mov r6, r2 @ Weapon
mov r2, #0xA @ durb
lsl r2, #8 
orr r6, r2  

mov r0, r6 
blh 0x80175DC @ GetItemMight 
add r4, r0 @ lower bound with mt 
add r5, r0 @ upper bound with mt 

mov r0, r4 
mov r1, r5 

pop {r4-r6}
pop {r2}
bx r2


.ltorg 
.align 





