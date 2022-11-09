.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ PromoteActiveUnit, 0x080CCA14 @//NewPromotion
.equ EndMMS, 0x80790a4 @//MU_EndAll //deselect unit
.equ CurrentUnit, 0x3004E50
.equ MemorySlot,0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 
.equ ActionStruct, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ Defender, 0x203A56C 
.equ GetUnitEquippedWeapon, 0x8016B28 
push {r4, lr}
mov r4, r0 
ldr r3, =CurrentUnit
ldr r3, [r3] 
cmp r3,  #0 
beq Exit 

ldrh r0, [r3, #0x1E] @ Item slot 1 
ldr r2, =MemorySlot 
str r0, [r2, #0x4*3] @s3 


ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]

ldr r3, =ActionStruct @0x203A958
mov r0, #0 
strb r0, [r3, #0x12] @ Inventory slot #0 

mov r0, r4 
blh PromoteActiveUnit

ldr r0, =CurrentUnit 
ldr r0, [r0] 
blh GetUnitEquippedWeapon 
ldr r3, =Defender  
add r3, #0x48 
@strh r0, [r3] 
strh r0, [r3, #2] 

blh EndMMS 




Exit: 
mov r0, #0xB7
pop {r4} 
pop {r1}
bx r1 


.ltorg 
.align 







