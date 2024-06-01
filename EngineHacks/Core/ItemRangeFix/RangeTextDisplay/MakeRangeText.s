.thumb
@arguments
@	r0: max rnage
@	r1: min range
@	r2: range text flag, if 0 only show range numbers
@r0 has item id/uses short

push 	{r4-r5,r14}
mov 	r5, r0
mov 	r4, r1
@mov 	r6, r2

ldr		r0,BlankTextID		@actually 3 spaces, not blank, but blank for our purposes

ldr 	r3, =#0x800A240			@takes r0=text id as an argument, returns ram pointer to modify
mov 	r14, r3
.short 0xF800

cmp		r5,r4
bne		DiffMinMax
cmp 	r4, #0x0
beq 	End

mov		r1,#0x0
strb	r1,[r0,#0x6]
mov		r1,#0x1F
strb	r1,[r0,#0x5]
mov		r1,#0x7F
strb	r1,[r0,#0x2]
mov		r1,#0x20
strb	r1,[r0]
strb	r1,[r0,#0x1]
strb	r1,[r0,#0x2]
cmp		r4,#0xA
blt		NotDoubleDigits
sub		r4,#0xA
mov		r1,#0x31
NotDoubleDigits:
add		r4,#0x30
strb	r1,[r0,#0x3]
strb	r4,[r0,#0x4]
b		End
@<space> <space> <space> <tens digit> <ones digit> <(I think this means 'ignore this character')> <terminator>

DiffMinMax:
mov		r1,#0x0
strb	r1,[r0,#0x5]
mov		r1,#0x7F
strb	r1,[r0,#0x2]
cmp		r4,#0xA
blt		MinNotDoubleDigits
sub		r4,#0xA
mov		r1,#0x31
strb	r1,[r0]				@if tens digit is not there, 0x20 is already written, so we are ok		
MinNotDoubleDigits:
add		r4,#0x30
strb	r4,[r0,#0x1]
mov		r1,#0x1F
add		r5,#0x30
cmp		r5,#0x3A
blt		MaxNotDoubleDigits
sub		r5,#0xA
mov		r1,r5
mov		r5,#0x31
MaxNotDoubleDigits:
strb	r5,[r0,#0x3]
strb	r1,[r0,#0x4]
@<min tens digit> <min ones digit> <dash> <max tens digit> <max ones digit> <terminator> (if max doesn't have a tens digit, write the ones digit there and 1F to 0x4)

End:
pop		{r4-r5}
pop		{r1}
bx		r1

.align
.ltorg

BlankTextID:
.long 0x0000052B
ItemTable:
@.long 0x08B09B10
