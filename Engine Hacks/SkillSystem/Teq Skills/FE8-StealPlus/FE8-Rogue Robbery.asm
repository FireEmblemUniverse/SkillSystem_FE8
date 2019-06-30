.thumb

@r0=unit data ptr of unit being stolen from, r1=slot number

.equ SkillTester, Con_Getter+4
.equ StealPlusID, SkillTester+4
.equ WatchfulID, StealPlusID+4

push	{r4-r7,r14}
mov		r4,r0
mov		r5,r1
ldr		r1,WatchfulID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#1
beq		RetFalse 		@can't steal if they have watchful
lsl		r6,r5,#1
add		r6,#0x1E
ldrh	r6,[r4,r6]		@item id
cmp		r6,#0
beq		RetFalse
mov		r0,r6
ldr		r3,=#0x8017548	@get item type
mov		r14,r3
.short	0xF800
cmp		r0,#9
beq		RetTrue			@we can always steal items
mov		r7,r0
ldr		r0,=#0x3004E50	@current character
ldr		r0,[r0]
ldr		r1,StealPlusID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		RetFalse
mov		r0,r7
cmp		r0,#4
beq		RetTrue			@can steal staves without weight check
cmp		r0,#0xB
bgt		RetTrue			@only items higher than this are Rings, Fire Dragon Stone, and Dancer rings, which aren't really used. The rest are either normal or monster weapons (0xA is unused)
ldr		r7,=#0x3004E50
ldr		r7,[r7]
mov		r0,r4
ldr		r3,=#0x8016B58	@GetUnitEquippedItemSlot
mov		r14,r3
.short	0xF800
cmp		r0,r5
beq		RetFalse		@can't steal equipped weapons
mov		r0,r6
ldr		r3,=#0x801760C	@get item weight
mov		r14,r3
.short	0xF800
mov		r5,r0
mov		r0,r7
ldr		r3,Con_Getter
mov		r14,r3
.short	0xF800
cmp		r0,r5
blt		RetFalse		@if con < weight, no steal
RetTrue:
mov		r0,#1
b		GoBack
RetFalse:
mov		r0,#0
GoBack:
pop		{r4-r7}
pop		{r1}
bx		r1

.ltorg
Con_Getter:
@
