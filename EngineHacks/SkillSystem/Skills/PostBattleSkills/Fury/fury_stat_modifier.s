.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb
.global prSkillFury
.type prSkillFury, %function 
prSkillFury:
push {r4-r5, lr} 
mov r4, r0 @ stat 
mov r5, r1 @ unit 

ldr r1, =FuryID 
lsl r1, #24 
lsr r1, #24 
mov r0, r5 @ unit 
bl SkillTester 

cmp r0, #0 
beq Exit 
mov r0, #4 
add r0, r4 @ stat 
ldr r1, =0x3334
mul r0, r1 
asr r0, #0x10 
add r4, r0 @ 1.2x the stat (rounded up) 







Exit: 
mov r0, r4 @ stat 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 

