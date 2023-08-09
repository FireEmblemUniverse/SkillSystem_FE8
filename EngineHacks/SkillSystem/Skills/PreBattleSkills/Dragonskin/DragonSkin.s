.equ DragonSkinID, SkillTester+4
.equ gBattleData, 0x203a4d4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the defender
@r1 is the attacker
mov r4, r0
mov r5, r1

@make sure we're in combat (or battle forecast)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

ldr r0,=#0x203A56C
cmp r0, r4
bne End @Defender's def isn't calculated yet, so end

@skillcheck for defender
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, DragonSkinID
.short 0xf800
cmp r0, #0
beq AttackerCheck

mov r1, r4
add r1, #0x5C  		@defender def
ldrh r2,[r1]		@load it to register

mov r0, r5
add r0,#0x5A		@attacker atk
ldrh r3,[r0]		@load it to register
cmp r2,r3
bge AttackerCheck 	@no damage -> Go to attacker check

sub r3,r2 		    @subtract def from attack
lsr r3,#0x1			@divide by two
strh r3,[r0]		@store
mov r0,#0x0
strh r0, [r1]		@make defenders def 0


@skillcheck for attacker
AttackerCheck:
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @attacker data
ldr r1, DragonSkinID
.short 0xf800
cmp r0, #0
beq End

mov r1, r5
add r1, #0x5C  		@attacker def
ldrh r2,[r1]		@load it to register

mov r0, r4
add r0,#0x5A		@defender atk
ldrh r3,[r0]		@load it to register
cmp r2,r3
bge End				@no damage -> End

sub r3,r2 		    @subtract def from attack
lsr r3,#0x1			@divide by two
strh r3,[r0]		@store
mov r0,#0x0
strh r0, [r1]		@make attackers def 0

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD DragonSkinID
