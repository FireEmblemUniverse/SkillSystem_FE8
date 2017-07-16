.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AdjustMountedAid:
	push {r4}
	
	mov r4, r0
	
	ldr r0, [r1]
	ldr r1, [r1, #4]
	
	ldr r0, [r0, #0x28]
	ldr r1, [r1, #0x28]
	
	orr r0, r1
	
	mov r1, #0x1
	lsl r1, #14 @ Female flag = 1<<14 = 0x4000
	
	and r1, r0
	
	cmp r1, #0
	beq MaleAid
	
	mov r0, #19
	
	b Skip
	
MaleAid:
	mov r0, #24

Skip:
	sub r0, r4
	
End:
	pop {r4}
	bx lr

.ltorg
.align

EALiterals:
	@ none
