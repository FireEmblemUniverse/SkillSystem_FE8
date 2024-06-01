.thumb
.include "_Definitions.h.s"

.set paIconInfoArray,        0x02026A90

ClearIcons:
	push {lr}
	
	add sp, #-4
	
	@ r0 = 0xFFFFFFFF
	mov r0, #1
	neg r0, r0
	
	@ [sp] = 0xFFFFFFFF
	str r0, [sp]
	
	mov r0, sp @ source
	ldr r1, =paIconInfoArray @ dest
	ldr r2, =0x1000020 @ mode = fill shorts, size = 0x20*sizeof(short)
	
	svc #0xB @ 0xB is CpuSet/MemCopy
	
	add sp, #+4
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
