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

ldr	r3,=#0x809AE94
mov	lr,r3

pop	{r0-r3}

mov	r0,#2
neg	r0,r0
and	r0,r1
mov	r1,#0x3

.short	0xF800
.ltorg
.align
IdentityRamByte:
@WORD IdentityRamByte
