.thumb
@called at 16C00

@r3=item, r4=defender, r5=item table
@r2 is expected to be class id and r3 should be item id (currently is)

.equ NullifyID, SkillTester+4

push	{r14}
mov		r0,#0xFF
and		r0,r3
mov		r1,#0x24
mul		r0,r1
add		r6,r0,r5
ldr		r0,[r6,#0x10]		@effectiveness pointer
cmp		r0,#0
beq		RetFalse
mov		r0,r4
ldr		r1,NullifyID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
bne		RetFalse
ldrb	r3,[r6,#0x6]		@item id
ldr		r2,[r4,#0x4]
ldrb	r2,[r2,#0x4]		@class id
ldr		r1,[r6,#0x10]
b		GoBack
RetFalse:
mov		r1,#0
GoBack:
pop		{r0}
bx		r0

.align
SkillTester:
