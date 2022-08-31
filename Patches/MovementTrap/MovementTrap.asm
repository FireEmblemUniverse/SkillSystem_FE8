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
.equ ExecTrapForDropUnit, 0x80377F0 @ 321B8 
.equ NewBlockingProc, 0x8002CE0 
.equ gProcApplyTrapDroppedUnit, 0x859DA6C 
.equ EnsureCameraOntoActiveUnitPosition, 0x801D31C 

@proc: 859DA6C called around 32250 
@ see 3223C or so 
@ str unit struct into new blocking proc + 0x54 

.type MyHack, %function 
.global MyHack 

MyHack:
push {r4-r6, lr} 
mov r5, r0 @ parent proc 
mov r4, #1 @ default to continue 
ldr r3, =ActionStruct
ldrb r0, [r3, #0x11] @ action type 
cmp r0, #0x23 @ new action types start here? 
blt Exit 

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
blh GetPickTrapType @ r0 = unit 
cmp r0, #0 
beq Exit 

ldr r0, =gProcApplyTrapDroppedUnit 
mov r1, r5 @ parent proc 
blh NewBlockingProc 
str r6, [r0, #0x54] @ store unit struct as vanilla does at 32240 


mov r4, #0 

Exit: 
@blh EnsureCameraOntoActiveUnitPosition 
@and r0, r4 @ if both are 1, continue. If either need time, yield.  
mov r0, r4 

pop {r4-r6}
pop {r1} 
bx r1 
.ltorg 
