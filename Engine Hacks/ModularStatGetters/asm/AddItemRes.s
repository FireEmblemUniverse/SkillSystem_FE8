.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddItemRes:
	push {r4, lr}
	
	mov r4, r0
	mov r0, r1
	
	blh 0x08016B28 @ GetUnitEquippedWeapon
	blh 0x080164E0 @ GetItemResBonus
	
	add r0, r4
	
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ none
