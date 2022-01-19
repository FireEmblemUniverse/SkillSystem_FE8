.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ RamUnitTable, 0x859A5D0 @0th entry
	.equ GetUnit, 0x8019430
	.equ GetUnitByEventParameter, 0x0800BC50

	.equ CharacterTable, 0x8803D30 @0th entry 
	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
	.equ DivisionRoutine, 0x080D18FC

	.global CountReinforcementUnits
	.type   CountReinforcementUnits, function

CountReinforcementUnits:
	push {r4-r7, lr}	

mov r4,#80 @ deployment id (enemies)
mov r5,#0 @ counter

ldr r0, =MemorySlot 
ldr r6, [r0, #4*0x05] @s5 as unit group with the unit id we want 
ldrb r6, [r6] @ unit ID 


LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldrb r3, [r3, #4] @ Unit ID 
cmp r3, r6 @ only units who match our reinforcement ID 
bne NextUnit 

ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham

add r5, #1 



NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits

End_LoopThroughUnits:

ldr r2, =MemorySlot 
str r5, [r2, #4*0x0C] @ number of reinforcement units 

End: 

pop {r4-r7}
pop {r0}
bx r0

.ltorg

	

