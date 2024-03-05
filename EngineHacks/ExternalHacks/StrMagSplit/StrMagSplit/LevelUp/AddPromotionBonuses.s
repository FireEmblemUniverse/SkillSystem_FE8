.thumb
.org 0x0

@r4 has unit's new class data ptr, r5 = ram char ptr
ldrb	r2,[r4,#0x4]	@new class id
lsl		r2,#0x2
ldr		r1,MagClassTable
add		r2,r1
mov		r1,#0x3
ldsb	r0,[r2,r1]		@mag promo bonus
mov		r1,r5
add		r1,#0x3A
ldrb	r7,[r1]			@char mag
add		r7,r0,r7
ldrb	r0,[r2,#0x2]	@mag cap
mov r1, r5 
bl GetMaxMag 

cmp		r7,r0
ble		NotCapped
mov		r7,r0
NotCapped:
mov		r1,r5
add		r1,#0x3A
strb	r7,[r1]
mov		r0,r4
add		r0,#0x27
ldrb	r7,[r5,#0x18]
ldrb	r0,[r0]
add		r0,r7,r0
strb	r0,[r5,#0x18]
bx		r14
.ltorg 
.align
MagClassTable:
