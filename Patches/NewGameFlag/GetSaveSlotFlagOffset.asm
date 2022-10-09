.thumb 
.include "Definitions.s"
.equ NewGameRamSize, NewGameFlagRam+4 
ldr r1, NewGameRamSize
lsr r1, #2 @ NewGameRamSize divided by 4 
cmp r0, #0 
ble ReturnFalse 
sub r0, #1 
cmp r0, r1
bge ReturnFalse  

ldr r2, =ChapterData
ldrb r2, [r2, #0x0C] @ Saveslot ID 
add r2, #1 @ since 0-indexed 
@ldr r1, NewGameRamSize
@lsr r1, #2 @ NewGameRamSize divided into four pieces 

mul r1, r2 
add r0, r1 @ add (1/4 * RamSize * 8) to get our flag offset 
mov r3, r0 

lsr r1, r0, #3 @ all bits above the bottom 3 (0-7) need to be counted in bytes 
ldr r0, NewGameFlagRam
add r0, r1 @ offset we want 
mov r2, #7 
and r2, r3 @ bottom 3 bits as the bitflag to care about eg. 1<7 = 0x80 
mov r1, #1 
lsl r1, r2 

b Exit 
ReturnFalse: 
mov r0, #0 

Exit: 
bx lr 
.ltorg 
NewGameFlagRam:



