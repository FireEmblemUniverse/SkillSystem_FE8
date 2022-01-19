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

	.global GetNthUnit
	.type   GetNthUnit, function

GetNthUnit:
	push {r4-r7, lr}	

mov r4,#1 @ deployment id
mov r5,#0 @ counter
LoopThroughUnits:
mov r0,r4
@ldr r3, =GetUnit @ 19430
@	bl bxr3
blh GetUnit 
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit
@r3 is unit pointer now 

ldr r2, =MemorySlot3 
str r3, [r2, #4*0x3]

ldr r2, =CharacterTable
sub r0, r3, r2 @r3 is the UnitStructPointer
mov r1, #0x34 
blh DivisionRoutine @ 0x080D18FC
@this breaks it atm 
ldr r2, =MemorySlot 
str r0, [r2, #4*0x03] 
str r0, [r2, #4*0x0C] 



@ if you got here, unit exists and is not dead or undeployed, so go ham
add r5,#1
cmp r5,#6
bge End_LoopThroughUnits
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
End_LoopThroughUnits:
pop {r4-r7}
pop {r3}
bxr3:	bx r3

.ltorg

	

