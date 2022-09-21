

@Author 7743, Vesly 
@
.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@
@
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ CheckCaps, 0x80181C8


.global AddUnitStatus
.type   AddUnitStatus, function

AddUnitStatus:
push	{lr}
bl GetUnitStatus
ldr r3, =MemorySlot
ldr r0, [r3, #0x0C*4] @ current stat 
ldr r1, [r3, #0x05*4] @ amount to add 
add r0, r1 
cmp r0, #127 
blt NoCap
mov r0, #127 
NoCap:
str r0, [r3, #0x05*4] @ new stat 
bl SetUnitStatus
ldr r3, =MemorySlot
ldr r0, [r3, #4*1] @ unit ID 
blh GetUnitByEventParameter
cmp r0, #0 
beq Error 
blh CheckCaps
Error:
pop {r0}
bx r0 
.ltorg 

.global SubUnitStatus
.type   SubUnitStatus, function

SubUnitStatus:
push	{lr}
bl GetUnitStatus
ldr r3, =MemorySlot
ldr r0, [r3, #0x0C*4] @ current stat 
ldr r1, [r3, #0x05*4] @ amount to sub
cmp r0, #0 @ if stat is already 0, do nothing 
beq Error2 
sub r0, r1 
cmp r0, #0
bge NoCap2
mov r0, #1 @ don't lower stats below 1 because HP 
NoCap2:
str r0, [r3, #0x05*4] @ new stat 
bl SetUnitStatus
ldr r3, =MemorySlot
ldr r0, [r3, #4*1] @ unit ID 
blh GetUnitByEventParameter
cmp r0, #0 
beq Error2 
blh CheckCaps
Error2:
pop {r0}
bx r0 
.ltorg 


