@Originally at 188A8
.thumb
.global ProcessDebuffs
.type ProcessDebuffs, %function 
ProcessDebuffs: 

@This should do what the code in place did
cmp     r0,#0x0
beq     noBarrier
lsr     r1,r2,#0x4
sub     r1,#0x1
lsl     r0,r1,#0x4
noBarrier:
mov     r1,#0xF
mov r9, r1
and     r1,r2
cmp r1, #0x0
beq noTorch
sub r1, #0x1
mov r2, #0x1
mov r8, r2
noTorch: 
orr r0, r1
mov r3, r4
add     r3,#0x31
strb r0, [r3]

@Now the debuffs
mov r0,r4 @ unit 
push {r4-r6, lr} 
bl GetUnitDebuffEntry
mov r5,r0

ldr r2, =DebuffStatNumberOfBits_Link
ldr r6, [r2] 

@ I dont think a loop would be any more efficient in terms of speed 
@ (but it would look nicer and take fewer lines of code) 
ldr r1, =DebuffStatBitOffset_Mag
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Mag
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Str
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Str
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Skl
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Skl
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Spd
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Spd
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Def
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Def
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Res
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Res
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Luk
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Luk
ldr r1, [r1] 
bl PackData_Signed 


ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
bl PackData_Signed 



@BreakLoop: 
@
@8: Rallies (str/skl/spd/def/res/luk) (bit 7 = rally move, bit 8 = rally spectrum)
@9: Str/Skl Silver Debuff (6 bits), bit 7 = RallyMag, bit 8 = free 
ldr r1, =RalliesOffset_Link 
ldr r1, [r1] 
mov r3, #0 @ value 
mov r0, r5 @ debuff entry for unit 
ldr r2, =RalliesNumberOfBits_Link 
ldr r2, [r2] 
bl PackData
@10: mag/str/skl/spd/def/res/luk/hp tonics (+2 in each, +4 luk, +5 hp) 
@11: bit 1 = half str, bit 2 = half mag, bit 3 = hexing rod, bits 4-8 are free 

pop {r4-r6}
pop {r3} 
@no need to do anything
ldr r3, ReturnLocation
BXR3:
bx r3
.ltorg 

.global GetNewTemporaryStatValue
.type GetNewTemporaryStatValue, %function 
GetNewTemporaryStatValue:
@ given r0 as a signed buff, restore towards 0 
cmp r0, #0 
beq GotStatValue 
cmp r0, #0 
bgt DecrementBuff @ is this positive? 

@ DecrementDebuff 
ldr r2, =DebuffRestorePerTurnAmount_Link
ldr r2, [r2] 
add r0, r2 
cmp r0, #0 
ble GotStatValue 
mov r0, #0 
b GotStatValue 

DecrementBuff: 
ldr r2, =BuffDepletePerTurnAmount_Link
ldr r2, [r2] 
sub r0, r2 
cmp r0, #0 
bge GotStatValue 
mov r0, #0 
b GotStatValue 

GotStatValue: 
bx lr 
.ltorg 


.align
ReturnLocation:
    .long 0x80188E1