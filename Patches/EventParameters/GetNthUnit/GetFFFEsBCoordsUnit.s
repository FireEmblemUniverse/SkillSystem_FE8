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


	.global GetFFFEsBCoordsUnit
	.type   GetFFFEsBCoordsUnit, function

GetFFFEsBCoordsUnit:
	push {r4-r7, lr}	

mov r4,#1 @ current deployment id
ldr r0, =MemorySlot 
ldr r1, [r0, #4*0x0B] @memory slot B coords --yy--xx
lsl r5, r1, #8 @y coord
lsr r5, #24
lsl r6, r1, #24
lsr r6, #24 	@x coord 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit

ldr r3,[r0] @if no unit, exit 
cmp r3,#0
beq NextUnit

ldr r3,[r0,#0xC] @ condition word
mov r2,#0x8 @ benched
tst r3,r2
bne NextUnit

mov r1, #0x10
ldrb r2, [r0, r1] @if unit x coords do not match, exit 
cmp r2, r6 
bne NextUnit 

mov r1, #0x11
ldrb r2, [r0, r1] @if unit y coords do not match, exit 
cmp r2, r5
bne NextUnit 


b 	Finish 		@now we have s2 unit ID 

NextUnit:
add r4,#1
cmp r4,#0xAF
ble LoopThroughUnits
mov r0, #0

Finish:
pop {r4-r7}
pop {r1}
bx r1

.ltorg

	

