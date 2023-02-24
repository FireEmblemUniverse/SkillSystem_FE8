.thumb
.align


LockIDGetter_Classic: // r0 = item halfword, returns lock ID

mov r2,r0
@load weapon ability word @@@@@this is not an attacker struct we can't use the version in ram!!!
mov r1,#0xFF
and r1,r5
mov r0,#0x24
mul r1,r0
ldr r0,=ItemTable
add r0,r1
add r0,#8
ldr r0,[r0]
lsr r0,#24 @r0 = ability byte 4

bx r14

.ltorg
.align

