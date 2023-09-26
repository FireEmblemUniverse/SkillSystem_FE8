.thumb
.global CallMapAddInRange
.type CallMapAddInRange, %function 
CallMapAddInRange: 
push {r4, lr} 
ldr r4, =IRAM_MapAddInRange_Link
ldr r4, [r4] 
bl bxr4 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 
bxr4: 
bx r4 
.ltorg 

