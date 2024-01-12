
.thumb 
.equ Init_ReturnPoint,0x8037901
.global InitTrapsHook 
.type InitTrapsHook, %function 
InitTrapsHook: 
ldr r3, =TrapInitFromEventsFunctionTable
add r3, r0 
ldr r3, [r3] 
cmp r3, #0 
beq UseJumpTable 
push {lr} 
mov lr, r3 
mov r0, r5 @ trap data 
.short 0xF800 
pop {r0} 

ldr r3, =Init_ReturnPoint 
bx r3 
.ltorg 



UseJumpTable: 

ldr r3, =TrapInitFromEventsJumpTable
add r3, r0 
ldr r0, [r3] 
mov pc, r0 
.ltorg 















