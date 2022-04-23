.thumb 


push {r6, lr}
mov r2, #0x80 
lsl r2, #4 @ Riding Ballista 
and r1, r2 
mov r10, r0 
cmp r1, #0 
bne ReturnAsBallista 

@ some condition as to not steal 
mov r0, #0x41 @ AI 4 
ldrb r0, [r3, r0] 
mov r1, #0x20 @ BossAI 
tst r0, r1 
bne DoNotSteal

PossiblySteal:
pop {r6} 
ldr r3, [r6] 
pop {r2}
ldr r2, =0x803D4C5 @ return to possibly steal 
bx r2 

DoNotSteal:
pop {r6} 
ldr r3, [r6] 
pop {r2}
ldr r2, =0x803D4D5 @ return without stealing 
mov r0, #0 
cmp r0, #0 
bx r2 
@beq do not steal 

ReturnAsBallista:
pop {r6} 
pop {r3} 
ldr r3, =0x803D479 
bx r3 


.ltorg 
.align 













