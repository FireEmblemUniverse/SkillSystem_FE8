.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ InitVramRow, 0x80045FC 
.equ CpuFastSet, 0x80D1674 
.equ VramAddr, MaxDescLines+4 
push {r4-r7, lr} 

ldr r5, =0x10000D8 @ Vanilla uses this 
ldr r6, =0x44444444 
blh InitVramRow @ this happens to have the end of our 1st vram address in r1 after being called lol 
ldr r0, =#0x760
sub r1, r0 
mov r7, r1 @ address we're using for vram 

mov r0, r4 
add r0, #0x20 
blh InitVramRow 
mov r0, r4 
add r0, #0x28 
blh InitVramRow 


sub sp, #8 


str r6, [sp] 
mov r0, sp 
mov r1, r7 
ldr r2, =#0x1800 
add r1, r2 
mov r2, r5 
blh CpuFastSet 

str r6, [sp] 
mov r0, sp 
mov r1, r7 
ldr r2, =#0x1C00 
add r1, r2 
mov r2, r5 
blh CpuFastSet 

ldr r0, MaxDescLines 
cmp r0, #4 
ble Exit 

str r6, [sp] 
mov r0, sp 
mov r1, r7 
@ldr r1, VramAddr
ldr r2, =#0x2000 
add r1, r2 
mov r2, r5 
blh CpuFastSet 

str r6, [sp] 
mov r0, sp 
mov r1, r7 
ldr r2, =#0x2400 
add r1, r2 
mov r2, r5 
blh CpuFastSet 

Exit: 

add sp, #8 

pop {r4-r7}
pop {r0} 
bx r0 

.ltorg 
MaxDescLines: 

