.thumb
.org 0x0

ldr		r0,Rescue_Target_Func
mov		r14,r0
mov		r0,r5
ldr		r1,Entrap_Target_Func
.short	0xF800
pop		{r4-r5}
pop		{r0}
bx		r0

.align
Rescue_Target_Func:
.long 0x08029568
Entrap_Target_Func:
@
