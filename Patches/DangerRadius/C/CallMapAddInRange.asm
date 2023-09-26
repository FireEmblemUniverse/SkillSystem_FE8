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

.global CallForEachInMovementRange
.type CallForEachInMovementRange, %function 
CallForEachInMovementRange: 
push {lr} 
ldr r3, =IRAM_ForEachInMovementRange_Link
ldr r3, [r3] 
bl bxr3  
pop {r0} 
bx r0 
.ltorg 
bxr3: 
bx r3 
.ltorg 


