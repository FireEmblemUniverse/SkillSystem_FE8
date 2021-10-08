.thumb
.org 0x0

ldr		r0,Rescue_Usability_Func
mov		r14,r0
mov		r0,r4
ldr		r1,Entrap_Target_Func
.short	0xF800
pop		{r4-r5}
pop		{r1}
bx		r1

.align
Rescue_Usability_Func:
.long 0x08029068
Entrap_Target_Func:
@
