.thumb
@Master Key Usability
@r0 holds ram character pointer
.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

push 	{r4,r14}
mov 	r4, r0
_blh 	ChestCheck
cmp 	r0, #0x0
bne TrueCase
mov 	r0, r4
_blh 	 DoorCheck		@check if next to a door tile?
cmp 	r0, #0x0
bne TrueCase
mov r0, #0x0
b PopBack

TrueCase:
mov 	r0, #0x1
PopBack:
pop {r4}
pop {r15}
@bx r1
.align
.ltorg
