.thumb 
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ HandleAllegianceChange, 0x801034D 
	.equ EventEngine, 0x800D07C
	
	.equ GetUnit, 0x8019431

	.global GetDurabilityHPBonus
	.type   GetDurabilityHPBonus, function
			GetDurabilityHPBonus:
push {r4, lr}
mov r4, #0 @ Byte 0 is hp 
b GetBonus 


	.global GetDurabilityPowBonus
	.type   GetDurabilityPowBonus, function
			GetDurabilityPowBonus:
push {r4, lr}
mov r4, #1 @ Byte 1 is str 
b GetBonus 

	.global GetDurabilityMagBonus
	.type   GetDurabilityMagBonus, function
			GetDurabilityMagBonus:
push {r4, lr}
mov r4, #9 @ Byte 9 is mag
b GetBonus 

	.global GetDurabilitySklBonus
	.type   GetDurabilitySklBonus, function
			GetDurabilitySklBonus:
push {r4, lr}
mov r4, #2 @ Byte 2 is skl 
b GetBonus 

	.global GetDurabilitySpdBonus
	.type   GetDurabilitySpdBonus, function
			GetDurabilitySpdBonus:
push {r4, lr}
mov r4, #3 @ Byte 3 is spd 
b GetBonus 

	.global GetDurabilityLckBonus
	.type   GetDurabilityLckBonus, function
			GetDurabilityLckBonus:
push {r4, lr}
mov r4, #6 @ Byte 0 is luck 
b GetBonus 

	.global GetDurabilityDefBonus
	.type   GetDurabilityDefBonus, function
			GetDurabilityDefBonus:
push {r4, lr}
mov r4, #4 @ Byte 4 is def 
b GetBonus 

	.global GetDurabilityResBonus
	.type   GetDurabilityResBonus, function
			GetDurabilityResBonus:
push {r4, lr}
mov r4, #5 @ Byte 0 is res 
b GetBonus 

@ 7 and 8 are prob mov/con or something 



GetBonus:



cmp r0, #0 
beq ExitGetDurabilityPowBonus
@check for AE_Shield here ? 



ldr r3, =DurabilityStatBonusTable 
lsl r2, r0, #2 @ 4 bytes per entry - r0 is durability && 0x3F 
add r3, r2 
ldr r0, [r3] @ POIN to stat bonus 
ldrb r0, [r0, r4] 
@mov r11, r11 

ExitGetDurabilityPowBonus:


pop {r4}
pop {r1}
bx r1 





