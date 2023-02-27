.thumb
.align


LockIDGetter_New: // r0 = item halfword, returns lock ID

mov r2,r0
@load weapon ability word @@@@@this is not an attacker struct we can't use the version in ram!!!
mov r1,#0xFF
and r1,r2
mov r0,#0x24
mul r1,r0
ldr r0,=ItemTable
add r0,r1
add r0,#8
ldr r0,[r0]
mov r1,#0x1
lsl r1,#24 
and r0,r1
cmp r0,#0
beq GoBack

@ use the item ID to index a separate table for the lock ID
mov r0,#0xFF
and r0,r2
ldr r1,=LockAssociationTable
add r0,r1
ldrb r0,[r0]

GoBack:
bx r14

.ltorg
.align

