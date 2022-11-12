.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ IsItemDanceRing, 0x8016EC8 
.type IsTMUsable, %function 
.global IsTMUsable 
IsTMUsable: 
push {lr} 
cmp r0, #0 
bne ReturnTrue 

ldr r1, =SpellScrollID
lsl r1, #24 
lsr r1, #24 
mov r0, #0xFF 
and r0, r4 
cmp r0, r1 
bne VanillaBehaviour 

mov r0, r6 @ unit 
lsr r1, r4, #8 @ tm durability  

bl UsabilityByType
cmp r0, #0 
beq ReturnFalse 
b ReturnTrue 

VanillaBehaviour: 
mov r0, r4 
blh IsItemDanceRing 
cmp r0, #0 
beq ReturnTrue 
b ReturnFalse 







ReturnFalse: 
mov r0, #0xFF // anything but 0 is false 
b End 


ReturnTrue: 
mov r0, #0 

End: 
pop {r1} 
bx r1 
.ltorg 


