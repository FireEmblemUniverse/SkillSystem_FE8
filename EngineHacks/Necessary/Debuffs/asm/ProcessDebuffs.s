@Originally at 188A8
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ChapterData, 0x202BCF0 
.equ GetUnit, 0x8019430
.type ProcessPureWater, %function 
.global ProcessPureWater
ProcessPureWater: 
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
@no need to do anything
ldr r3, ReturnLocation
BXR3:
bx r3
.ltorg 

.global ProcessDebuffs
.type ProcessDebuffs, %function 
ProcessDebuffs: 
push {r4-r7, lr} 
mov r4, r8 
push {r4} 
ldr r0, =ChapterData 
ldrb r7, [r0, #0xF] @ phase / starting deployment ID 
mov r3, #0x40 
add r3, r7 @ ending point 
mov r8, r3 
cmp r7, #0 
beq UnitLoop 
sub r7, #1 @ players start at 1, npcs 0x40, enemies 0x80 
UnitLoop: 
add r7, #1 
cmp r7, r8  
blt Continue 
b DoneProcessDebuffs 
Continue: 
mov r0, r7 
blh GetUnit 
mov r4, r0 @ unit 

bl IsUnitOnField @(Unit* unit)
cmp r0, #0 
beq UnitLoop 

mov r0, r4 
bl GetUnitDebuffEntry
mov r5,r0
mov r0, r4 @ unit 
ldr r1, =EternalVanity_Link 
ldr r1, [r1] 
bl SkillTester 
mov r4, r0 @ @ if true, do not deplete buffed stats 


ldr r2, =DebuffStatNumberOfBits_Link
ldr r6, [r2] 

@ I dont think a loop would be any more efficient in terms of speed 
@ (but it would look nicer and take fewer lines of code) 
ldr r1, =DebuffStatBitOffset_Mag
ldr r1, [r1] 
mov r0, r5 @ unit debuff entry ram 
mov r2, r6 
bl UnpackData_Signed @ given r0 = address, r1 = bit offset, r2 = number of bits, return that data 
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
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
mov r1, r4 
bl GetNewTemporaryStatValue @ r0 = value for a debuffed/buffed stat, r1 = if true, do not deplete buffed stats 
mov r3, r0 @ to store back 
mov r0, r5 
mov r2, r6 @ # of bits 
ldr r1, =DebuffStatBitOffset_Mov
ldr r1, [r1] 
bl PackData_Signed 

ldr r1, =RalliesOffset_Link 
ldr r1, [r1] 
mov r3, #0 @ value 
mov r0, r5 @ debuff entry for unit 
ldr r2, =RalliesNumberOfBits_Link 
ldr r2, [r2] 
bl PackData

b UnitLoop
DoneProcessDebuffs:
pop {r4} 
mov r8, r4 
mov r0, #0 @ no blocking proc / animation 
pop {r4-r7}
pop {r1} 
bx r1
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
cmp r1, #1 
beq GotStatValue 
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
