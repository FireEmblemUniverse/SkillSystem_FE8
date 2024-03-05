.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ CheckEventId, 0x8083da8

.type IsEvolvingAllowed, %function 
.global IsEvolvingAllowed 
IsEvolvingAllowed: 
push {lr} 
mov r6, r1 
mov r4, #0 


ldr r0, =CannotEvolveFlag_Link
ldr r0, [r0] 
blh CheckEventId 
cmp r0, #0 
bne Unusable  


mov r0, r6 
blh 0x80174EC @/GetItemIndex
ldr r2, =0xFFFF

pop {r3} 
bx r3 
.ltorg 

Unusable:
mov r0, #0 
pop {r3} 
pop {r4-r7}
pop {r3}
bx r3 
.ltorg 








