.thumb
.org 0x0

@r0=char data ptr
push	{r14}
ldr		r1,[r0,#0x4]
mov		r2,#0x11
ldsb	r1,[r1,r2]		@class con
ldr		r2,[r0]
mov		r3,#0x13
ldsb	r2,[r2,r3]		@class con
add		r1,r2
mov		r2,#0x1A
ldsb	r0,[r0,r2]
add		r0,r1
GoBack:
pop		{r1}
bx		r1
