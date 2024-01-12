.align 4
.thumb

.include "Definitions.s"
.include "_TargetSelectionDefinitions.s"

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ 0802a95c FillPreBattleStats ?	@{U}
@@ 0802A8C8 FillPreBattleStats ?	@{J}



@ given r0 = effect index
@ return damage (between the ranges)

.global AoE_FixedDamage
.type AoE_FixedDamage, %function
AoE_FixedDamage:
push {r4-r6, lr} 
@r0 = table effect address 
mov r4, r0 
mov r5, r3 
mov r6, r1 @ actor 

ldrb r0, [r4, #Config2] 
mov r1, #UseWepMt
and r0, r1 
cmp r0, #0 
beq UseAoEPower

mov r0, r4 @ table 
bl AoE_GetItemUsedOffset
cmp r0, #0 
beq SkipPercent @ 0 mt if no item found 
ldrh r0, [r6, r0] @ item used 


blh GetItemMight 
cmp r5, #1 
beq ReturnFixedDamage
ldrb r1, [r4, #RandAddedMt] @ @ amount of added random dmg 
bl GetRandBetweenXAndXPlusY
b ReturnFixedDamage


UseAoEPower: 
ldrb r0, [r4, #MtByte] @ base Mt 
cmp r5, #1 
beq ReturnFixedDamage
ldrb r1, [r4, #RandAddedMt] @ @ amount of added random dmg 
bl GetRandBetweenXAndXPlusY
@ returns the dmg dealt 
ReturnFixedDamage: 
ldrb r1, [r4, #DamagePercent] 
cmp r1, #100 
beq SkipPercent
mul r0, r1 
mov r1, #100 
swi 6 
SkipPercent:
pop {r4-r6} 
pop {r1} 
bx r1

.global GetRandBetweenXAndXPlusY
.type GetRandBetweenXAndXPlusY, %function
GetRandBetweenXAndXPlusY:

push {r4-r5, lr}

mov r4, r0 @ Base Mt 
add r1, r0 @ Mt+Rand = upper bound 
mov r5, r1 @ upper bound

blh NextRN_100
@r0 as 0-100 i guess 

sub r3, r5, r4 @ difference 
mul r0, r3 @ 

add r0, #50 @ for rounding 


mov r1, #100 
swi 6 @ divide by 100 

add r0, r4 @ rand # between the diff + lower boundary 

pop {r4-r5} 
pop {r1} 
bx r1


@ given r0 = effect index
@ return damage (between the ranges)
.global AoE_RegularDamage
.type AoE_RegularDamage, %function
AoE_RegularDamage:
push {r4-r7, lr} 

mov r4, r0 @r0 = table effect address 
mov r5, r3 @ do min dmg bool 
mov r6, r1 @r1 = attacker / current unit ram 
mov r7, r2 @ target unit ram



ldr r3, AoE_PokemblemDamageModifier+4 @ POIN PokemblemAoEMtGetter
cmp r3, #0 
beq NoMtGetter
mov lr, r3 
ldrb r0, [r4, #MtByte] @ lower bound mt 
ldrb r1, [r4, #RandAddedMt] @ upper bound mt
ldrb r2, [r4, #GaidenSpellWexpByte] @ required item
.short 0xf800 
b FoundMt 
NoMtGetter:


ldrb r0, [r4, #Config2] 
mov r1, #UseWepMt
and r0, r1 
cmp r0, #0 
beq UseAoERegularPower


mov r0, r4 @ table 
bl AoE_GetItemUsedOffset
cmp r0, #0 
beq FoundMt @ 0 mt if no item found 


mov r1, r5 @ return min dmg? 
push {r1} 
mov r5, r0 @ item offset 

ldrh r0, [r6, r5] @ item used 

blh GetItemMight 

push {r0} @ item mt 

@ might be better to use BattleLoadAttack 802aabc which would calculate effectiveness anyway 
@ however, this would fill in the battle struct for attacker & defender each frame where HpBars are displayed in AoE 
@ I dunno if this matters, but 3x effective dmg is probably fine 


ldrb r1, [r4, #Config2] 
mov r2, #UseWepEffectiveness
and r2, r1 
cmp r2, #0 
beq CalcMt 

@PossiblyEffective: 
ldrh r0, [r6, r5] @ item used 
mov r1, r7 @ target 
blh IsWeaponEffective 
mov r2, r0 @ effectiveness 

pop {r0} @ item mt 
pop {r3} @ return min dmg? 

CalcMt: 
cmp r2, #0 
beq NoMultiplyMt 
mov r1, #3 @ 3x mt 
mul r0, r1 
NoMultiplyMt:  

cmp r3, #1 @ always return minimum damage in this case 
beq FoundMt
ldrb r1, [r4, #RandAddedMt] @ @ amount of added random dmg 
bl GetRandBetweenXAndXPlusY
b FoundMt




UseAoERegularPower: 
ldrb r0, [r4, #MtByte] @ base mt 
cmp r5, #1 
beq FoundMt @ always return minimum damage in this case 
ldrb r1, [r4, #RandAddedMt] @ amount of added random dmg 
bl GetRandBetweenXAndXPlusY
FoundMt:
mov r5, r0 @ mt 



@ terrain bonuses function ? 0802a6dc BattleSetupTerrainData

ldrb r2, [r4, #ConfigByte] 
mov r0, #MagBasedBool 
mov r1, #0x14 @ str/pow default 
tst r0, r2 
beq LoadAtt
mov r1, #0x3A @ mag byte. do not select "use mag" if no strmag split lol
LoadAtt:
ldrb r0, [r6, r1] @ str or mag 

add r5, r0 @ dmg to deal 
@ get unit def/res 
@ add to terrain bonus

mov r0, r7 @ unit 
ldrb r2, [r4, #ConfigByte] 
mov r3, #HitResBool 
mov r1, #0x17  @ Def as default 
tst r3, r2 
beq LoadDef

@ r0 = target 
blh GetUnitResistance
b LoadedBattleDef 

LoadDef: 
@ r0 = target 
blh GetUnitDefense 

LoadedBattleDef: 


mov r1, r5 @ dmg 
sub r1, r0 @ Dmg to deal 
mov r0, r1 

cmp r0, #0 
bgt NoCap1 
mov r0, #1 @ Always deal at least 1 damage 
NoCap1:


ldrb r1, [r4, #DamagePercent] 
cmp r1, #100 
beq SkipPercent2
mul r0, r1 
mov r1, #100 
swi 6 
SkipPercent2:


ldr r3, AoE_PokemblemDamageModifier @ Given r0 dmg, r1, target, and r2 'equipped' weapon, recalc dmg 
cmp r3, #0 
beq NoModifier
mov lr, r3 
mov r1, r7 @ target 
ldrb r2, [r4, #GaidenSpellWexpByte] @ required item - used for effectiveness 
.short 0xF800 
NoModifier:


cmp r0, #0 
bgt NoCap 
mov r0, #1 @ Always deal at least 1 damage 
NoCap:

pop {r4-r7} 
pop {r1} 
bx r1

.ltorg 
.align 
AoE_PokemblemDamageModifier:
@ POIN modifier function 
