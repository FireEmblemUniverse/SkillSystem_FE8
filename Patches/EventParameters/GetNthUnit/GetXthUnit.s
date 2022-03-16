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


	.global Get1stUnit
	.type   Get1stUnit, function
	.global Get2ndUnit
	.type   Get2ndUnit, function
	.global Get3rdUnit
	.type   Get3rdUnit, function
	.global Get4thUnit
	.type   Get4thUnit, function
	.global Get5thUnit
	.type   Get5thUnit, function
	.global Get6thUnit
	.type   Get6thUnit, function

	

Get1stUnit:
	push {r4-r7, lr}	
	mov r6, #1
	b Start
.align 
Get2ndUnit:
	push {r4-r7, lr}	
	mov r6, #2
	b Start
.align 
Get3rdUnit:
	push {r4-r7, lr}	
	mov r6, #3
	b Start
.align 
Get4thUnit:
	push {r4-r7, lr}	
	mov r6, #4
	b Start
.align 
Get5thUnit:
	push {r4-r7, lr}	
	mov r6, #5
	b Start
.align 
Get6thUnit:
	push {r4-r7, lr}	
	mov r6, #6
	b Start
.align 
Start: 

mov r4,#1 @ current deployment id
mov r5,#0 @ counter

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
mov r1, r0 
mov r0, #0
cmp r1,#0
beq NextUnit
ldr r3,[r1]
cmp r3,#0
beq NextUnit
ldr r3,[r1,#0xC] @ condition word
ldr r2, =#0x1000C @ escaped, benched/dead
tst r3,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
mov r0, r1 
add r5,#1
cmp r5,r6
bge End_LoopThroughUnits
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
mov r0, #0
End_LoopThroughUnits:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align 
	

