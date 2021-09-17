.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

.equ GetUnit, 0x8019430 
.equ GetItemData, 0x80177b0 @GetItemData

	.global AutoEquipAccessories
	.type   AutoEquipAccessories, function

AutoEquipAccessories:
	push {r4-r7, lr}	

mov r4,#1 @ deployment id

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham

mov r5, r0 @ unit ram 
mov r6, #0x1C 
ItemLoop:
add r6, #2 
cmp r6, #0x26 
bgt BreakItemLoop 
ldrb r0, [r5, r6] 
cmp r0, #0 
beq ItemLoop 
blh GetItemData 
ldrb r1, [r0, #0xA] @ Ability3
mov r2, #0x40 @ Accessory Bit 
tst r2, r1 
beq ItemLoop @ not accessory so continue looking through inv 
@ Set or unset as equipped here 
ldrh r0, [r5, r6] 
mov r1, #0x80 
lsl r1, #8 
orr r0, r1 
strh r0, [r5, r6] @ Equip the first accessory 
b NextUnit @ Since we equipped one, stop looping through that unit 

BreakItemLoop: 

NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
b End 
End_LoopThroughUnits:


End: 

pop {r4-r7}
pop {r0}
bx r0

.ltorg


	.global UnequipAccessories
	.type   UnequipAccessories, function

UnequipAccessories:
	push {r4-r7, lr}	

mov r4,#1 @ deployment id

LoopThroughUnits2:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit2
ldr r3,[r0]
cmp r3,#0
beq NextUnit2
ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit2
@ if you got here, unit exists and is not dead or undeployed, so go ham

mov r5, r0 @ unit ram 
mov r6, #0x1C 
ItemLoop2:
add r6, #2 
cmp r6, #0x26 
bgt BreakItemLoop2 
ldrb r0, [r5, r6] 
cmp r0, #0 
beq ItemLoop2 
blh GetItemData 
ldrb r1, [r0, #0xA] @ Ability3
mov r2, #0x40 @ Accessory Bit 
tst r2, r1 
beq ItemLoop2 @ not accessory so continue looking through inv 
@ Set or unset as equipped here 
ldrh r0, [r5, r6] 
mov r1, #0x80 
lsl r1, #8 
bic r0, r1 
strh r0, [r5, r6] @ Unequip the accessory 
b ItemLoop2 

BreakItemLoop2: 

NextUnit2:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits2
b End 
End_LoopThroughUnits2:


End2: 

pop {r4-r7}
pop {r0}
bx r0

.ltorg



























