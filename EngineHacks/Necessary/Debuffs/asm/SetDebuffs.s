.thumb

ItemTableLocation = EALiterals+0

push {r0, lr}
@r5 = attacker
@r4 = defender
mov r0, r5
mov r1, r4
bl ApplyWeaponDebuffs
mov r0, r4
mov r1, r5
bl ApplyWeaponDebuffs
pop {r0}
@From original routine
lsl     r0,r0,#0x1
mov     r1,r4
add     r1,#0x1E
add     r0,r0,r1
add     r1,#0x2A
ldrh    r1,[r1]

pop {r2}
BXR2:
bx r2


.global ApplyWeaponDebuffs 
.type ApplyWeaponDebuffs, %function 
.ltorg 
ApplyWeaponDebuffs:
@ Apply debuffs based on each units weapon 
push {r4-r7,lr}
mov r4, r0          @r4 = unit to update
mov r5, r1          @r5 = other unit

bl GetUnitDebuffEntry 
mov r6,r0

mov r0, r5 @ other unit 
bl GetUnitDebuffEntry 
mov r7, r0 

mov r0, #0x48       @Equipped item after battle
ldrh r0, [r4, r0]   
bl GetWepDebuffByte
cmp r0, #0 
beq OppositeUnit 

mov r1, #0x80 
tst r0, r1 
beq DontHalveStr 

mov r0, r6 
ldr r1, =HalfStrBitOffset_Link 
ldr r1, [r1] 
@ given r0 = address 
@ r1 = bitoffset 
bl SetBit
b FinishedHalfStr

DontHalveStr: 
@Str was possibly halved so unhalve it (no point checking) 
mov r0, r6 
ldr r1, =HalfStrBitOffset_Link 
ldr r1, [r1] 
@ given r0 = address 
@ r1 = bitoffset 
bl UnsetBit

FinishedHalfStr: 

mov r0, #0x48       @Equipped item after battle
ldrh r0, [r4, r0]   
bl GetWepDebuffByte
mov r1, #0x40 
tst r0, r1 
beq DontHalveMag 

mov r0, r6 
ldr r1, =HalfMagBitOffset_Link 
ldr r1, [r1] 
@ given r0 = address 
@ r1 = bitoffset 
bl SetBit
b FinishedHalfMag

DontHalveMag: 
@Mag was possibly halved so unhalve it (no point checking) 
mov r0, r6 
ldr r1, =HalfMagBitOffset_Link 
ldr r1, [r1] 
@ given r0 = address 
@ r1 = bitoffset 
bl UnsetBit
FinishedHalfMag: 


mov r0, #0x48       @Equipped item after battle
ldrh r0, [r4, r0]   
bl GetWepDebuffByte
@r0 @wep debuff byte 
mov r1, r4 @ unit 
mov r2, r6 @ ram 
mov r3, r7 @ ram 
bl ProcessCombatDebuffs 

OppositeUnit: 
mov r0, #0x48       @Equipped item after battle
ldrh r0, [r5, r0]   
bl GetWepDebuffByte
mov r1, #0x1F
and r0, r1 @wep debuff byte 
mov r1, r5 @ unit 
mov r2, r7 @ ram 
mov r3, r6 @ ram 
bl ProcessCombatDebuffs 


pop {r4-r7}
pop {r0}
bx r0
.ltorg 

@ ApplyWeaponDebuffs

ProcessCombatDebuffs: 
push {r4-r7, lr} 
mov r4, #0x1f 
and r4, r0 @ wep debuff entry 

mov r0, #0x7C       @damage/hit data
ldrb r0, [r5, r0] @ always called by ApplyWeaponDebuffs 

mov r5, r8 
push {r5} 



mov r5, r1 @ unit 
mov r6, r2 @ unitA debuff ram 
mov r7, r3 @ unitB debuff ram 


mov r1, #0x1
and r0, r1

ldr r1, =RequireDamageToDebuff_Link 
ldr r1, [r1] 
cmp r1, #1 
bne AlwaysDebuff

cmp r0, #0x0
beq BreakLoop
AlwaysDebuff:
ldr r2, =DebuffNumberOfStats_Link
ldr r1, [r2] @ max 
mov r8, r1 

mov r2, #0x40 @ no 0x40 bitflag of Swap 
ldr r3, =NewWeaponDebuffTable

lsl r4, #3 @ 8 bytes per entry 
add r4, r3 @ entry we care about 

mov r5, #0 @ counter 
sub r5, #1 

Loop:
add r5, #1 
cmp r5, r8 
bge BreakLoop  

ldrb r1, [r4, r5] @ what should the next byte do 
cmp r1, #0 
beq Loop 
mov r0, r6 @ debuff entry 
mov r2, #0xC0
and r1, r2 
cmp r1, #0 
beq User 
cmp r1, #0xC0 
beq User 
mov r0, r7 @ enemy 
User: 

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
mov r0, r7 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
@push {r3} 
bl PackData_Signed 
mov r0, r7 @ debuff entry 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r1, r5 @ counter 
mul r1, r2 @ bit offset 
bl UnpackData_Signed 
@pop {r1} 
@mov r11, r11 @ this was done for testing that inputted value = outputted value 

b Loop 

BreakLoop: 
pop {r5} 
mov r8, r5 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 





GetWepDebuffByte: @ r0 = weapon id 
mov r1, #0xFF
and r0, r1
ldr r2, ItemTableLocation
mov r1, #0x24
mul r0, r1
add r2, r0          @r2 = &Item Data
mov r0, #0x21       @Offset of debuff data
ldrb r0, [r2, r0]
@r0 = debuff data.
bx lr 
.ltorg 

.align
EALiterals:
@.long ItemTableLocation

@ ItemTableLocation:
@ .long 0x08809B10
