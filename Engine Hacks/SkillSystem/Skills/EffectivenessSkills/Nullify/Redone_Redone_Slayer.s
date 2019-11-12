.thumb

@jumped to from 16C88

@r0=attacker battle struct, r1=defender battle struct

@Slayer table outline: BYTE class_ID multiplier is_there_another_entry 0; SHORT class_types 0

@tequila why the h*ck are you checking the slayer table after checking the skill making it still hardcoded to classes
@this version just checks a given class type EA literal

.equ SlayerID, SkillTester+4
.equ NullifyID, SlayerID+4
.equ SlayerClassType, NullifyID+4
.equ SkybreakerID, SlayerClassType+4
.equ SkybreakerClassType,SkybreakerID+4
.equ ResourcefulID,SkybreakerClassType+4

push	{r4-r6,r14}
mov		r4,r0
mov		r5,r1
ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		RetFalse

Slayer:
mov		r0,r4
ldr		r1,SlayerID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		Skybreaker

ldr		r2,[r5,#4]
mov		r1,#0x50
ldrh	r2,[r2,r1]			@weaknesses defender unit has
ldrh 	r0,SlayerClassType
and		r0,r2
cmp		r0,#0
bne		NullifyCheck

Skybreaker:
mov		r0,r4
ldr		r1,SkybreakerID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		RetFalse

ldr		r2,[r5,#4]
mov		r1,#0x50
ldrh	r2,[r2,r1]			@weaknesses defender unit has
ldrh 	r0,SkybreakerClassType
and		r0,r2
cmp		r0,#0
bne		NullifyCheck
b		RetFalse

NullifyCheck:
mov		r0,r4
ldr		r1,NullifyID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
bne		RetFalse

mov		r0,#6
mov		r6,r0
ldr		r0,SkillTester
mov		r14,r0
mov		r0,r4
ldr		r1,ResourcefulID	
.short	0xF800
cmp		r0,#0
beq		GoBack
lsl		r6,#1
b 		GoBack

RetFalse:
mov		r6,#0
GoBack:
mov		r0,r6
pop		{r4-r6}
pop		{r1}
bx		r1

.ltorg
.align
SkillTester:
@
