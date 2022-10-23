.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC50
	
.type EnsureMovementCap, %function 
.global EnsureMovementCap 
EnsureMovementCap: 
push {r4, lr} 

ldr r3, =MemorySlot 
ldr r0, [r3, #4] @ slot 1 as unit 
blh GetUnitByEventParameter 
cmp r0, #0 
beq Exit 
mov r4, r0 @ unit 

bl prMovGetter

ldr r2, =MaxMovementValue
lsl r2, #24 
lsr r2, #24 
cmp r0, r2 
ble Exit 

sub r0, r2 @ amount we're over by 
ldrb r1, [r4, #0x1D] @ mov bonus 
sub r1, r0 
cmp r1, #0 
bge NoLowerCap 
mov r1, #0 
NoLowerCap:
strb r1, [r4, #0x1D] @ set mov bonus to be within bounds 

Exit: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

