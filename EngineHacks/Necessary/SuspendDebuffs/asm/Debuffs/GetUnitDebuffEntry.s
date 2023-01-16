.thumb
@arguments: r0 = unit pointer
@returns: r0 = pointer to unit's debuffs
.global GetUnitDebuffEntry 
.type GetUnitDebuffEntry, %function 
GetUnitDebuffEntry:
cmp r0, #0x00 @ Just return NULL for a NULL unit passed in.
beq End
@get deployment number
ldrb r2,[r0,#0xb]
@get allegience from the top two bits
lsr r0,r2,#0x6

ldr r1, =TeamDebuffTables
lsl r0,r0,#0x2 @ WORD ram address 
add r0, r1 
ldr r0, [r0] @ specific table we want 
@ cmp r0,#0x0
@ beq End

@remove the two top bits of the deployment number byte
mov r1,#0x3f
and r1,r2

ldr r2, =DebuffEntrySize_Link
ldr r2, [r2] 
mul r1, r2 
add r0,r1

End:
bx lr
.ltorg 
