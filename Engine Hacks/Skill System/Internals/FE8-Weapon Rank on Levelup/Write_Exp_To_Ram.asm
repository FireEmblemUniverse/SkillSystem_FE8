.thumb
.org 0x0

@jumped to from 7A7BC
@r4=battle struct ptr

ldr		r3,Func_2C0B4			@given character data, returns new weapon exp
mov		r14,r3
.short	0xF800
ldr		r3, Const_30005F4
strb	r0,[r3,#0x2]			@weapon type will be stored here later, so we'll store exp right next to it
mov		r0,r4
add		r0,#0x50
ldrb	r0,[r0]					@weapon type
mov		r1,r6
ldr		r2,Func_11704
mov		r14,r2
.short	0xF800
pop		{r4-r6}
pop		{r0}
bx		r0

.align
Const_30005F4:
.long 0x030005F4
Func_2C0B4:
.long 0x0802C0B4
Func_11704:
.long 0x08011704
