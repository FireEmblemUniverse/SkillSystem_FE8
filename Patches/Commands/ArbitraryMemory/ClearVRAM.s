.thumb


.global ClearVRAM_ASMC 
.type ClearVRAM_ASMC, %function 

ClearVRAM_ASMC: 
push {r4-r5, lr} 
ldr r4, =0x6011400 
ldr r5, =0x6012FFF 
mov r0, #0 
Loop: 
add r4, #4 
str r0, [r4] 
cmp r4, r5 
blt Loop 
pop {r4-r5} 
pop {r0}
bx r0 


