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
	.global Get7thUnit
	.type   Get7thUnit, function
	.global Get7thUnitASMC
	.type   Get7thUnitASMC, function

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
Get7thUnitASMC:
push {lr} 
bl Get7thUnit 
ldr r3, =MemorySlot 
str r0, [r3, #4*0x0C] 
pop {r0} 
bx r0 
.ltorg 


Get7thUnit:
	push {r4-r7, lr}	
	mov r6, #7
	b Start
.align 
Start: 

mov r4,#1 @ current deployment id
mov r5,#0 @ counter

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0,#0xC] @ condition word
ldr r2, =#0x1000C @ escaped, benched/dead
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


