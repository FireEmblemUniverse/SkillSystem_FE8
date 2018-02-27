.thumb
.org 0x0

@called at from 76010

push	{r14}
add		r0,#0x4A
ldrh	r0,[r0]
str		r0,[r5,#0x4C]

ldr		r0,[r4]
ldr		r1,Func_2C0B4
mov		r14,r1
.short	0xF800				@returns new exp
ldr		r1,Const_30005F4
strb	r0,[r1,#0x2]


ldr		r0,[r4]
ldr		r1,Func_2CE9C
mov		r14,r1
.short	0xF800
pop		{r1}
bx		r1

.align
Const_30005F4:
.long 0x030005F4
Func_2C0B4:
.long 0x0802C0B4
Func_2CE9C:
.long 0x0802CE9C
