
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ Attacker, 0x203A4EC 
.equ DefExiter, 0x203A56C 
.equ GetUnit, 0x8019430
.type SelfDebuffMoves, %function 
.global SelfDebuffMoves
 
SelfDebuffMoves: 
push {r4-r7, lr}
@normally r4 = attacker, r5 = defExiter, r6 = action struct 
 
ldr r4, =Attacker 
ldr r5, =DefExiter 
@check if the action was an attack
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x2 @attack
bne Exit

mov r6, #0 

ldrb  r0, [r5,#0x13] @ if defExiter is dead, do nothing to attacker 
cmp r0, #0x00
beq Exit
@if attacker is dead but defExiter is alive, do nothing to defExiter 
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	Exit 

SelfDebuff: @ both units are alive 
mov r0, r4 
add r0, #0x4A 
ldrh r0, [r0] @ item|durb 
mov r1, #0xFF @ itemID 
and r0, r1 
mov r7, r0 @ entry ID 


lsl r0, #3 @ bytes per entry 
ldr r3, =SelfDebuffTable 
add r0, r3 
ldr r0, [r0] @ amount to debuff by 

cmp r0, #0 
beq CheckDefExiter @ skip GetUnit etc. if no debuff 

ldrb r0, [r4, #0x0B] @ deployment byte 
blh GetUnit 


blh GetUnitDebuffEntry
@mov r6, r0 @ unit debuff entry 
ldr r1, =SelfDebuffTable 
mov r2, r7 @ entry ID 


bl DebuffGivenTableEntry 







CheckDefExiter:
cmp r6, #0 
bne Exit
mov r6, #1 
ldr r4, =DefExiter 
b SelfDebuff 





Exit: 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

