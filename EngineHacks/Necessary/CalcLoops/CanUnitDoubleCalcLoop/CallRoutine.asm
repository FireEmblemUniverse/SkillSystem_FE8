.thumb
.global CallRoutine 
.type CallRoutine, %function 
CallRoutine: 
push {lr} 
mov lr, r0 
mov r0, r1 
mov r1, r2 
mov r2, r3 
ldr r3, [sp] 
.short 0xf800 
pop {r1} 
bx r1 
.ltorg 
