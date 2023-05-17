
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ Attacker, 0x203A4EC 
.equ Defender, 0x203A56C 
.equ GetUnit, 0x8019430
.type SelfDebuffMoves, %function 
.global SelfDebuffMoves
 
SelfDebuffMoves: 
push {r4-r7, lr}
@normally r4 = attacker, r5 = defender, r6 = action struct 
ldr r4, =Attacker 
ldr r5, =Defender 
@ r6 = actiondata
mov r4, r8 
push {r4} 

@check if the action was an attack
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x2 @attack
bne End

ldrb  r0, [r5,#0x13] @ if defender is dead, do nothing to attacker 
cmp r0, #0x00
beq End

mov r7, #0 
@if attacker is dead but defender is alive, do nothing to defender 
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End 

SelfDebuff: @ both units are alive 
mov r0, r4 
add r0, #0x4A 
ldrh r0, [r0] @ item|durb 
mov r1, #0xFF @ itemID 
and r0, r1 
mov r4, r0 @ entry ID 


lsl r0, #3 @ bytes per entry 
ldr r3, =SelfDebuffTable 
add r3, r0 
mov r7, r3 
ldr r3, [r7] @ amount to debuff by 

cmp r3, #0 
beq CheckDefender @ skip GetUnit etc. if no debuff 

ldrb r0, [r4, #0x0B] @ deployment byte 
blh GetUnit 


blh GetUnitDebuffEntry
mov r6, r0 @ unit to debuff 





AlwaysDebuff:
ldr r2, =DebuffNumberOfStats_Link
ldr r1, [r2] @ max 
mov r8, r1 

mov r2, #0x40 @ no 0x40 bitflag of Swap 
ldr r3, =SelfDebuffTable

lsl r4, #3 @ 8 bytes per entry 
add r4, r3 @ entry we care about 

mov r5, #0 @ counter 
sub r5, #1 

Loop:
add r5, #1 
cmp r5, r8 
bge End

mov r0, r6 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl UnpackData_Signed 
@ r0 as data 
mov r2, #0x40 
ldrb r1, [r4, r5] @ table data uses a byte per stat 


@ positive affects user 
@ positive swap affects opponent 
@ negative affects enemy 
@ negative swap affects self 

@ if new value is positive 
@ > positive old value, replace 
@ < positive old value, ignore 
@ negative old value, add 

@ if new value is negative 
@ > old value, ignore 
@ < old value, replace 
@ positive old value, add 

cmp r1, #0 
beq Loop 
cmp r1, #0x80 
bge NegativeA 

@ new value is positive 
mov r3, r1 
bic r3, r2 @ remove 0x40 swap bitflag 
cmp r0, #0 
bge DontAddToValue 
adc r3, r0 @ to remove negatives first 
DontAddToValue: 
cmp r3, r0 
blt Loop @ if buffed stat is worse than what we already had, do nothing 
tst r1, r2 
beq AffectUser
b CheckDefender

NegativeA: @ new value will be negative 
mov r3, #0x3F 
and r3, r1 
neg r3, r3 
cmp r0, #0 
ble DontAddToValue_Negative
adc r3, r0 @ to remove positives first 
DontAddToValue_Negative: 
cmp r3, r0 
bgt Loop @ if debuffed stat is less bad than before (a higher # since we're negative), do nothing 
tst r1, r2 
beq CheckDefender 

AffectUser:  
mov r0, r6 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl PackData_Signed 
b Loop 












CheckDefender:
cmp r7, #0 
bne End 
mov r7, #1 
mov r4, r5 
b SelfDebuff 






End: 

pop {r4} 
mov r8, r4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


