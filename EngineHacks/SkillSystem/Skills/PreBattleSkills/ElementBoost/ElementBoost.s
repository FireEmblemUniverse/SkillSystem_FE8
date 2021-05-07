.thumb
.equ ElementBoostIDList, SkillTester+4
.equ gBattleData, 0x203A4D4
push {r3-r7, lr}

mov		r4, r0 @atkr
mov		r5, r1 @dfdr

@make sure we're in combat (or combat prep)
ldrb	r3, =gBattleData
ldrb	r3, [r3]
cmp		r3, #4
beq		EndProgram

mov		r3, #0x72
ldrb	r0, [r4, r3] @Attacker Current HP
ldrb	r1, [r5, r3] @Defender Current HP
add		r1, #0x03 @Add 3 to Defender
cmp		r0,r1
ble		EndProgram

mov		r6,#0 @Counter
CheckLoop:
mov		r0, r4
ldr     r2,ElementBoostIDList   @Load in the list of Skills.
ldrb    r1,[r2,r6]  @Load in the next Skill in the list.
ldr     r3,SkillTester
mov     lr, r3     
.short 0xf800       @Call Skill Tester.
cmp r0, #0          @Check if unit has the corresponding skill.
bne SkillChecks
SkillReturn:
add		r6, #0x01
cmp		r6, #0x04
bne		CheckLoop
b		EndProgram
SkillChecks:
cmp		r6, #0x00
beq		FireBoost
cmp		r6, #0x01
beq		WindBoost
cmp		r6, #0x02
beq		EarthBoost
cmp		r6, #0x03
beq		WaterBoost
b		SkillReturn

EndProgram:
pop		{r3-r7}
pop		{r0}
bx		r0

FireBoost:
mov		r1, #0x5A
ldrh	r0, [r4, r1]	@Atk
add		r0, #6
strh	r0, [r4,r1]
b       SkillReturn

WindBoost:
mov		r1, #0x5E
ldrh	r0, [r4, r1]	@AS
add		r0, #6
strh	r0, [r4,r1]
b       SkillReturn

EarthBoost:
mov		r1, #0x4C
ldr		r0, [r5, r1]
ldr 	r1, =#0x00000002
and 	r0, r1
cmp		r0, r1
beq 	SkillReturn
ldr 	r1, =#0x00000040
and 	r0, r1
cmp		r0, r1
beq 	SkillReturn
ProcBonus:
mov		r1, #0x5C
ldrh	r0, [r4, r1]	@Def
add		r0, #6
strh	r0, [r4,r1]
b       SkillReturn

WaterBoost:
mov		r1, #0x4C
ldr		r0, [r5, r1]
ldr 	r1, =#0x00000002
and 	r0, r1
cmp		r0, r1
beq 	ProcBonus
ldr 	r1, =#0x00000040
and 	r0, r1
cmp		r0, r1
beq 	ProcBonus
b 		SkillReturn

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN ElementBoostIDList
