.thumb 
.global TakeFromSupplyHook
.type TakeFromSupplyHook, %function 
TakeFromSupplyHook:
push {lr} 
mov r0, r6 
ldrh r0, [r0] 
lsl r0, #2 
add r0, r4 
ldrh r1, [r0, #2] @ item 
ldr r0, [r7, #0x2C] @ unit 

bl UnitAddItem
pop {r0} 
bx r0 
.ltorg 
.align 

