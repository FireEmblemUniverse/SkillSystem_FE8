.thumb
.align

@if a rally bit is set, do an inverse stat modifier to put it back to neutral
@defender is not a parameter when in stat modifiers so we have to mimic the effect of nullifying the stat directly by nullifying it in battle calcs that use the rally-modified stat; we just check the same bit and do an inverse effect on the calced stats as if they were initially calculated with a stat that much lower

.global Lull
.type Lull, %function
Lull:
push {r4-r7,r14}
mov r4, r0 @ Attacker
mov r5, r1 @ Defender

bl GetUnitDebuffEntry 
mov r6, r0 

@ Rally mag 
mov r0, r6 
ldr r1, =MagRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq NoRallyMag

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullMagIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq NoRallyMag

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq NoRallyMag


	@we subtract 4 from Attack if either magic bit is set on weapon (this works with or without strmag split)
	mov r0,r4
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq NoRallyMag
	
	mov r0,r4
	add r0,#0x5A
	ldrh r1,[r0]
	sub r1,#4
	strh r1,[r0]
	
NoRallyMag:
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq RallyStr

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullMagIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq RallyStr

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq RallyStr

	@we subtract 2 from Attack if either magic bit is set on weapon (this works with or without strmag split)
	mov r0,r4
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq RallyStr
	
	mov r0,r4
	add r0,#0x5A
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]


RallyStr:

mov r0, r6 
ldr r1, =StrRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noStrRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullStrIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noStrRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noStrRally

	@we subtract 4 from Attack if neither magic bit is set on weapon (this works with or without strmag split)
	mov r0,r4
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	bne noStrRally
	
	mov r0,r4
	add r0,#0x5A
	ldrh r1,[r0]
	sub r1,#4
	strh r1,[r0]

noStrRally:
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq RallySpd

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullStrIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq RallySpd

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq RallySpd

	@we subtract 2 from Attack if neither magic bit is set on weapon (this works with or without strmag split)
	mov r0,r4
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	bne RallySpd
	
	mov r0,r4
	add r0,#0x5A
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]

RallySpd:

mov r0, r6 
ldr r1, =SpdRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noSpdRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpdIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noSpdRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noSpdRally

	@we subtract 4 from AS
	mov r0,r4
	add r0,#0x5E
	ldrh r1,[r0]
	mov r2,r1 @hold on to AS for a moment
	cmp r1,#4
	blt NoAS
	sub r1,#4
	b StrAS
	NoAS:
	mov r1,#0
	StrAS:
	strh r1,[r0]
	
	@using old AS and new AS, get the difference
	sub r2,r1
	lsl r2,#1 @multiply it by 2
	@now we get Avoid
	mov r0,r4
	add r0,#0x62 @avoid
	ldrb r1,[r0]
	sub r1,r2 @subtract (change in AS)*2 from avoid to simulate speed debuff
	strb r1,[r0]
	

noSpdRally:
@Rally Spectrum
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq SklRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpdIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq SklRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq SklRally

	@we subtract 2 from AS
	mov r0,r4
	add r0,#0x5E
	ldrh r1,[r0]
	mov r2,r1 @hold on to AS for a moment
	cmp r1,#2
	blt NoAS2
	sub r1,#2
	b StrAS2
	NoAS2:
	mov r1,#0
	StrAS2:
	strh r1,[r0]
	
	@using old AS and new AS, get the difference
	sub r2,r1
	lsl r2,#1 @multiply it by 2
	@now we get Avoid
	mov r0,r4
	add r0,#0x62 @avoid
	ldrb r1,[r0]
	sub r1,r2 @subtract (change in AS)*2 from avoid to simulate speed debuff
	strb r1,[r0]

SklRally:

mov r0, r6 
ldr r1, =SklRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noSklRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSklIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noSklRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noSklRally

	@we subtract 8 hit and 2 crit to simulate -4 skill
	mov r0,r4
	add r0,#0x60 @hit
	ldrh r1,[r0]
	sub r1,#8
	strh r1,[r0]

	mov r0,r4
	add r0,#0x66 @crit
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]

noSklRally:
@Rally Spectrum
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq LckRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSklIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq LckRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq LckRally

	@we subtract 4 hit and 1 crit to simulate -2 skill
	mov r0,r4
	add r0,#0x60 @hit
	ldrh r1,[r0]
	sub r1,#4
	strh r1,[r0]

	mov r0,r4
	add r0,#0x66 @crit
	ldrh r1,[r0]
	sub r1,#1
	strh r1,[r0]

LckRally:
mov r0, r6 
ldr r1, =LukRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noLuckRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullLckIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noLuckRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noLuckRally

	@we subtract 2 hit 4 avoid 4 crit avoid to simulate -4 luck
	
	mov r0,r4
	add r0,#0x60 @hit
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]
	
	mov r0,r4
	add r0,#0x62 @avoid
	ldrh r1,[r0]
	sub r1,#4
	strh r1,[r0]
	
	mov r0,r4
	add r0,#0x68 @crit avoid
	ldrh r1,[r0]
	sub r1,#4
	strh r1,[r0]
	

noLuckRally:
@Rally Spectrum
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq ResRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullLckIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq ResRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq ResRally

	@we subtract 1 hit 2 avoid 2 crit avoid to simulate -2 luck
	
	mov r0,r4
	add r0,#0x60 @hit
	ldrh r1,[r0]
	sub r1,#1
	strh r1,[r0]
	
	mov r0,r4
	add r0,#0x62 @avoid
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]
	
	mov r0,r4
	add r0,#0x68 @crit avoid
	ldrh r1,[r0]
	sub r1,#2
	strh r1,[r0]

ResRally:
mov r0, r6 
ldr r1, =ResRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noResRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullResIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noResRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noResRally

	@we subtract 4 defense if either magic bit is set on opponents weapon (this works with or without strmag split)
	mov r0,r5
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq noResRally
	
	mov r0,r4
	add r0,#0x5C @defense
	ldrb r1,[r0]
	sub r1,#4
	strb r1,[r0]
	

noResRally:
@Rally Spectrum
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq DefRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullResIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq DefRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq DefRally

	@we subtract 2 defense if either magic bit is set on opponent's weapon (this works with or without strmag split)
	mov r0,r5
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq DefRally
	
	mov r0,r4
	add r0,#0x5C @defense
	ldrb r1,[r0]
	sub r1,#2
	strb r1,[r0]

DefRally:

mov r0, r6 
ldr r1, =DefRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq noDefRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullDefIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noDefRally

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq noDefRally

	@we subtract 4 defense if neither magic bit is set on opponent's weapon (this works with or without strmag split)
	mov r0,r5
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq noDefRally
	
	mov r0,r4
	add r0,#0x5C @defense
	ldrb r1,[r0]
	sub r1,#4
	strb r1,[r0]

noDefRally:
mov r0, r6 
ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq GoBack

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullDefIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq GoBack

	@check enemy for relevant lull skills
	ldr r0,=SkillTester
	mov r14,r0
	mov r0,r5
	ldr r1,=LullSpectrumIDLink
	ldrb r1,[r1]
	.short 0xF800
	cmp r0,#0
	beq GoBack

	@we subtract 2 defense if neither magic bit is set on opponent's weapon (this works with or without strmag split)
	mov r0,r5
	add r0,#0x4C
	ldr r0,[r0]
	ldr r1,=#0x00000042
	and r0,r1
	cmp r0,#0
	beq GoBack
	
	mov r0,r4
	add r0,#0x5C @defense
	ldrb r1,[r0]
	sub r1,#2
	strb r1,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

