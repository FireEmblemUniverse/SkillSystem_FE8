.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetUnitByEventParameter, 0x0800BC50
.equ MemorySlot, 0x30004B8 
.equ GetItemAttributes, 0x801756C 

.type CopyWepsToWEXP, %function 
.global CopyWepsToWEXP
CopyWepsToWEXP: 
@ given r0 = unit struct, copy inventory to wexp 
push {r4-r6, lr}
mov r4, r0 
ldrb r1, [r4, #0x0B] 
lsr r1, #6 
cmp r1, #0 
beq Exit @ if player unit, do nothing 
ldr r1, [r4] @ unit pointer 
ldrb r1, [r1, #4] @ unit id 
cmp r1, #0xE0 
bge Exit 

mov r5, #0x27
mov r6, #0x1c 
Loop: 
add r5, #1 
add r6, #2 
cmp r6, #0x28 
bge Exit 
ldrb r0, [r4, r6] 
blh GetItemAttributes
ldrb r2, [r4, r6] 
mov r1, #1 @ equip 
tst r0, r1 
bne Store 
mov r2, #0 
Store: 
strb r2, [r4, r5] 
b Loop 



Exit: 
pop {r4-r6}
pop {r0}
bx r0 
.ltorg 

