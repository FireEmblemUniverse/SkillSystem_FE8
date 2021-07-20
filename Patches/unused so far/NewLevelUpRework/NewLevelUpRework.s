.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CheckEventId,0x8083da8
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
	
	.equ Roll1RN, 0x8000ca0
	
	
	
	.global NewLevelUpRework
	.type   NewLevelUpRework, function

NewLevelUpRework:
push	{r4-r6,lr}

cmp r0, #0x64 
ble Roll1RNTime 
add r4, #1 
sub r0, #100 
cmp r0, #100 
bgt End 



Roll1RNTime: 
blh Roll1RN
lsl r0, #24 
cmp r0, #0 
beq End 
add r4, #1 



End: 
mov r0, r4 

	
pop {r4-r6}
pop {r1}
bx r1 



