.thumb
.equ AirRaidSkillIDList, SkillTester+4
.equ gBattleData, 0x203a4d4
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@make sure we're in combat (or battle forecast)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

@terrain check
ldr r0, [r5,#0x04] @defender class data pointer
mov r1, #0x38
ldr r0, [r0,r1] @Move costs pointer

mov 	r3,#0x55
ldrb	r1,[r4,r3] @attackers tileID

ldrb r3,[r0,r1]
cmp r3,#0xFF
bne End @defender can pass terrain so end

@skill checkloop stuff
mov     r6,#0 @loop counter
CheckLoop:
ldr     r1,AirRaidSkillIDList    @Load in the list of AirRaid Skills.
ldrb    r1,[r1,r6]  @Load in the next Blow Skill in the list.
mov     r0,r4        @Store attacker data into r0 (for the purposes of SkillTester).
ldr        r3,SkillTester
mov     lr, r3        
.short 0xf800        @Call Skill Tester.
cmp r0, #0            @Check if unit has the corresponding AirRaid skill.
bne     SkillChecks

SkillReturn:
add     r6, #0x01
cmp     r6, #0x07
bne     CheckLoop
b       End

SkillChecks:
cmp     r6, #0x00
beq     AtkRaid
cmp		r6, #0x01
beq 	SpdRaid
cmp		r6,	#0x02
beq		DefRaid
cmp 	r6, #0x03
beq		CrtRaid
cmp		r6, #0x04
beq		HitRaid
cmp		r6, #0x05
beq		AvoRaid
cmp		r6, #0x06
beq		ResRaid
b SkillReturn

AtkRaid:
mov r0, r4
add r0,#0x5A	@attacker atk
ldrh r3,[r0]
add r3,#5		@add +5 atk
strh r3,[r0]
b SkillReturn

SpdRaid:
mov r0, r4
add r0,#0x5E	@attacker AS
ldrh r3,[r0]
add r3,#5		@add +5 AS
strh r3,[r0]
b SkillReturn

DefRaid:
mov r0, r5
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne SkillReturn @do nothing if magic bit set
mov r2, #0x2
lsl r2, #0x10 @0x20000 negate def/res 
tst r1, r2
bne SkillReturn
mov r0, r4
add r0,#0x5C	@attacker def
ldrh r3,[r0]
add r3,#5		@add +5 def
strh r3,[r0]
b SkillReturn

CrtRaid:
mov r0, r4
add r0,#0x66	@attacker crit
ldrh r3,[r0]
add r3,#15		@add +15 crit
strh r3,[r0]
b SkillReturn

HitRaid:
mov r0, r4
add r0,#0x60	@attacker hit
ldrh r3,[r0]
add r3,#15		@add +15 hit
strh r3,[r0]
b SkillReturn

AvoRaid:
mov r0, r4
add r0,#0x62	@attacker avo
ldrh r3,[r0]
add r3,#15		@add +15 avo
strh r3,[r0]
b SkillReturn

ResRaid:
mov r0, r5
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
beq SkillReturn @do nothing if magic bit not set
mov r2, #0x2
lsl r2, #0x10 @0x20000 negate def/res 
tst r1, r2
bne SkillReturn
mov r0, r4
add r0,#0x5C	@attacker def
ldrh r3,[r0]
add r3,#5		@add +5 def
strh r3,[r0]
b SkillReturn

End:
pop {r4-r7} 
pop {r0}
bx r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN AirRaidSkillIDList
