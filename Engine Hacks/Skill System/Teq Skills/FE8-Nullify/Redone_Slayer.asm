.thumb

@jumped to from 16C88

@r0=attacker battle struct, r1=defender battle struct

@Slayer table outline: BYTE class_ID multiplier is_there_another_entry 0; SHORT class_types 0

.equ SlayerID, SkillTester+4
.equ NullifyID, SlayerID+4
.equ SlayerTable, NullifyID+4

push	{r4-r6,r14}
mov		r4,r0
mov		r5,r1
ldr		r0,[r5,#0x4]
cmp		r0,#0
beq		RetFalse
mov		r0,r4
ldr		r1,SlayerID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		RetFalse
ldr		r6,SlayerTable
ldr		r3,[r4,#4]
ldrb	r3,[r3,#4]			@class id
ldr		r2,[r5,#4]
mov		r1,#0x50
ldrh	r2,[r2,r1]			@weaknesses defender unit has
SlayerLoop:
ldrb	r0,[r6]
cmp		r0,#0
beq		RetFalse
cmp		r0,r3
bne		NextSlayerTableEntry
ldrh	r0,[r6,#2]			@class types this unit has slayer against
and		r0,r2
cmp		r0,#0
bne		NullifyCheck
NextSlayerTableEntry:
add		r6,#4
b		SlayerLoop
NullifyCheck:
mov		r0,r4
ldr		r1,NullifyID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
bne		RetFalse
ldrb	r0,[r6,#1]			@multiplier
b		GoBack
RetFalse:
mov		r0,#0
GoBack:
pop		{r4-r6}
pop		{r1}
bx		r1

.align
SkillTester:
@
