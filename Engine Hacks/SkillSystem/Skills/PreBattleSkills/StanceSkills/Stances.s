
.thumb
.global StancesASM
.type StancesASM, %function

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

End2:
pop { r4 - r7 }
pop { r3 }
bx r3

StancesASM:
push { r4 - r7, lr }
mov r4, r0
mov r5, r1
ldr r0, =#0x0203A56C
cmp r0, r4
bne End2
@ Cool it's defending. I need to check if the enemy's weapon is magic.
ldr r0, [ r5, #0x4C ]
mov r1, #0x02
tst r0, r1
beq NotMagic
@ So it is a magic thing.
mov r7, #0x01
NotMagic:
mov r6, #0x00

@ CheckBracingStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckDartingStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 def/res.
strh r0, [ r4, r1 ]

CheckDartingStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckFierceStance
mov r1, #0x5E
ldrh r0, [ r4, r1 ]
add r0, #0x06 @ Add 6 attack speed.
strh r0, [ r4, r1 ]
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #0x0C @ Add 12 avoid.
strh r0, [ r4, r1 ]

CheckFierceStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckKestrelStance
mov r1, #0x5A
ldrh r0, [ r4, r1 ]
add r0, #0x06 @ Add 6 attack.
strh r0, [ r4, r1 ]

CheckKestrelStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckMirrorStance
mov r1, #0x5A
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack.
strh r0, [ r4, r1 ]
mov r1, #0x5E
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack speed.
strh r0, [ r4, r1 ]
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #0x08 @ Add 8 avoid.
strh r0, [ r4, r1 ]

CheckMirrorStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckReadyStance
mov r1, #0x5A
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack.
strh r0, [ r4, r1 ]
@ I need to check if the enemy's weapon is magic since this calls for +4 res specifically.
cmp r7, #0x01
bne CheckReadyStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 res.
strh r0, [ r4, r1 ]

CheckReadyStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckSteadyStance
mov r1, #0x5E
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack speed.
strh r0, [ r4, r1 ]
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #0x08 @ Add 8 avoid.
strh r0, [ r4, r1 ]
cmp r7, #0x01
beq CheckSteadyStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 def.
strh r0, [ r4, r1 ]

CheckSteadyStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckSturdyStance
cmp r7, #0x01
beq CheckSturdyStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x06 @ Add 6 def.
strh r0, [ r4, r1 ]

CheckSturdyStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckSwiftStance
mov r1, #0x5A
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack.
strh r0, [ r4, r1 ]
cmp r7, #0x01
beq CheckSwiftStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 def.
strh r0, [ r4, r1 ]

CheckSwiftStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckWardingStance
mov r1, #0x5E
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 attack speed.
strh r0, [ r4, r1 ]
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #0x08 @ Add 8 avoid.
strh r0, [ r4, r1 ]
cmp r7, #0x01
bne CheckWardingStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 res.
strh r0, [ r4, r1 ]

CheckWardingStance:
bl CheckNextStance
cmp r0, #0x00
beq CheckSpectrumStance
cmp r7, #0x01
bne CheckSpectrumStance
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x06 @ Add 6 res.
strh r0, [ r4, r1 ]

CheckSpectrumStance:
bl CheckNextStance
cmp r0, #0x00
beq End
mov r1, #0x5A
ldrh r0, [ r4, r1 ]
add r0, #0x02 @ Add 2 attack.
strh r0, [ r4, r1 ]
mov r1, #0x5E
ldrh r0, [ r4, r1 ]
add r0, #0x02 @ Add 2 attack speed.
strh r0, [ r4, r1 ]
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #0x04 @ Add 4 avoid.
strh r0, [ r4, r1 ]
mov r1, #0x5C
ldrh r0, [ r4, r1 ]
add r0, #0x02 @ Add 2 def/res.
strh r0, [ r4, r1 ]

CheckAlertStance:
bl CheckNextStance
cmp r0, #0x00
beq End
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #15 @ Add 15 avoid.
strh r0, [ r4, r1 ]

CheckAlertStancePlus:
bl CheckNextStance
cmp r0, #0x00
beq End
mov r1, #0x62
ldrh r0, [ r4, r1 ]
add r0, #30 @ Add 30 avoid.
strh r0, [ r4, r1 ]


End:
pop { r4 - r7 }
pop { r3 }
bx r3

CheckNextStance:
push { lr }
ldr r1, =StanceSkillList
ldrb r1, [ r1, r6 ]
mov r0, r4
blh SkillTester, r3
add r6, #0x01
pop { r3 }
bx r3

@Bracing Stance- +4 res/def
@Darting Stance- +6 Speed 
@Fierce Stance - +6 Attack 
@Kestrel Stance- +4 atk/spd
@Mirror Stance- +4 atk/res
@Steady Stance- +6 def
@Sturdy Stance- +4 atk/def
@Ready Stance - +4 spd/def
@Swift Stance- +4 spd/res
@Warding Stance- +6 res
