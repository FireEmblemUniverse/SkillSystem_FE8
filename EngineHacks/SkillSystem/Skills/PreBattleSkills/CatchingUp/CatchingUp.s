.thumb
.equ CatchingUpID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has CatchingUp
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CatchingUpID
.short 0xf800
cmp r0, #0
beq End

@check to see if the opponent doubles the skill holder
mov r0,#0x5E        @get the attack speed short
ldrh r0,[r5,r0]     @load its value for the defender
mov r1,#0x5E        @get the attack speed short again
ldrh r1,[r4,r1]     @load its value for the attacker
sub r0,r1           @subtract the defender's attack speed from the attacker's attack speed
sub r0,#4           @now subtract the doubling threshold
cmp r0,#0           @compare to 0
bgt ApplyBoost      @if greater than, the defender has some left over speed we can convert into attack
b   End             @otehrwise we branch to the end

@apply the skill effect
ApplyBoost:
mov r1, #0x5A       @get the attack speed short
ldrh r2,[r4,r1]     @load its value for the attacker
add r2,r0           @add on what remains of the defender's attack speed
strh r2,[r4,r1]     @store the new value

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD CatchingUpID
