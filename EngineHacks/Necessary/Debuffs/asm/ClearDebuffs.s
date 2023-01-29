.thumb
	CpuSet           = 0x080D1678|1

.global ClearAllDebuffs 
.type ClearAllDebuffs, %function 
ClearAllDebuffs:
	mov r0, #0

	push {r0, lr}

	mov r0, sp
	ldr r1, =DebuffTableRam_Link
	ldr r1, [r1] 

	mov r3, #1
	lsl r3, #24

	ldr r2, =DebuffTableSize_Link
	ldr r2, [r2] 
	lsr r2, #1
	orr r2, r3

	ldr r3, =CpuSet

	bl BXR3

	pop {r0, r3}

BXR3:
	bx r3
.ltorg 

.global ClearUnitDebuffs 
.type ClearUnitDebuffs, %function 
ClearUnitDebuffs: 
push {lr} 
@ given r0 = unit 
bl GetUnitDebuffEntry
mov r1, #0x0
mov r2, #0 
sub r2, #1 
ldr r3, =DebuffEntrySize_Link
ldr r3, [r3] 
Loop: 
add r2, #1 
cmp r2, r3 
bge Break 
strb r1, [r0, r2]                @Clear out this byte 
b Loop 

Break: 
pop {r0} 
bx r0 
.ltorg 



