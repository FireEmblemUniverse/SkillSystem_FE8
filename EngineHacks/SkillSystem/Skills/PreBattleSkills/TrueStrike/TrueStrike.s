.thumb
.equ TrueStrikeID, SkillTester+4

@Because of how the pre battle calc loop works, changes to an enemy struct
@will not persist as the loop is run twice per round. The solution is then
@to make the changes to the skill holder's attack.

@We must also consider other boosts that may have occured to the defender's
@defense stats during this skill's activation, so we work out the difference
@between the unmodified defense and resistance stats in their character struct.
@this preserves linear boosts like (+6 defense) but may produce issues with % based
@stat increases if they occur before this skill's activation. KeenFighter is the only
@skill where this is a concern if its placement changes. But good to keep in mind.

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has TrueStrike
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, TrueStrikeID
.short 0xf800
cmp r0, #0
beq End

ldrb r0,[r5,#0x17]  @enemy defense
ldrb r1,[r5,#0x18]  @enemy resistance
cmp r0,r1
blt LoadDefense     @if defense is lower, load defense
cmp r1,r0
blt LoadResistance  @if resistance is lower, load resistance
b   End             @otherwise, proceed as normal

LoadDefense:
mov r3,#0x50
ldrb r2,[r4,r3]     @load weapon type
cmp r2,#3
ble End             @if it's a physical weapon we don't need to do anything as defense will already be targeted
mov r2,#0x5A
ldrh r3,[r4,r2]     @load unit attack
sub r1,r0           @work out the difference between the defense and resistance
add r3,r1           @now add the difference to the skill holder's attack
strh r3,[r4,r2]     @store the new attack value
b   End

LoadResistance:
mov r3,#0x50
ldrb r2,[r4,r3]     @load weapon type
cmp r2,#3
bgt End             @if it's a magical weapon we don't need to do anything as resistance will already be targeted
mov r2,#0x5A
ldrh r3,[r4,r2]     @load unit attack
sub r0,r1           @work out the difference between the defense and resistance
add r3,r0           @now add the difference to the skill holder's attack
strh r3,[r4,r2]     @store the new attack value
b   End

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD TrueStrikeID
