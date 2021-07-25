.thumb


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ CanUnitUseAsWeapon, 0x08016574

.global GetVanillaEquipped
.type GetVanillaEquipped, %function
GetVanillaEquipped: 
push { r4 - r6, lr }

mov r6, r0 
mov r5, #0x0 
LoopStart:
lsl r1, r5, #0x1 
mov r0, r6 
add r0, #0x1E
add r4, r0, r1 
ldrh r1, [r4] 
mov r0, r6 
blh CanUnitUseAsWeapon 
lsl r0, r0, #0x18 
asr r0, r0, #0x18 
cmp r0, #0x1 
bne Skip
ldrh r0, [r4]
b End
Skip:
add r5, #0x1 
cmp r5, #0x4 
ble LoopStart
mov r0, #0x0 


End:
pop { r4 - r6 } 
pop { r1} 
bx r1 









