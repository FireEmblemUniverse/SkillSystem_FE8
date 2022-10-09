.thumb 
.include "Definitions.s"
.equ NewGameRamSize, NewGameFlagRam+4 

ldr r1, NewGameRamSize
cmp r0, #0 
ble ReturnFalse 
sub r0, #1 
cmp r0, r1
bge ReturnFalse  
mov r3, r0 

lsr r1, r0, #3 @ bottom 3 bits are the specific flag 
ldr r0, NewGameFlagRam
add r0, r1 @ offset we want 
mov r2, #7 
and r2, r3 @ bottom 3 bits 
mov r1, #1 
lsl r1, r2 

b Exit 
ReturnFalse: 
mov r0, #0 

Exit: 
bx lr 
.ltorg 
.align
NewGameFlagRam:



