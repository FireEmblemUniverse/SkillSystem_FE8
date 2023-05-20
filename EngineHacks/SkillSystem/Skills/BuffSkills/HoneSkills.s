.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetUnit, 0x8019430

@ Hone _ : At the start of your turn, give adjacent allies up to +3 _

.equ StrAnim, 0x01 
.equ SklAnim, 0x02 
.equ SpdAnim, 0x04 
.equ DefAnim, 0x08 
.equ ResAnim, 0x10 
.equ LukAnim, 0x20 
.equ MovAnim, 0x40 
.equ SpecAnim, 0x80 
.equ MagAnim, 0x1



@ HoneStat, OathStat, and RouseStat functions are very similar 
@ Hone loops, Oath and Rouse check if the list is empty or not 

.type HoneStr, %function 
.global HoneStr 
HoneStr: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Str @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneStrAmount_Link 
ldr r2, [r2] 
mov r3, #StrAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 



.type HoneMag, %function 
.global HoneMag 
HoneMag: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mag @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneMagAmount_Link 
ldr r2, [r2] 
mov r3, #MagAnim
lsl r3, #8  
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 




.type HoneSkl, %function 
.global HoneSkl 
HoneSkl: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Skl @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneSklAmount_Link 
ldr r2, [r2] 
mov r3, #SklAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 


.type HoneSpd, %function 
.global HoneSpd 
HoneSpd: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Spd @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneSpdAmount_Link 
ldr r2, [r2] 
mov r3, #SpdAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 


.type HoneDef, %function 
.global HoneDef 
HoneDef: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Def @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneDefAmount_Link 
ldr r2, [r2] 
mov r3, #DefAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 


.type HoneRes, %function 
.global HoneRes 
HoneRes: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Res @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneResAmount_Link 
ldr r2, [r2] 
mov r3, #ResAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 


.type HoneLuk, %function 
.global HoneLuk 
HoneLuk: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Luk @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneLukAmount_Link 
ldr r2, [r2] 
mov r3, #LukAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 

.type HoneMov, %function 
.global HoneMov 
HoneMov: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mov @ bit offset 
ldr r1, [r1] 
ldr r2, =HoneMovAmount_Link 
ldr r2, [r2] 
mov r3, #MovAnim 
bl HoneStat 
pop {r0} 
bx r0 
.ltorg 

.global IsHoneApplicable
.type IsHoneApplicable, %function 
IsHoneApplicable: 
push {lr} 
mov r1, #0 @ Can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange 
cmp r0, #0 
beq Hone_False
mov r0, #1 
b ExitHone 
Hone_False: 
mov r0, #0 
ExitHone: 
pop {r1} 
bx r1 
.ltorg 

HoneStat: 
push {r4-r7, lr} 
mov r4, r0 @ unit 
mov r5, r1 @ bit offset 
mov r6, r2 @ amount 
mov r7, r8 
push {r7} 
mov r8, r3 @ rally anim bits 
mov r3, r9 
push {r3} 
mov r9, r4 @ unit 
mov r0, r4 @ unit 

mov r1, #0 @ can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange @(Unit* unit, int allyOption, int range)
cmp r0, #0 
beq NoMoreHone
mov r4, r0 

AreaLoop: 
ldrb r0, [r4] 
cmp r0, #0 
beq NoMoreHone 
add r4, #1 
blh GetUnit 
mov r9, r0 
bl GetUnitDebuffEntry 
mov r7, r0 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
cmp r0, r6 @ old value vs new value 
bgt NoBuff 
mov r3, r6 
cmp r0, #0 
bge UseNewValue 
add r3, r0 @ negative, so reduce the debuff 
UseNewValue: 
mov r0, r7 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
@ r3 = value 
bl PackData_Signed 
mov r0, r9 @ unit 
mov r1, r8 @ rally anim bits 
mov r2, #0 @ range adjacent 
bl StartBuffFx

NoBuff: @ current stat is higher than what we'd set it to 
b AreaLoop 

NoMoreHone: 
pop {r3} 
mov r9, r3 
pop {r7} 
mov r8, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 







