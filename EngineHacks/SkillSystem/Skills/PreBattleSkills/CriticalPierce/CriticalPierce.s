.thumb
.equ CriticalPierceID, SkillTester+4

@It will incorrecly display a boosted crit when checking the stat screen 
@once a defender has been loaded. This is purely cosmetic and the correct
@value will be used in battle

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has CriticalPierce
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CriticalPierceID
.short 0xf800
cmp r0, #0
beq End

mov r0,#0x68
ldrh r0,[r5,r0]     @load the enemy's crit avoid
mov r1,#0x66
ldrh r2,[r4,r1]     @load the skill holder's crit
add r2,r0           @add the enemy's crit avoid to the skill holder's crit. Effectively 'negating' their crit avoid
strh r2,[r4,r1]     @store the new value

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD CriticalPierceID
