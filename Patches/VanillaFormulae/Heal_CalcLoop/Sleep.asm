.thumb 
.global SleepFunc 
.type SleepFunc, %function 
SleepFunc:
push {r4-r5,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %


mov r1, #0x30 @ Sleep 
ldrb r0, [r4, r1] 
mov r1, #0xF 
and r0, r1 
ldr r2, =SleepStatusID
lsl r2, #24 
lsr r2, #24 
cmp r2, r0 
bne NoHeal 
mov r0, #35 @ Sleep heals 35% hp. 
add r5,r0


NoHeal:
mov r0, r5 
pop {r4-r5}
pop {r1}
bx r1 
