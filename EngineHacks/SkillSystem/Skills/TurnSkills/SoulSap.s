.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ GetUnit, 0x8019430
.equ DivideBy5Constant, 0x3334

.global SoulSap_CanUnitHeal
.type SoulSap_CanUnitHeal, %function 
SoulSap_CanUnitHeal: 
push {r4, lr} 
mov r4, r0 @ unit 
@r0 = unit 
mov r1, #4 @ all units 
mov r2, #2 @ within 2 tiles 
bl GetUnitsInRange 
cmp r0, #0 
beq SoulSap_UnitCannotHeal 
mov r0, #1 
b SoulSap_ExitUsability 
SoulSap_UnitCannotHeal: 
mov r0, #0 
SoulSap_ExitUsability: 
pop {r4}
pop {r1} 
bx r1 
.ltorg 

.global SoulSap_HealAmount
.type SoulSap_HealAmount, %function 
SoulSap_HealAmount: 
push {r4-r7, lr} 
mov r4, r0 @ unit 
mov r1, #4 @ all units 
mov r2, #2 @ within 2 tiles 
bl GetUnitsInRange 
cmp r0, #0 
beq Error 
mov r5, r0 @ units list 
sub r5, #1 
mov r6, #0 @ amount to heal 
ldrb r0, [r4, #0x12] 
ldrb r1, [r4, #0x13] 
sub r0, r1 
mov r7, r0 @ total amount we would be happy to heal by 

Loop: 
add r5, #1 
ldrb r0, [r5] 
cmp r0, #0 
beq CalcAmount 
blh GetUnit 
ldrb r1, [r0, #0x12] @ max hp
ldr r2, =DivideBy5Constant 
mul r1, r2 
asr r1, #0x11 @ shift to overall divide by 10 
ldrb r2, [r0, #0x13] @ current hp 
sub r2, r1 
cmp r2, #0 
bgt NoFloorHp 
add r2, r1 
mov r3, #1
sub r2, r3 
mov r1, r2 @ real amount to heal  
mov r2, r3 @ hp to leave the drained unit with 
NoFloorHp: 
strb r2, [r0, #0x13] 
add r6, r1 
cmp r6, r7 
ble Loop
mov r1, r6 
sub r1, r7 
@ extra hp we shouldn't have drained 
ldrb r2, [r0, #0x13] 
add r2, r1 
strb r2, [r0, #0x13] @ store it back 




CalcAmount: 
mov r0, r6 
b Exit_SoulSap_HealAmount 


Error: 
mov r0, #1 
Exit_SoulSap_HealAmount: 
pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 
