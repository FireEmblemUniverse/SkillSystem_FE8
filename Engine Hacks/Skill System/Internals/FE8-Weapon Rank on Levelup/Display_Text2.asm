.thumb
.org 0x0

add		r4,sp,#0x10
ldr		r0,[r5,#0x4]		@should be either 1 or 2, refers to text ids. If 2, then we want to put our own message instead (1 is just a space, for whatever reason)
ldr		r1,Func_A240		@copies text to ram
mov		r14,r1
.short	0xF800
ldr		r1,[r5,#0x4]
cmp		r1,#0x2
bne		GoBack
ldr		r1,Custom_Message_Func
mov		r14,r1
.short	0xF800
GoBack:
ldr		r1,Addr_1113D
bx		r1

.align
Func_A240:
.long 0x0800A240
Addr_1113D:
.long 0x0801113C+1
Custom_Message_Func:
@
