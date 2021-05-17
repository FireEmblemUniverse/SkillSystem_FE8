.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnit, 0x8019430
	.equ GetUnitByEventParameter, 0x0800BC50


	.global GetFFFDs2Unit
	.type   GetFFFDs2Unit, function

GetFFFDs2Unit:
	push {r4-r7, lr}	

mov r4,#1 @ current deployment id
ldr r0, =MemorySlot 
ldr r5, [r0, #4*0x02] @memory slot 2 unit ID 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0] @if no unit, exit 
cmp r3,#0
beq NextUnit
ldrb r2, [r3, #4] @if unit ID does not match, exit 
cmp r2, r5 
bne NextUnit 
b 	Exit 		@now we have s2 unit ID 

NextUnit:
add r4,#1
cmp r4,#0xAF
ble LoopThroughUnits
mov r0, #0

Exit:
pop {r4-r7}
pop {r1}
bx r1

.ltorg

	

