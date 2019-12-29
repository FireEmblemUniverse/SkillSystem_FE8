.thumb
.org 0x0

@r0 = stat, r1 = unit pointer

push	{r4,r14}
mov		r4,r0
mov		r0,r1
ldr		r3,Is_Capture_Set
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		GoBack
lsr		r4,#1
GoBack:
mov		r0,r4
pop		{r4}
pop		{r1}
bx		r1

.align
Is_Capture_Set:

@ldr		r2,LungeMarker
@ldrb	r2,[r2]
@cmp		r2,#0x6
@bne		GoBack
@lsr		r0,#1
@GoBack:
@bx		r14

@.align
@LungeMarker: @1 is rescue, 2 is pair up, 0 is nothing, 3 is lunge, 4 is mercy, 5 is gamble, 6 is capture
@.long 0x203f101
