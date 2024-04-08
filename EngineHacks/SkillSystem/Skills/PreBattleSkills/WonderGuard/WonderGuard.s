.thumb
.align

.equ WonderGuardID,SkillTester+4
.equ ChapterStruct, 0x202BCF0

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@check for skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, WonderGuardID
.short 0xf800
cmp r0, #0
beq GoBack

@check weapon type of skill holder
mov r3,#0x50
ldrb r0,[r4,r3]

@check weapon type of enemy
ldrb r1,[r5,r3]
cmp r0,r1
bne GoBack
mov r6,#0xF
ldr r3,=ChapterStruct
ldrb r3,[r3,r6]
cmp r3,#0x80
blt WonderGuardAttacking
b   WonderGuardDefending

@set defender attack to 0
WonderGuardDefending:
mov r0, r5
add r0,#0x5A
mov r3,#0
strh r3,[r0]

@set attacker's defense to 255
WonderGuardAttacking:
mov r0, r4
add r0,#0x5C
mov r3,#255
strh r3,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD WonderGuardID

@need work
