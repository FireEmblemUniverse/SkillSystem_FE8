.thumb
.org 0x0

push	{r14}
ldrb	r1,[r4,#0x18]
add		r1,r1,r0
strb	r1,[r4,#0x18]
ldr		r0,GetGrowthChance
mov		r14,r0
ldr		r0,[r4]
ldrb	r0,[r0,#0x4]		@char number
lsl		r0,#0x1
ldr		r1,MagCharTable
add		r0,r1
ldrb	r0,[r0,#0x1]
mov		r1,r5
.short	0xF800
mov		r1,r4
add		r1,#0x3A
ldrb	r2,[r1]
add		r2,r0,r2
strb	r2,[r1]
ldr		r0,GetGrowthChance
mov		r14,r0
ldr		r0,[r4]
add		r0,#0x21
ldrb	r0,[r0]
lsl 	r0 ,r0 ,#0x18
asr		r0 ,r0 ,#0x18
mov		r1,r5
.short	0xF800
ldrb	r1,[r4,#0x19]
add		r1,r1,r0
strb	r1,[r4,#0x19]
ldr		r0,GetGrowthChance
mov		r14,r0
ldr 	r0, [r4, #0x4]
add 	r0, #0x22
ldrb 	r0, [r0, #0x0]
lsl 	r0 ,r0 ,#0x18
asr 	r0 ,r0 ,#0x18
mov 	r1 ,r5
pop		{r1}
bx		r1

.align
GetGrowthChance:
.long 0x0802B9C4
MagCharTable:
