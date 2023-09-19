.thumb 
push {lr} 
ldr r1, =0x3004980 
cmp r0, #0 
beq End 
lsl r0, #2 
add r0, r1 
ldr r0, [r0] 
ldr r3, =0x8005738 
mov lr, r3 
.short 0xf800 
End: 
pop {r0} 
bx r0 
.ltorg 
