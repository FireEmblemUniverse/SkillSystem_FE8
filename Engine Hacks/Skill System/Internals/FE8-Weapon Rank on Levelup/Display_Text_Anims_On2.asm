.thumb
.org 0x0

@called at 75E10
push	{r6,r14}
mov		r6,#0
cmp		r0,#2
bne		CopyText
mov		r6,#1		@flag indicating we need to update the text later
CopyText:
ldr		r1,Func_A240
mov		r14,r1
.short	0xF800
mov		r4,r0
cmp		r6,#0
beq		NormalText
ldr		r1,Custom_Message_Func
mov		r14,r1
.short	0xF800
NormalText:
mov		r0,r5
mov		r1,#0
ldr		r2,Func_3E60
mov		r14,r2
.short	0xF800
pop		{r6}
pop		{r1}
bx		r1

.align
Func_A240:
.long 0x0800A240
Func_3E60:
.long 0x08003E60
Custom_Message_Func:
@
