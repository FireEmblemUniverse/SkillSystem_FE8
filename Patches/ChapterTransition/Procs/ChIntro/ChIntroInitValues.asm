.thumb
.global ChIntroInitValues
.type ChIntroInitValues, %function 
ChIntroInitValues: 
@mov r11, r11 
mov r1, #0x2c
@ldr r2, =0x3456789A
mov r2, #0 
Loop: 
str r2, [r0, r1] 
add r1, #4 
cmp r1, #0x6C 
blt Loop 
bx lr 
.ltorg 

