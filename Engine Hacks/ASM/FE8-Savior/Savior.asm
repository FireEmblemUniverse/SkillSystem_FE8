.thumb

@The savior checker for the stat screen. Paste into free space
.org 0x0
@r0 has check rescue result (0 for no rescuee), r2 has char data pointer. This function returns the stat's value in r1.
@SaviorCheck.dmp
push	{r3,r14}
ldr		r2,[r5,#0xC]	@load char struct in ram
cmp		r0,#0x0
beq		NoRescue
ldr		r3,[r2,#0x4]	@load class data
ldr		r3,[r3,#0x28]	@class abilities
mov		r0,#0x80
lsl		r0,r0,#0xF
and		r0,r3
cmp		r0,#0x0
bne		NoRescue		@has savior, so no penalties
lsl		r0,r1,#0x18
asr		r1,r0,#0x18
lsr		r0,r0,#0x1F
add		r1,r1,r0
lsr		r1,r1,#0x1
NoRescue:
pop		{r3}
pop		{r0}
bx		r0

@Fixes the arrows
.org 0x30
@r0 has 0xCth word of char struct (includes rescue) and r4,[0xC] has char data. Returns 1 if arrows should be drawn
@SaviorArrows.dmp
push	{r14}
mov		r1,#0x10
and		r0,r1
cmp		r0,#0x0
beq		GoBack
ldr		r0,[r4,#0xC]
ldr		r0,[r0,#0x4]
ldr		r0,[r0,#0x28]
mov		r1,#0x80
lsl		r1,r1,#0xF
and		r1,r0
mov		r0,#0x0
cmp		r1,#0x0
bne		GoBack
mov		r0,#0x1
GoBack:
pop		{r1}
bx		r1


.org 0x16450
SkillBonus:

.org 0x16480
SpeedBonus:

.org 0x16B28
RetEquipped:

.org 0x191D0 	@Skill
@SaviorSkl.dmp
push 	{r4,r5,r14}
mov		r4,r0
bl		RetEquipped		@given char data, returns equipped item/uses
bl		SkillBonus		@given item, returns skill bonus
mov		r1,#0x15
ldsb	r1,[r4,r1]	@skl stat in r1, skl bonus in r0
ldr		r2,[r4,#0xC]	
mov		r3,#0x10
and		r2,r3
cmp		r2,#0x0		
beq		End1			@not rescuing
ldr		r2,[r4,#0x4]
ldr		r2,[r2,#0x28]	@load class abilities
mov		r3,#0x80
lsl		r3,r3,#0xF
and		r3,r2
cmp		r3,#0x0
bne		End1
lsr		r2,r1,#0x1F
add		r1,r1,r2
asr		r1,r1,#0x1
End1:
add		r0,r0,r1
pop		{r4,r5}	
pop		{r1}
bx		r1

.org 0x19210 	@Speed
@SaviorSpd.dmp
push 	{r4,r5,r14}
mov		r4,r0
bl		RetEquipped		@given char data, returns equipped item/uses
bl		SpeedBonus		@given item, returns speed bonus
mov		r1,#0x16
ldsb	r1,[r4,r1]	@spd stat in r1, spd bonus in r0
ldr		r2,[r4,#0xC]	
mov		r3,#0x10
and		r2,r3
cmp		r2,#0x0		
beq		End2			@not rescuing
ldr		r2,[r4,#0x4]
ldr		r2,[r2,#0x28]	@load class abilities
mov		r3,#0x80
lsl		r3,r3,#0xF
and		r3,r2
cmp		r3,#0x0
bne		End2
lsr		r2,r1,#0x1F
add		r1,r1,r2
asr		r1,r1,#0x1
End2:
add		r0,r0,r1
pop		{r4,r5}
pop		{r1}
bx		r1
