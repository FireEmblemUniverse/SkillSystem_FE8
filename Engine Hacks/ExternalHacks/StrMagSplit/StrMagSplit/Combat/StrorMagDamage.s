.thumb
.org 0x0

@r4=attacker or defender data in battle struct
mov 	r0,#0x5A
strh	r5,[r4,r0]
mov 	r0,#0x4C
mov		r7,#0x14
ldr		r0,[r4,r0]
mov		r5,#0x2
tst		r5,r0
beq		IsStr
Magic:
mov		r7,#0x3A
IsStr:
ldrb	r7,[r6,r7]
mov		r5,#0x5A
ldrh	r0,[r4,r5]	@current damage
add		r0,r7
strh	r0,[r4,r5]
b		End

End:
bx		r14
