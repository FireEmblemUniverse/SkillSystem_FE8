.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ExecTrap, 0x08037660
.equ GetUnit, 0x8019430
.equ ActionStruct, 0x203A958
.equ GetPickTrapType, 0x80375E8   

.type MyHack, %function 
.global MyHack 

MyHack:
push {r4-r7, lr} 
mov r4, #1 @ default 
mov r6, r1 @ unit struct 
mov r0, r6 
blh GetPickTrapType 
cmp r0, #0 
beq Target 

mov r0, r5 @ vanilla 
mov r1, r6 @ unit 

mov r2, #2 
blh ExecTrap 
mov r4, #0 
b Exit @ comment this line out to try and have traps hit both actor and target 

Target:


ldr r3, =ActionStruct
ldrb r0, [r3, #0x0D] @ target 
blh GetUnit 
cmp r0, #0 
beq Exit 
ldr r1, [r0] 
cmp r1, #0 
beq Exit 
ldr r1, [r0, #0x0C] @ state 
ldr r2, =0x1000C @ escaped, dead, undeployed 
tst r1, r2 
bne Exit 
mov r6, r0 @ target unit struct 
blh GetPickTrapType 
cmp r0, #0 
beq Exit 

mov r1, r6 
mov r0, r5 @ vanilla something 
mov r2, #2 @ unknown but seems to be 0, 1, 2, or 3 
blh ExecTrap
mov r4, #0 

Exit: 
mov r0, r4 

pop {r4-r7}
pop {r1} 
bx r1 
.ltorg 
