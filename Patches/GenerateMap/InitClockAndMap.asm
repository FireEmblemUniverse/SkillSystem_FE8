.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ InitChapterMap, 0x80194BC
.equ AddSnagsAndWalls, 0x802E3A8
.equ GetGameClock, 0x8000D28
.equ SetOtherRNState, 0x8000CDC 
.equ GetOtherRN, 0x8000CE8 
.equ InitRN, 0x8000BC8 

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
ldr r3, =0x8030EA5 
bx r3  

.ltorg 

.type NewInitRNG, %function 
.global NewInitRNG
NewInitRNG:
push {r4, lr} 
blh GetGameClock
sub sp, #12 
mov r4, sp 
add r1, r4, #4 
mov r2, #0 
str r2, [r4, #8] 
str r2, [r4]
str r0, [r4] 

@ 
@mov r0, r4 
@ldr r0, =0x202BCF0
@add r0, #0x20 @ tact 
@str r0, [r4] 
mov r0, r4 
blh hashCode @ returns hash'd int in r0 

add sp, #12
@mov r11, r11 
blh SetOtherRNState // from 0xAA0 / 0xA20 
blh GetOtherRN
blh InitRN 

mov r1, r5 @ vanilla 
add r1, #0x2E 
mov r0, #5 
strb r0, [r1] 
pop {r4} 
pop {r0}
ldr r0, =0x80A94A1
bx r0 

.ltorg 







