.thumb
.align

.global CombatArtsRestrictDoubling
.type CombatArtsRestrictDoubling, %function

.set gBattleActor, 0x0203A4EC
.set ActiveCombatArt, 0x0203F101


CombatArtsRestrictDoubling:
@r0 = attacker unit ptr, r1 = defender unit ptr, r2 = AS check result
@return 0 for forcing unable to double, 1 for forcing able to double, 2 for keeping AS result/no change
@we want to return 0 if A. we are using a combat art and B. the setting for combat arts doubling is set to true, otherwise return 2
push {r4-r6,r14}
mov r4,r0 @attacker
mov r5,r1 @defender
mov r6,r2 @AS check result

@are we the attacker?
ldr r0,=gBattleActor 
cmp r0,r4
bne RetNoChange

@are we NOT using a combat art?
ldr r0,=ActiveCombatArt
ldrb r0,[r0]
cmp r0,#0 
beq RetNoChange

@are combat arts allowed to double?
ldr r1,=CombatArtDoubleOptionLink
ldrb r1,[r1]
cmp r1,#0 @if this option equals 0 then YES
bne RetForceNoDoubling

@are we using a combat art that shouldn't double ?
ldr r1,=CombatArtsThatCannotDouble
LoopStart:
ldrb r2, [r1]
cmp r2, #0 @check if the value is the terminator
beq RetNoChange
cmp r2, r0 @check if the active art is in the list
beq RetForceNoDoubling
add r1,#1
b LoopStart

RetForceNoDoubling:
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

