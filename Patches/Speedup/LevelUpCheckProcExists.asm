.thumb
push {lr} 
ldr r3, =0x8003078
mov lr, r3 
ldr r0, =0x8587970 @ end all sound thing 
@ldr r3, =0x8009260 @ ap_clearall 
@ldr r3, =0x80053a4 @ ClearSprites 
.short 0xf800 
pop {r3} 
bx r3 
.ltorg 


