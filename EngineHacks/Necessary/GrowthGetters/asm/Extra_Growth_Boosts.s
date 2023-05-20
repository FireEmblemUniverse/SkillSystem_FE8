.thumb
.org 0x0

.equ GrowthModifiers, Growth_Options+4
@r0=battle struct or char data ptr, r1 = growth so far (from char data), r2=index in stat booster pointer of growth

push	{r4-r7,r14}
mov		r7,r8
push	{r7}
mov		r4,r0
mov		r5,r1		@growth
mov		r8,r1		@save the base stat again
mov		r6,r2
ldr		r7,Growth_Options
mov		r0,#0x1		@is fixed mode even allowed
tst		r0,r7
beq		GrowthLoop	@if not, don't bother testing further and go ahead
ldr		r0,Check_Event_ID
mov		r14,r0
lsr		r0,r7,#0x10	@event id
.short	0xF800
cmp		r0,#0x0
beq		GrowthLoop	@if event not set, then we're in normal growths mode
mov		r0,#0x2 	@bit is set to signify that if fixed mode is on, crusader scrolls and the metis tome don't do anything
tst		r0,r7
bne		GoBack	

GrowthLoop:
push {r7}
ldr r7, GrowthModifiers
Loop:
ldr r2, [r7]
cmp r2, #0x0
beq EndLoop
    mov r14, r2
    .short 0xF800
    add r7, #0x4
    b Loop

EndLoop:
pop {r7}
GoBack:
mov		r1,r8
mov		r0,r5
cmp		r0,#0x0
bge		Label1
mov		r0,#0
Label1:
pop		{r7}
mov		r8,r7
pop		{r4-r7}
pop		{r2}
bx		r2

.align
Check_Event_ID:
.long 0x08083DA8
Growth_Options:
@
