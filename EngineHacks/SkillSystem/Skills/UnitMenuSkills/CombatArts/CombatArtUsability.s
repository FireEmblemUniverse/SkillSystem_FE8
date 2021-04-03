.thumb
.align

@these use dmp/ea literals so they can be used repeatedly

.equ SkillID, SkillTester+4
.equ ArtID, SkillID+4
.equ CombatArtCostTable, ArtID+4
.equ CanUnitWieldWeapon,0x8016574

CombatArtUsability:
@true if unit has skill AND attack is available

push {r4-r7,lr}
ldr r0,=0x3004e50
ldr r4,[r0] @save active unit in r4
ldr r1,[r4,#0xc]
mov r0, #0x40 @has not moved...
and r0,r1
cmp r0,#0
bne False

@check if active unit has skill
mov r0, r4 @test
ldr r1, SkillID
ldr r2, SkillTester
mov lr, r2
.short 0xf800 @test if unit has the skill
cmp r0, #0
bne UnitHasSkill
b False

UnitHasSkill:
@check if active unit has enough durability with any weapon in their inventory
ldr r0,ArtID
ldr r1,CombatArtCostTable
add r0,r1
ldrb r5,[r0] @r5 = needed durability
mov r6,r4
add r6,#0x1E @r6 = start of items on active unit

LoopStart:
ldrh r1,[r6]
cmp r1,#0
beq False

mov r0,r4
ldr r2,=CanUnitWieldWeapon
mov r14,r2
.short 0xF800
cmp r0,#0
beq LoopRestart

@check if durability is solid
ldrh r1,[r6]
lsr r1,r1,#8
cmp r1,r5
bge HasDurability

LoopRestart:
add r6,#2
sub r3,r6,r4
cmp r3,#10
ble LoopStart


HasDurability:
@now check if can attack
ldr r0, =0x80249ac @attack usability
mov lr, r0
.short 0xf800
cmp r0, #1
bne False

True:
mov r0,#1
b End

False:
mov r0,#3
End:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD GambleID


