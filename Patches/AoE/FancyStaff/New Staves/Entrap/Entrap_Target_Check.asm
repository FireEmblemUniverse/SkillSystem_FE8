.thumb
.org 0x0

@Entrap_Target_Check
@r0 = current target's char data ptr
push	{r4,r14}
mov		r4,r0
ldr		r0,TargeterPtr
ldr		r0,[r0]
ldrb	r0,[r0,#0xB]
ldrb	r1,[r4,#0xB]
ldr		r2,Compare_Allegiance_Func
mov		r14,r2
.short	0xF800						@returns 0 if both enemies or both ally/npc, 1 otherwise
cmp		r0,#0x0
bne		GoBack
ldr		r0,[r4]
ldr		r1,[r4,#0x4]
ldr		r0,[r0,#0x28]
ldr		r1,[r1,#0x28]
orr		r0,r1
mov		r1,#0x80
lsl		r1,#0x8						@boss
tst		r0,r1
bne		GoBack
ldr		r0,Fill_Target_Queue_Func
mov		r14,r0
mov		r0,#0x10
ldsb	r0,[r4,r0]
mov		r1,#0x11
ldsb	r1,[r4,r1]
ldrb	r2,[r4,#0xB]
mov		r3,#0x0						@x coord, y coord, allegiance byte, and unknown parameters
.short	0xF800
GoBack:
pop		{r4}
pop		{r0}
bx		r0

.align
TargeterPtr:
.long 0x02033F3C
Compare_Allegiance_Func:
.long 0x08024D8C
Fill_Target_Queue_Func:
.long 0x0804F8BC
