.thumb
.org 0x0

@Instead of using the built-in function at A240 to copy text to ram, we do it manually and put the letter corresponding to the weapon rank

push	{r4,r5,r14}
mov		r4,r0
CharLoop:
ldrb	r2,[r0]
add		r0,#1
cmp		r2,#0
bne		CharLoop

sub		r5,r0,#1
ldr		r0,Const_30005F4
ldrb	r0,[r0,#0x2]		@weapon exp that we wrote earlier
ldr		r1,Func_16D5C		@given exp, returns rank number (0-6)
mov		r14,r1
.short	0xF800
ldr		r1,Wexp_Table
ldrb	r3,[r1,r0]
mov		r0,r5
strb	r3,[r0]
mov 	r3,#0x2E			@ '.'
strb	r3,[r0,#0x1]		
mov		r3,#0
strb	r3,[r0,#0x2]		@terminate again
GoBack:
mov		r0,r4
pop		{r4,r5}
pop		{r1}
bx		r1

.align
Func_16D5C:
.long 0x08016D5C
Const_30005F4:
.long 0x030005F4
Wexp_Table:
@
