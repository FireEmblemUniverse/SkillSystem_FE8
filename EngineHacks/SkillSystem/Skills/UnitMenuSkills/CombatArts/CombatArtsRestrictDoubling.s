.thumb
.align

.global CombatArtsRestrictDoubling
.type CombatArtsRestrictDoubling, %function




CombatArtsRestrictDoubling:
@r0 = attacker unit ptr, r1 = defender unit ptr, r2 = AS check result
@return 0 for forcing unable to double, 1 for forcing able to double, 2 for keeping AS result/no change
@we want to return 0 if A. we are using a combat art and B. the setting for combat arts doubling is set to true, otherwise return 2
push {r4-r6,r14}
mov r4,r0 @attacker
mov r5,r1 @defender
mov r6,r2 @AS check result

@are combat arts allowed to double?
ldr r0,=CombatArtDoubleOptionLink
ldrb r0,[r0]
cmp r0,#0
beq RetNoChange

@are we the attacker?
ldr r0,=#0x203A4EC
cmp r0,r4
bne RetNoChange

@are we using a combat art?
ldr r0,=#0x0203F101
ldrb r0,[r0]
cmp r0,#0
beq RetNoChange

mov r0,#0
b GoBack

RetNoChange:
mov r0,#2

GoBack:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align

