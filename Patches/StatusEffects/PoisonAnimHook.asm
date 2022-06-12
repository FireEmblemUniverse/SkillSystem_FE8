.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb @ based on $7CCC0 
.equ UnLZ77Decompress, 0x8012F50 
.equ GetUnit, 0x8019430 

.type PoisonAnimHook, %function 
.global PoisonAnimHook
PoisonAnimHook:
push {r4, lr}

ldr r0, =0x203A958 @ gActionData 
ldrb r0, [r0, #0x0C] @ subject index 
blh GetUnit 
mov r11, r11 
cmp r0, #0 
beq PoisonAnim
mov r4, r0 
ldr r0, [r4] @ char pointer 
cmp r0, #0 
beq PoisonAnim 
ldr r0, [r4, #0x0C] 
ldr r1, =0x1000C @ escaped, dead, undeployed 
tst r0, r1 
bne PoisonAnim 
mov r1, #0x30 @ status 
ldrb r0, [r4, r1] 
ldr r1, =BurnStatusID_Link
ldrb r1, [r1] 
tst r0, r1 
bne BurnAnim 
ldr r1, =TrappedStatusID_Link
ldrb r1, [r1] 
tst r0, r1 
bne VortexAnim 
b PoisonAnim @ if all else fails, default to poison 

VortexAnim:
ldr r0, =VortexAnimation
ldr r1, =0x6013800 @ obj tile to insert to 
blh UnLZ77Decompress 
@ldr r0, =0x89AE204 @ poison animation palette 
ldr r0, =VortexPal
b Exit 

BurnAnim: 
ldr r0, =BurnAnimation
ldr r1, =0x6013800 @ obj tile to insert to 
blh UnLZ77Decompress 
@ldr r0, =0x89AE204 @ poison animation palette 
ldr r0, =BurnPal
b Exit 

PoisonAnim: 
ldr r0, =PoisonAnimation
ldr r1, =0x6013800 @ obj tile to insert to 
blh UnLZ77Decompress 
@ldr r0, =0x89AE204 @ poison animation palette 
ldr r0, =PoisonPal

Exit: 
mov r1, #0xA0 
lsl r1, #2 


pop {r4} 
pop {r3} 
bx r3 
.ltorg 




