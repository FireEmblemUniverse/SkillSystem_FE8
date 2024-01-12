.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ Rouse _ : At the start of your turn, gain up to +4 _ if not adjacent to an ally.

.equ StrAnim, 0x01 
.equ SklAnim, 0x02 
.equ SpdAnim, 0x04 
.equ DefAnim, 0x08 
.equ ResAnim, 0x10 
.equ LukAnim, 0x20 
.equ MovAnim, 0x40 
.equ SpecAnim, 0x80 
.equ MagAnim, 0x1


.type RouseStr, %function 
.global RouseStr 
RouseStr: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Str @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseStrAmount_Link 
ldr r2, [r2] 
mov r3, #StrAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 

.type RouseMag, %function 
.global RouseMag 
RouseMag: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mag @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseMagAmount_Link 
ldr r2, [r2] 
mov r3, #MagAnim
lsl r3, #8  
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 

.type RouseSkl, %function 
.global RouseSkl 
RouseSkl: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Skl @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseSklAmount_Link 
ldr r2, [r2] 
mov r3, #SklAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 


.type RouseSpd, %function 
.global RouseSpd 
RouseSpd: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Spd @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseSpdAmount_Link 
ldr r2, [r2] 
mov r3, #SpdAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 



.type RouseDef, %function 
.global RouseDef 
RouseDef: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Def @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseDefAmount_Link 
ldr r2, [r2] 
mov r3, #DefAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 


.type RouseRes, %function 
.global RouseRes 
RouseRes: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Res @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseResAmount_Link 
ldr r2, [r2] 
mov r3, #ResAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 



.type RouseLuk, %function 
.global RouseLuk 
RouseLuk: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Luk @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseLukAmount_Link 
ldr r2, [r2] 
mov r3, #LukAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 



.type RouseMov, %function 
.global RouseMov 
RouseMov: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mov @ bit offset 
ldr r1, [r1] 
ldr r2, =RouseMovAmount_Link 
ldr r2, [r2] 
mov r3, #MovAnim 
mov r3, #MovAnim 
bl RouseStat 
pop {r0} 
bx r0 
.ltorg 


.global IsRouseApplicable
.type IsRouseApplicable, %function 
IsRouseApplicable: 
push {lr} 
mov r1, #0 @ Can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange 
cmp r0, #0 
bne Rouse_False
mov r0, #1 
b ExitRouse 
Rouse_False: 
mov r0, #0 
ExitRouse: 
pop {r1} 
bx r1 
.ltorg 


@ Rouse _ : At the start of your turn, gain up to +4 _ if not adjacent to an ally.
RouseStat: 
push {r4-r7, lr} 
mov r4, r0 @ unit 
mov r5, r1 @ bit offset 
mov r6, r2 @ amount 
mov r7, r8 
push {r7} 
mov r8, r3 @ anim bits 


mov r1, #0 @ can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange @(Unit* unit, int allyOption, int range)
cmp r0, #0 
bne NoBuff_Rouse

mov r0, r4 @ unit 
bl GetUnitDebuffEntry 
mov r7, r0 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
cmp r0, r6 @ old value vs new value 
bgt NoBuff_Rouse
cmp r0, #0 
bge UseNewValue_Rouse 
add r6, r0 @ negative, so reduce the debuff 
UseNewValue_Rouse: 
mov r0, r7 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r3, r6 @ value 
bl PackData_Signed 

mov r0, r4 @ unit 
mov r1, r8 @ rally anim bits 
mov r2, #0 @ range self 
bl StartBuffFx

NoBuff_Rouse: @ current stat is higher than what we'd set it to 

pop {r7} 
mov r8, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 














