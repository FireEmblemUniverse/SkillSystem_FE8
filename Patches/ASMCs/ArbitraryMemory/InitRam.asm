.thumb

.equ UnitLoadBufferAddress, 0x203EFB8
.equ EndOfRam, 0x2040000 
.type InitLoadBufferRam, %function 
.global InitLoadBufferRam 
InitLoadBufferRam: 
ldr r2, =UnitLoadBufferAddress-4
ldr r3, =EndOfRam 
mov r0, #0 
Loop:
add r2, #4 
cmp r2, r3 
bge Break 
str r0, [r2] 
b Loop 
Break: 



bx lr 
.ltorg 

