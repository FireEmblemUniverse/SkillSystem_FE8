.thumb
.align

.equ AuraSkillCheck,SkillTester+4
.equ SkillID,AuraSkillCheck+4
.equ ClassType,SkillID+4

push {r4-r7,r14}
mov r4,r0 @attacker
mov r5,r1 @defender

@basically we do what armor march does to check for armored allies in range but for class types

@check if enemy is correct class type
mov r0,r5
ldr r0,[r0,#4]
add r0,#0x50 @class type
ldrh r0,[r0]
ldr r1,ClassType
and r0,r1
cmp r0,#0
beq GoBack

@check for skill 
ldr r0,SkillTester
mov r14,r0
mov r0,r4
ldr r1,SkillID
.short 0xF800
cmp r0,#0
beq GoBack

@get nearby units
ldr	r0,AuraSkillCheck
mov	lr,r0
mov	r0,r4		@unit to check
mov	r1,#0
mov	r2,#1		@are allied
mov	r3,#3		@range
.short	0xf800

@check if any nearby unit is correct class type
ldr	r6,=#0x202B256	@bugger for the nearby units
LoopStart:
ldrb	r0,[r6]
cmp	r0,#0
beq	GoBack
ldr	r1,=#0x8019430	@get char data
mov	lr,r1
.short	0xf800		@r0 = pointer to unit in ram
mov	r3,r0
ldr	r0,ClassType
ldr	r1,[r3,#0x4]
add r1,#0x50
ldrh r1,[r1]
and r0,r1
cmp r0,#0
bne	LoopSuccess
add	r6,#1
b	LoopStart

LoopSuccess:

@+4 def

mov r0,r4
add r0,#0x5C
ldrh r1,[r0]
add r1,#4
strh r1,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
