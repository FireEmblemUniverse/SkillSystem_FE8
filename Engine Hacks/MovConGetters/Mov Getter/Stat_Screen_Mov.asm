.thumb
.org 0x0

@have to return r0=r3=-1 if 0 mov for stat screen
push	{r14}
ldr		r0,Jump_To_Mov_Getter
mov		r14,r0
ldr		r0,[r5,#0xC]
.short	0xF800
cmp		r0,#0x0
bne		NonZeroMov
mov		r0,#0x1
neg		r0,r0
mov		r3,r0
b		GoBack
NonZeroMov:
ldr		r3,[r5,#0xC]
ldr		r3,[r3,#0x4]
mov		r1,#0x12
ldsb	r3,[r3,r1]
GoBack:
pop		{r1}
bx		r1

.align
Jump_To_Mov_Getter:
@
