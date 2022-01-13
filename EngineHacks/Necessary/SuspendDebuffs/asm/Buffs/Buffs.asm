.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global prStrBuff
.type prStrBuff, %function 
prStrBuff:
push {r4-r6, lr}
mov r6, #0 @ buff starts at 0th bit 
b SpecificBuff

.global prSklBuff
.type prSklBuff, %function 
prSklBuff:
push {r4-r6, lr}
mov r6, #4 @ buff starts at 4th bit 
b SpecificBuff

.global prSpdBuff
.type prSpdBuff, %function 
prSpdBuff:
push {r4-r6, lr}
mov r6, #8 @ buff starts at 8th bit 
b SpecificBuff

.global prDefBuff
.type prDefBuff, %function 
prDefBuff:
push {r4-r6, lr}
mov r6, #12 @ buff starts at 12th bit 
b SpecificBuff

.global prResBuff
.type prResBuff, %function 
prResBuff:
push {r4-r6, lr}
mov r6, #16 @ buff starts at 16th bit 
b SpecificBuff

.global prLukBuff
.type prLukBuff, %function 
prLukBuff:
push {r4-r6, lr}
mov r6, #20 @ buff starts at 20th bit 
b SpecificBuff

.global prMagBuff
.type prMagBuff, %function 
prMagBuff:
push {r4-r6, lr}
mov r6, #24 @ buff starts at 24th bit 
b SpecificBuff



SpecificBuff:
mov r5, r0 @stat
mov r4, r1 @unit

mov r0, r4 @ Unit 
blh GetBuff 
ldr r0, [r0] @ Ram data 
mov r2, #28 @ always need 4 bits left
sub r2, r6 @ left shifts to have only 4 bits remain 
lsl r0, r2  
lsr r0, #28 
add r5, r0 
@add r5, #5 


EndDef:
mov r0, r5
mov r1, r4
pop {r4-r6,pc}
.ltorg
.align






