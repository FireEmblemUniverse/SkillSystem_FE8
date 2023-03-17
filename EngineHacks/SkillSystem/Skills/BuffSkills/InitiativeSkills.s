.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ _ Init: Begin the chapter with +7 _. 
.equ ChapterData, 0x202BCF0 

.equ StrAnim, 0x01 
.equ SklAnim, 0x02 
.equ SpdAnim, 0x04 
.equ DefAnim, 0x08 
.equ ResAnim, 0x10 
.equ LukAnim, 0x20 
.equ MovAnim, 0x40 
.equ SpecAnim, 0x80 
.equ MagAnim, 0x1




.global CleverInit 
.type CleverInit, %function 
CleverInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #MagAnim @ bits 
lsl r1, #8 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Mag @ bit offset 
ldr r1, [r1] 
ldr r2, =CleverInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global StrongInit 
.type StrongInit, %function 
StrongInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #StrAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Str @ bit offset 
ldr r1, [r1] 
ldr r2, =StrongInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global DeftInit 
.type DeftInit, %function 
DeftInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #SklAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Skl @ bit offset 
ldr r1, [r1] 
ldr r2, =DeftInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global QuickInit 
.type QuickInit, %function 
QuickInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #SpdAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Spd @ bit offset 
ldr r1, [r1] 
ldr r2, =QuickInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global LuckyInit 
.type LuckyInit, %function 
LuckyInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #LukAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Luk @ bit offset 
ldr r1, [r1] 
ldr r2, =LuckyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global SturdyInit 
.type SturdyInit, %function 
SturdyInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #DefAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Def @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 



.global CalmInit 
.type CalmInit, %function 
CalmInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #ResAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Res @ bit offset 
ldr r1, [r1] 
ldr r2, =CalmInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 

.global NimbleInit 
.type NimbleInit, %function 
NimbleInit: 
push {lr} 
@ given r0 = unit 
push {r0} 
@ r0 = unit 
mov r1, #MovAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx
pop {r0} 
ldr r1, =DebuffStatBitOffset_Mov @ bit offset 
ldr r1, [r1] 
ldr r2, =NimbleInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
pop {r0} 
bx r0 
.ltorg 


.global IsInitApplicable
.type IsInitApplicable, %function 
IsInitApplicable: 
push {lr} 
ldr r3, =ChapterData 
ldrh r3, [r3, #0x10] @ Turn # 
cmp r3, #1 @ turn starts at 1 
bne Init_False
mov r0, #1 
b ExitInit
Init_False: 
mov r0, #0 
ExitInit: 
pop {r1} 
bx r1 
.ltorg 

.global SpectrumInit 
.type SpectrumInit, %function 
SpectrumInit: 
ldr r3, =ChapterData 
ldrh r3, [r3, #0x10] @ Turn # 
cmp r3, #1 @ turn starts at 1 
beq ProceedSpec 
bx lr @ do nothing if not first turn 
ProceedSpec: 
push {r4, lr} 
mov r4, r0 @ unit

mov r1, #SpecAnim @ bits 
mov r2, #0 @ range (self) 
bl StartBuffFx

mov r0, r4 @ unit 
ldr r1, =DebuffStatBitOffset_Mag @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Str @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Skl @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Spd @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Def @ bit offset 
ldr r1, [r1] 
ldr r2, =SturdyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Res @ bit offset 
ldr r1, [r1] 
ldr r2, =CalmInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Luk @ bit offset 
ldr r1, [r1] 
ldr r2, =LuckyInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat
mov r0, r4 
ldr r1, =DebuffStatBitOffset_Mov @ bit offset 
ldr r1, [r1] 
ldr r2, =NimbleInitAmount_Link
ldr r2, [r2] 
bl InitiativeForStat



pop {r4} 
pop {r0} 
bx r0 
.ltorg 



InitiativeForStat: 
push {r4-r7, lr} 



mov r4, r0 @ unit 
mov r5, r1 @ bit offset 
mov r6, r2 @ amount 

mov r0, r4 
bl GetUnitDebuffEntry 
mov r7, r0 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
cmp r0, r6 @ old value vs new value 
bgt NoBuffInitiative 
cmp r0, #0 
bge UseNewValueInitiative 
add r6, r0 @ negative, so reduce the debuff 
UseNewValueInitiative: 
mov r0, r7 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r3, r6 @ value 
bl PackData_Signed 
NoBuffInitiative: @ current stat is higher than what we'd set it to 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 












