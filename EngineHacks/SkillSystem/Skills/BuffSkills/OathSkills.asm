.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ StrAnim, 0x01 
.equ SklAnim, 0x02 
.equ SpdAnim, 0x04 
.equ DefAnim, 0x08 
.equ ResAnim, 0x10 
.equ LukAnim, 0x20 
.equ MovAnim, 0x40 
.equ SpecAnim, 0x80 
.equ MagAnim, 0x1

@ _ Oath : At the start of your turn, gain up to +4 _ if adjacent to an ally.

.type OathStr, %function 
.global OathStr 
OathStr: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Str @ bit offset 
ldr r1, [r1] 
ldr r2, =OathStrAmount_Link 
ldr r2, [r2] 
mov r3, #StrAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 



.type OathMag, %function 
.global OathMag 
OathMag: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mag @ bit offset 
ldr r1, [r1] 
ldr r2, =OathMagAmount_Link 
ldr r2, [r2] 
mov r3, #MagAnim
lsl r3, #8  
bl OathStat 
pop {r0} 
bx r0 
.ltorg 


.type OathSkl, %function 
.global OathSkl 
OathSkl: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Skl @ bit offset 
ldr r1, [r1] 
ldr r2, =OathSklAmount_Link 
ldr r2, [r2] 
mov r3, #SklAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 


.type OathSpd, %function 
.global OathSpd 
OathSpd: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Spd @ bit offset 
ldr r1, [r1] 
ldr r2, =OathSpdAmount_Link 
ldr r2, [r2] 
mov r3, #SpdAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 



.type OathDef, %function 
.global OathDef 
OathDef: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Def @ bit offset 
ldr r1, [r1] 
ldr r2, =OathDefAmount_Link 
ldr r2, [r2] 
mov r3, #DefAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 


.type OathRes, %function 
.global OathRes 
OathRes: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Res @ bit offset 
ldr r1, [r1] 
ldr r2, =OathResAmount_Link 
ldr r2, [r2] 
mov r3, #ResAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 


.type OathLuk, %function 
.global OathLuk 
OathLuk: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Luk @ bit offset 
ldr r1, [r1] 
ldr r2, =OathLukAmount_Link 
ldr r2, [r2] 
mov r3, #LukAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 

.type OathMov, %function 
.global OathMov 
OathMov: 
push {lr} 
@ given r0 = unit 
ldr r1, =DebuffStatBitOffset_Mov @ bit offset 
ldr r1, [r1] 
ldr r2, =OathMovAmount_Link 
ldr r2, [r2] 
mov r3, #MovAnim 
bl OathStat 
pop {r0} 
bx r0 
.ltorg 


.global IsOathApplicable
.type IsOathApplicable, %function 
IsOathApplicable: 
push {lr} 
mov r1, #0 @ Can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange 
cmp r0, #0 
beq Oath_False
mov r0, #1 
b ExitOath 
Oath_False: 
mov r0, #0 
ExitOath: 
pop {r1} 
bx r1 
.ltorg 


@ _ Oath : At the start of your turn, gain up to +4 _ if adjacent to an ally.
OathStat: 
push {r4-r7, lr} 
mov r4, r0 @ unit 
mov r5, r1 @ bit offset 
mov r6, r2 @ amount 
mov r7, r8 
push {r7} 
mov r8, r3 @ anim bits 

mov r0, r4 @ unit 
mov r1, #0 @ can trade 
mov r2, #1 @ adjacent 
bl GetUnitsInRange @(Unit* unit, int allyOption, int range)
cmp r0, #0 
beq NoBuff_Oath

mov r0, r4 @ unit 
bl GetUnitDebuffEntry 
mov r7, r0 @ debuff entry 
mov r1, r5 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
cmp r0, r6 @ old value vs new value 
bgt NoBuff_Oath
cmp r0, #0 
bge UseNewValue_Oath 
add r6, r0 @ negative, so reduce the debuff 
UseNewValue_Oath: 
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

NoBuff_Oath: @ current stat is higher than what we'd set it to 

pop {r7} 
mov r8, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 






