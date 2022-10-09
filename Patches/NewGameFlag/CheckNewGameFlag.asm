
.thumb 
.include "Definitions.s"

push {lr} 

ldr r2, =MemorySlot 
ldr r0, [r2, #4*1] @ Slot 1 as which flag bit 


blh2 GetFlagOffset @ takes flag ID. returns r0 as offset and r1 as bit at that offset eg. 0x01 0x02 0x04 0x08 0x10 0x20 0x40 0x80 
cmp r0, #0 
beq ReturnFalse 

mov r3, r0 
ldrb r3, [r3] @ value 
tst r1, r3 
beq ReturnFalse 
ReturnTrue: 
ldr r2, =MemorySlot 
mov r0, #1 
str r0, [r2, #0x0C*4] 
b Exit 

ReturnFalse: 
ldr r2, =MemorySlot 
mov r0, #0 
str r0, [r2, #0x0C*4] 
b Exit 



Exit: 
pop {r0} 
bx r0 
.ltorg 
GetFlagOffset: 

