.thumb

@inserted inline at 2AEEC

.equ origin, 0x2AAEC
.equ Check_Effectiveness, . + 0x16BEC - origin
.equ Next, . + 0x2AB4A - origin
 
@r6=attacker, r8=defender, r4=attacker+0x5A (attack)

mov		r5,#0
cmp		r0,#0
beq		Label1
mov		r5,r0
Label1:
ldrh	r0,[r7]		@attacker's item
mov		r1,r8
bl		Check_Effectiveness
cmp		r0,#0
beq		Label2
cmp		r0,r5
ble		Label2
mov		r5,r0
Label2:
mov		r0,#0
ldsh	r0,[r4,r0]	@current attack
cmp		r5,#0
beq		Label3
mul		r0,r5
lsr		r0,#1
Label3:
mov		r5,r0
b		Next
