.thumb
.include "_Definitions.h.s"

.set paIconInfoArray,        0x02026A90

ClearIconGfx:
	ldr r3, =(paIconInfoArray-2)
	mov r2, #0
	
BeginLoop:
	@ Icrement iterator and index
	add r3, #2
	add r2, #1
	
	@ r1 = *it
	mov r1, #0
	ldsh r1, [r3, r1]
	
	cmp r1, r0
	bne ContinueLoop @ icon >= 0 means Not Free
	
	@ r0 = 0xFFFFFFFF
	mov r0, #1
	neg r0, r0
	
	strh r0, [r3]
	b End
	
ContinueLoop:
	cmp r2, #0x20
	bne BeginLoop
	
End:
	bx lr

.ltorg
.align

EALiterals:
	@ nothing
