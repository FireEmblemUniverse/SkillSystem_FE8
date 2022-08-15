.thumb
.org 0x0

mov 	r0,#0x5A
strh	r5,[r4,r0]
mov		r7,#0x14

mov 	r0,#0x4C	@weaponAttributes
ldr		r0,[r4,r0]
mov		r5,#0x40	@Magic Sword
tst		r5,r0
bne		Magic		@IsMagicSword?

mov r5, #0x2 @IsMagic
tst r5, r0
bne Magic

b IsStr

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
add		r4,#0x5A @for stone
bx		r14
