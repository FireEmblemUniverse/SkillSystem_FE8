.thumb 

.global IsUnitIDNotInTableHook 
.type IsUnitIDNotInTableHook, %function 
IsUnitIDNotInTableHook: 
ldr r0, [r0, #8] 
ldr r1, [r4] 
ldrb r1, [r1, #4] @ unit ID 
lsl r1, #1 @ SHORTs 
add r0, r1  
ldrh r0, [r0] 
@bx lr 
.ltorg 


