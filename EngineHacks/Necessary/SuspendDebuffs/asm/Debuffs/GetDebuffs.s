.thumb
@arguments: r0 = unit pointer
@returns: r0 = pointer to unit's debuffs

GetDebuffEntry:
cmp r0, #0x00 @ Just return NULL for a NULL unit passed in.
beq End
@get deployment number
ldrb r2,[r0,#0xb]
@get allegience from the top two bits
lsr r0,r2,#0x6

ldr r1,DebuffTables
lsl r0,r0,#0x2
ldr r0,[r1,r0]
@ cmp r0,#0x0
@ beq End

@remove the two top bits of the deployment number byte
mov r1,#0x3f
and r1,r2

@each unit currently gets 8 bytes for debuffs
lsl r1,r1,#0x3
add r0,r1

End:
bx lr
.align
.ltorg
DebuffTables:
