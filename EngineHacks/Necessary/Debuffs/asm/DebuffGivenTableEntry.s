.thumb 

.global DebuffGivenTableEntry
.type DebuffGivenTableEntry, %function 
DebuffGivenTableEntry: 
push {r4-r7, lr} 
mov r4, r8 
push {r4} 

mov r6, r0 @ debuff entry 
@r1 debuff table to use 
@r2 entry ID of the given table 
mov r8, r3 @ enemy debuff entry 

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

ldrb r1, [r7, r5] @ what should the next byte do 
cmp r1, #0 
beq Loop 
mov r0, r6 @ debuff entry 
mov r2, #0xC0
and r1, r2 
cmp r1, #0 
beq User 
cmp r1, #0xC0 
beq User 
mov r0, r8 @ enemy 
User: 

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
b AffectEnemy 

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
beq AffectEnemy 

AffectUser:  
mov r0, r6 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl PackData_Signed 
b Loop 


AffectEnemy: 
mov r0, r8 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl PackData_Signed 
@mov r0, r6 @ debuff entry 
@ldr r2, =DebuffStatNumberOfBits_Link
@ldr r2, [r2] 
@mov r1, r5 @ counter 
@mul r1, r2 @ bit offset 
@bl UnpackData_Signed @ ???????????? 
@mov r11, r11 @ this was done for testing that inputted value = outputted value 
b Loop 

End: 

pop {r4} 
mov r8, r4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

