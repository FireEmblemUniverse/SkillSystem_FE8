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

	.global GetNthUnitID
	.type   GetNthUnitID, function

GetNthUnitID:
	push {r4-r7, lr}	

mov r4,#1 @ deployment id
mov r5,#0 @ counter

ldr r0, =MemorySlot 
ldr r6, [r0, #4*0x01] @s1 as what valid deployment # to stop at
						@eg. the 5th valid unit 
cmp r6, #0
beq End_LoopThroughUnits
cmp r6, #0x3F 
bgt End_LoopThroughUnits

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
ldr r3, [r0]
mov r0, #0
ldrb r0, [r3, #4] @Unit ID 
ldr r2, =MemorySlot 
str r0, [r2, #4*0x0C]

add r5,#1
cmp r5,r6
bge End_LoopThroughUnits
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
End_LoopThroughUnits:
pop {r4-r7}
pop {r0}
bx r0

.ltorg

	

