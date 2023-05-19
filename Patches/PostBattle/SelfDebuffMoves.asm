
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
@check if the action was an attack
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x2 @attack
bne End

mov r6, #0 

ldrb  r0, [r5,#0x13] @ if defender is dead, do nothing to attacker 
cmp r0, #0x00
beq End
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
mov r7, r0 @ entry ID 


lsl r0, #3 @ bytes per entry 
ldr r3, =SelfDebuffTable 
add r0, r3 
ldr r0, [r0] @ amount to debuff by 

cmp r0, #0 
beq CheckDefender @ skip GetUnit etc. if no debuff 

ldrb r0, [r4, #0x0B] @ deployment byte 
blh GetUnit 


blh GetUnitDebuffEntry
@mov r6, r0 @ unit debuff entry 
ldr r1, =SelfDebuffTable 
mov r2, r7 @ entry ID 


bl DebuffGivenTableEntry 







CheckDefender:
cmp r6, #0 
bne Exit
mov r6, #1 
ldr r4, =Defender 
b SelfDebuff 





Exit: 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.global DebuffGivenTableEntry
.type DebuffGivenTableEntry, %function 
DebuffGivenTableEntry: 
push {r4-r7, lr} 
mov r6, r0 @ debuff entry 
@r1 debuff table to use 
@r2 entry ID of the given table 

lsl r2, #3 @ 8 bytes per entry 
add r1, r2 @ table entry we desire 
mov r7, r1 @ table entry 

@ r5 = counter of which stat we're on 
ldr r2, =DebuffNumberOfStats_Link
ldr r1, [r2] @ max 
mov r4, r1 

mov r2, #0x40 @ no 0x40 bitflag of Swap 

mov r5, #0 @ counter 
sub r5, #1 

Loop:
add r5, #1 
cmp r5, r4 
bge End

mov r0, r6 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl UnpackData_Signed 
@ r0 as data 
mov r2, #0x40 
ldrb r1, [r7, r5] @ table data uses a byte per stat 


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
b End

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
beq End 

AffectUser:  
mov r0, r6 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl PackData_Signed 
b Loop 

End: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


