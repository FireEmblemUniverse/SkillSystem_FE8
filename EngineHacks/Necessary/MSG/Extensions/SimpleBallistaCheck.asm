.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.macro blh2 to, reg=r3
	ldr \reg, \to
	mov lr, \reg
	.short 0xF800
.endm

SimpleBallistaCheck:
	push {r4-r5, lr}
	mov  r5, r0 @stat
	mov  r4, r1 @unit
	
	ldr  r0, [r4, #0xC]
	mov  r1, #0x80        
	lsl  r1, r1, #0x4		@Check "in ballista" bit
	and  r0, r1
	cmp  r0, #0x0
	beq  NotInBallista
	
	@get a non-empty ballista at unit position
	mov  r0, #0x10
	ldsb r0, [r4, r0]
	mov  r1, #0x11
	ldsb r1, [r4, r1]
	blh  #0x803798C 		@GetBallistaItemAt
	cmp  r0, #0x0
	beq  NotInBallista
	
		mov  r5, r0
		b    End

NotInBallista:
	mov r5, #0x0
	b End

End:
	mov r0, r5
	mov r1, r4
	pop {r4-r5,pc}
	.ltorg
	.align
