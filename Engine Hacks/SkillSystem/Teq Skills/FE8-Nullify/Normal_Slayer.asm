.thumb

@called at 16C8C
@return defender's class id in r3 if attacker does have slayer

.equ SlayerID, SkillTester+4
.equ NullifyID, SlayerID+4

push	{r4-r6,r14}
mov		r4,r0		@attacker
mov		r5,r1		@defender
ldr		r0,[r5,#4]
cmp		r0,#0
beq		RetFalse
ldr		r6,SkillTester
mov		r0,r4
ldr		r1,SlayerID
mov		r14,r6
.short	0xF800
cmp		r0,#0
beq		RetFalse		@no slayer
mov		r0,r5
ldr		r1,NullifyID
mov		r14,r6
.short	0xF800
cmp		r0,#0
bne		RetFalse		@if defender has nullify, slayer does nothing
ldr		r3,[r5,#0x4]
ldrb	r3,[r3,#0x4]
mov		r1,#1
b		GoBack
RetFalse:
mov		r1,#0			@returning result in r1 instead of r0
GoBack:
pop		{r4-r6}
pop		{r2}
bx		r2

.align
SkillTester:
@
