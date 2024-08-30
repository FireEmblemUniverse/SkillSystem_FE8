@FactionSlayer_UnitIDList is a null terminated list of unit IDs in FactionSlayer/Installer.event

@by ditto, big thanks Jester and Contro for helping fix this!

@flow of this skill:
@if attacker has this skill, deal 2x calculated damage to a list of units (no, not effective)

.thumb
.equ FactionSlayerID, SkillTester+4
.equ gBattleDefender, 0x203A56C

@start time! usual stuff, copy over attacker/defender to r4/r5 respectively
push {r4, r5, lr}
mov r4, r0 @attacker
mov r5, r1 @defender

@this took far too long to figure out
ldr r0, =gBattleDefender
cmp r0, r4
bne End

ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, FactionSlayerID
.short 0xf800
cmp r0, #0
beq CheckDefender
  mov r0, r5
  mov r1, r4
  bl ApplyFactionSlayer

CheckDefender:
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, FactionSlayerID
.short 0xf800
cmp r0, #0
beq End
  mov r0, r4
  mov r1, r5
  bl ApplyFactionSlayer
  b  End

End:
pop {r4, r5}
pop {r0}
bx r0

ApplyFactionSlayer:
push {r4, r5}

mov r4, r1
mov r5, r0

@okay! if they're here, they have the skill. Now, we check their enemy's unit ID against our list.
@Let's initiate our loop, as we've got to traverse this array of sorts.
ldr r3, =FactionSlayer_UnitIDList
ldr r1, [r4]
ldrb r1, [r1, #4] @Enemy unit's ID
mov r2, #0x0 @offset, increased by 1 per loop iteration

ListLoop:
ldrb r0, [r3,r2] @loads a list item to r0

cmp r0, #0x0
beq ApplyEnd @if list reaches a $00 byte, terminate

cmp r0, r1
beq ApplyDamage @if the list item and the enemy unit match, apply damage

@else, iterate
add r2, #1 @add 1 to offset
b ListLoop

ApplyDamage:
mov r3, #0x5A
ldrh r0, [r5, r3] @user attack
mov r2, r0 @keep the actual attack stat for later
mov r3, #0x5C
ldrh r1, [r4, r3] @enemy defense
sub r0, r1 @get the battle damage
cmp r0, #0x0
blt ApplyEnd

@if it's not below 0, add it on to user attack
add r0, r2
mov r3, #0x5A
strh r0, [r5, r3] @store the calculated damage*2

ApplyEnd:
pop {r4, r5}
bx lr

.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD FactionSlayerID