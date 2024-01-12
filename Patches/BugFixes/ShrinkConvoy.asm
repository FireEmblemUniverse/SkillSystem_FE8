.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@ 3152C 
push {r4-r7, lr} 

ldr r7, =0x8031576 
ldrb r7, [r7] @ convoy size 
ldr r6, =0x803156C 
ldr r6, [r6] @ generic buffer 
mov r0, #0 @ value 
mov r1, r6 @ generic buffer 
mov r2, r7 @ size in slots 
lsl r2, #1 @ need a short per item 
@mov r3, #2 
@CPU_FILL(0, gGenericBuffer, 0x2000, 32) blh 0x0x80D1678 @ CPUSet ? 
Loop1: 
cmp r2, #0 
blt BreakLoop 
strh r0, [r1, r2] 
sub r2, #2 
b Loop1
BreakLoop: 

mov r4, r6 
blh 0x8031500 @ GetConvoyItemArray 
mov r1, r0 
mov r5, #0 
Loop: 
ldrh r0, [r1] 
cmp r0, #0 
beq Skip 
strh r0, [r4] 
add r4, #2 
Skip: 
add r1, #2
add r5, #1 
cmp r5, r7 
bls Loop 
mov r0, #0 
strh r0, [r4] 
blh 0x8031508 @ ClearConvoyItems 
blh 0x8031500 @ GetConvoyItemArray 
mov r1, r0 
mov r0, r6 
mov r2, r5 
blh 0x80D1678 @ CPUSet 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 









