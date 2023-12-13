.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@ // 8019c3C
.equ MemorySlot,0x30004B8
.equ gActionStruct, 0x203A958

.global CantoPlusFix
.type CantoPlusFix, %function 
CantoPlusFix: 
push {r6, lr} 
mov r11, r11 
@blh 0x801dacc
@blh 0x801d6fc
@bl InitializeDR

@ menu idle 0x804F3C8 here if B was pressed 

ldr r0, =0x202e4e4 
ldr r0, [r0] 
mov r1, #0 
blh 0x80197e4 @ clear range map 

ldr r0, =0x202e4F0 
ldr r0, [r0] 
mov r1, #0xFF 
blh 0x80197e4 @ clear some map 

ldr r0, =0x202e4e0 
ldr r0, [r0] 
mov r1, #0xFF 
blh 0x80197e4 @ clear move map 

ldr r0, =0x202e4e8 
ldr r0, [r0] 
mov r1, #0 
blh 0x80197e4 @ clear range map 


ldr r4, =0x203A958 @ gActionData 
ldrb r0, [r4, #0x0C] 
blh 0x8019430 @ getunit 
mov r5, #0x10 
ldsb r5, [r0, r5] 
pop {r6} 
pop {r3} 
bx r3 
.ltorg 
