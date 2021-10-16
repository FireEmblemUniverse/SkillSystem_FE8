@1 1 1 1
@0 0 0 0
@0 0 0 0
@
@1st row
@end of row1 
@end of row2 
@end of row3 
@check that Y is within boundaries
@
@2nd row 
@2nd last of row1 etc
@
@3rd row 
@3rd last of row 1 etc 

.thumb 
.align 

.include "Definitions.s"

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm



.global RotateMoveMap
.type RotateMoveMap, %function 

RotateMoveMap:
push {r4-r7, lr} 

mov r6, r0 @ Old map 
mov r7, r1 @ New map 

ldr r5, =0x202E4D4 @ Map Size 
ldrh r4, [r5] 
sub r4, #1 @ XX 
ldrh r5, [r5, #2] 
sub r5, #1 @ YY 

ldr r6, [r6] @ old map 
ldr r7, [r7] @ new map 
mov r2, #0 
mov r3, #0
sub r3, #1 
Y_Loop: 
add r3, #1 
cmp r3, r5 
bgt BreakLoop
cmp r3, r4 
bgt BreakLoop
mov r2, #0 
sub r2, #1 
X_Loop:
add r2, #1 
cmp r2, r4 @map X size 
bgt Y_Loop
cmp r2, r5
bgt Y_Loop
sub r1, r4, r2 @ boundary - X as new Y 
lsl r1, #2 @4 times 
ldr r1, [r7, r1] @ Row of new map 
add r1, r3 @ Specific tile to store to 

lsl r0, r3, #2 @ y coord of old map 
add r0, r6 
ldr r0, [r0] @ row of old map 
add r0, r2 
ldrb r0, [r0] @ data of old map 

strb r0, [r1] @ stored 
b X_Loop
BreakLoop:

pop {r4-r7}
pop {r0}
bx r0 

.align 4
.ltorg 








