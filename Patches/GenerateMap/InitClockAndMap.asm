.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ InitChapterMap, 0x80194BC
.equ AddSnagsAndWalls, 0x802E3A8
.equ GetGameClock, 0x8000D28

.type InitClockAndMap, %function 
.global InitClockAndMap
InitClockAndMap: 
PUSH {r4, lr}  
mov r4, r0 
blh GetGameClock
str r0, [r5, #4] @ vanilla 
mov r0, r4 
blh InitChapterMap
blh AddSnagsAndWalls

mov r2, #0
pop {r4}  
pop {r3}
add r3, #20
bx r3  

.ltorg 


