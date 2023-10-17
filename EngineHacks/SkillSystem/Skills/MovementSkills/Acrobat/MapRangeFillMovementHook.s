.thumb 
.global MapRangeFillMovementHook
.type MapRangeFillMovementHook, %function 
MapRangeFillMovementHook: 
push {lr} 
mov r5, r1 
mov r0, r2 
mov r2, r3 @ unit 
ldr r3, =0x801A4CC 
mov lr, r3 
.short 0xf800 @StoreMovCostTable / Acrobat 
ldr r0, =0x202E4E4 
ldr r1, [r0] 
pop {r3} 
bx r3 
.ltorg 
