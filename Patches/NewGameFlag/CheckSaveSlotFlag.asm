
.thumb 
.include "Definitions.s"
.equ NewGameRamSize, GetFlagOffset
push {lr} 


ldr r2, =MemorySlot 
ldr r0, [r2, #4*1] @ Slot 1 as which flag bit 
blh2 GetSaveSlotFlagOffset
cmp r0, #0 
ble ReturnFalse 



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
GetSaveSlotFlagOffset: 

