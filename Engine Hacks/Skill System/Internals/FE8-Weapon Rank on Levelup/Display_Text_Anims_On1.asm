.thumb
.org 0x0

@called at 75D00

push	{r14}
mov		r0,#2
ldr		r1,Func_A240		@copies text to ram
mov		r14,r1
.short	0xF800
mov		r4,r0
ldr		r1,Custom_Message_Func
mov		r14,r1
.short	0xF800
ldr		r1,Func_3EDC
mov		r14,r1
.short	0xF800
pop		{r1}
bx		r1

.align
Func_A240:
.long 0x0800A240
Func_3EDC:
.long 0x08003EDC
Custom_Message_Func:
@
