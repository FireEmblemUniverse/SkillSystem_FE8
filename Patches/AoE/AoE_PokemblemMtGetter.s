.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CurrentUnit, 0x3004E50
push {r4-r7, lr}
mov r4, r0 @ lower bound mt 
mov r5, r1 @ upper bound mt 
mov r6, r2 @ Weapon
mov r2, #0xA @ durb
lsl r2, #8 
orr r6, r2  

mov r0, r6 
blh 0x80175DC @ GetItemMight 
mov r7, r0 @ mt 

mov r0, r6 @ weapon 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldr r1, [r3, #4] 
ldrb r1, [r1, #4] @ Class ID 

bl ShouldWeaponHaveStabBonus
cmp r0, #0 
beq Exit 
mov r0, r7 
add r0, r7 @ 2x 
add r7, r0 @ 3x 
lsr r7, #1 

Exit: 
add r4, r7 @ lower bound with mt 
add r5, r7 @ upper bound with mt 


mov r0, r4 
mov r1, r5 

pop {r4-r7}
pop {r2}
bx r2


.ltorg 
.align 





