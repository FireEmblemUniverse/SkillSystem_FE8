.thumb
push	{r0-r3}

ldr	r0,=#0x8000C64
mov	lr,r0
.short	0xF800

mov	r1,r0

cmp	r1,#33
bhi	_not0
mov	r0,#0
b	Random
_not0:
mov	r0,#1
cmp	r1,#66
blo	Random
mov	r0,#2

Random:
ldr	r1,IdentityRamByte
strb	r0,[r1]

pop	{r0-r3}

mov	r6,r0
ldr	r3,=#0x804EB68
mov	lr,r3
.short	0xF800

mov	r0,#1
mov	r1,#0
mov	r2,#4

ldr	r3,=#0x8098CD0
mov	lr,r3
.short	0xF800
.ltorg
.align
IdentityRamByte:
@WORD IdentityRamByte
