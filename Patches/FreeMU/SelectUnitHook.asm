@ 0x1ca9c 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb 
.global SelectUnitHook
.type SelectUnitHook, %function 
SelectUnitHook: 
push {lr} 

ldr r0, [r4] @ unit pointer 
ldrb r0, [r0, #4] @ unit ID  
ldr r1, =ProtagID 
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
beq StartFMUIfPeaceful 
mov r0, r4 
blh 0x801865C @ SetupActiveUnit 
ldr r0, [r4] 
ldrb r0, [r0, #4] 
blh 0x80A474C @ BWL_IncrementMoveValue 
mov r0, r6 
blh 0x8002E94 @ BreakProcLoop 
b Exit 
StartFMUIfPeaceful:
mov r0, r4 
blh 0x801865C @ SetupActiveUnit 

mov r0, r6 
blh 0x8002E94 @ BreakProcLoop 

@blh 0x8002D6C @ proc end (player phase) 

blh 0x80225F8 @ Commnd_EndEffect
ldr r3, =FreeMoveRam
ldr r3, [r3] 
ldrb r0, [r3] 
ldr r1, =FreeMove_Silent
ldrb r1, [r1] 
orr r0, r1 
strb r0, [r3] 
@
@
@blh 0x80225F8 @ Commnd_EndEffect
bl EnableFreeMovementASMC

Exit: 
pop {r0} 
bx r0 
.ltorg 



