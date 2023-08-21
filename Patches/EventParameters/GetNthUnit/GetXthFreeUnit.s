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


	.global Get1stFreeUnit
	.type   Get1stFreeUnit, function
	.global Get2ndFreeUnit
	.type   Get2ndFreeUnit, function
	.global Get3rdFreeUnit
	.type   Get3rdFreeUnit, function
	.global Get4thFreeUnit
	.type   Get4thFreeUnit, function
	.global Get5thFreeUnit
	.type   Get5thFreeUnit, function
	.global Get6thFreeUnit
	.type   Get6thFreeUnit, function

	

Get1stFreeUnit:
	push {r4-r7, lr}	
	mov r6, #1
	b Start

Get2ndFreeUnit:
	push {r4-r7, lr}	
	mov r6, #2
	b Start
	
Get3rdFreeUnit:
	push {r4-r7, lr}	
	mov r6, #3
	b Start

Get4thFreeUnit:
	push {r4-r7, lr}	
	mov r6, #4
	b Start

Get5thFreeUnit:
	push {r4-r7, lr}	
	mov r6, #5
	b Start

Get6thFreeUnit:
	push {r4-r7, lr}	
	mov r6, #6
	b Start

Start: 

mov r4,#1 @ current deployment id
mov r5,#0 @ counter

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0,#0xC] @ condition word
@ if you add +1 to include Hide (eg 0x4F), it'll ignore the active unit, which may be useful 
mov r2,#0x4E @ moved/dead/undeployed/cantoing 
tst r3,r2
bne NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldrb r3, [r3, #4] 
ldr r2, =ProtagID_Link 
ldr r2, [r2] 
cmp r2, r3 
beq NextUnit @ ignore protag 
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

	

