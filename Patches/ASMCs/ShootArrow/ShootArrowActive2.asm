.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CurrentUnit, 0x3004E50
.equ ShowUnitSMS, 0x8028130 
.equ RefreshEntityMaps, 0x801A1F4 
.equ SMS_UpdateFromGameData, 0x80271A0
.equ EndMMS, 0x80790a4 
push {lr} 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq Exit 
ldr r0, [r3, #0x0C] @ state 
mov r1, #1 
@orr r0, r1 @ hide 
bic r0, r1 @ no hide 
str r0, [r3, #0x0C] 

mov r0, r3 @ unit 
blh ShowUnitSMS 

blh RefreshEntityMaps 
blh EndMMS 
blh SMS_UpdateFromGameData 

Exit: 
pop {r0} 
bx r0 
.ltorg 

