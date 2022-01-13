.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global ProcessBuffs 
.type ProcessBuffs, %function 
ProcessBuffs: 
push {r4-r7, lr}
push {r0-r2}
mov r4, r0 @ Unit 

blh GetBuff 
mov r5, r0 @ ram address of buff 
mov r6, #32 @ Counter 
ldr r0, [r5]
cmp r0, #0 
beq ExitLoop 



Loop:
sub r6, #4 @ 4 bits each loop 
cmp r6, #0 
ble ExitLoop 

ldr r7, [r5]
mov r0, r7 
lsl r0, r6
@mov r2, #28 
@sub r2, r6 

mov r2, #28 
lsr r0, r2 
mov r1, r7 

mov r1, #0xF 
and r1, r0 
cmp r1, #0 
beq Loop 

ldr r2, =BuffDepletePerTurnAmountLink 
ldr r2, [r2] 
cmp r1, r2 
bge NoCap 
mov r1, r2 @ so r1 will be 0 
NoCap: 
sub r1, r2 @ -X from the buff per turn 


mov r2, #28
sub r2, r6

lsl r1, r2 @ back to the offset / stat 
mov r3, #0xF 
lsl r3, r2 

 
bic r7, r3 @ remove all bits at that offset 
orr r7, r1 @ turn on all new bits at that offset 
str r7, [r5] 
b Loop 

ExitLoop: 

pop {r0-r2}
pop {r4-r7}
pop {r3}
bx r3 

.align

