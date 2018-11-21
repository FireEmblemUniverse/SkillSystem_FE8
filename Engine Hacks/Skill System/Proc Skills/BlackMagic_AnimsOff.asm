.thumb

@r2=gMapAnimStruct, 203E1F0

push	{r14}
mov		r0,#0x59
ldrb	r0,[r2,r0]
mov		r1,#0x14
mul		r0,r1
add		r0,r2
ldr		r0,[r0]			@battle struct of whoever's being attacked at this point
mov		r1,#0x6F
ldsb	r1,[r0,r1]		@status
cmp		r1,#1
beq		GoBack
mov		r0,#0			@we only want to do the bubble if the unit's actually getting poisoned
GoBack:
pop		{r1}
bx		r1
