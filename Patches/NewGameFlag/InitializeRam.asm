.thumb 
.include "Definitions.s"
.equ NewGameRamSize, NewGameFlagRam+4 

ldr r2, =ChapterData
ldrb r2, [r2, #0x0C] @ Saveslot ID 
add r2, #1 @ since 0-indexed 
ldr r1, NewGameRamSize
lsr r1, #2 @ NewGameRamSize divided into four pieces 

lsr r1, #3 @ bytes only 
mul r2, r1 @ offset 
ldr r3, NewGameFlagRam 
add r3, r2 @ starting offset 
mov r2, r3 
add r2, r1 @ ending offset 

mov r0, #0 
Loop: 
strb r0, [r3] 
add r3, #1 
cmp r3, r2 
bge Exit 
b Loop 


Exit: 
bx lr 
.ltorg 
NewGameFlagRam:




