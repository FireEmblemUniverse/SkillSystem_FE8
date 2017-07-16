.thumb

.equ ConditionRoutine, EALiterals+0x00
.equ ModifierRoutine,  EALiterals+0x04

ExecIf:
	push {r4-r5, lr}
	
	@ Storing Modifier arguments
	mov r4, r0
	mov r5, r1

	@ Calling condition
	ldr r2, ConditionRoutine
	mov lr, r2
	.short 0xF800
	
	cmp r0, #0
	beq Skip
	
	mov r0, r4
	mov r1, r5
	
	ldr r2, ModifierRoutine
	mov lr, r2
	.short 0xF800
	
	b End

Skip:
	mov r0, r4
	
End:
	pop {r4-r5}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN pCondition
	@ POIN pExec
