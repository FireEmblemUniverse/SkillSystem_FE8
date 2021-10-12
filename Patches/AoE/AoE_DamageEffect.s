.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ 0802a95c FillPreBattleStats ?

.equ NextRN_100, 0x8000c64 @NextRN_100

@ given r0 = effect index
@ return damage (between the ranges)

.global AoE_FixedDamage
.type AoE_FixedDamage, %function
AoE_FixedDamage:
push {r4, lr} 
@r0 = table effect address 
mov r4, r0 


ldrb r0, [r4, #20] @ lower bound dmg 
ldrb r1, [r4, #21] @ upper bound dmg 
bl GetRandBetweenXAndY
@ returns the dmg dealt 

pop {r4} 
pop {r1} 
bx r1

.global GetRandBetweenXAndY
.type GetRandBetweenXAndY, %function
GetRandBetweenXAndY:

push {r4-r5, lr}

mov r4, r0 @ lower bound
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

mov r4, r0 
@r0 = table effect address 
@r1 = attacker / current unit ram 
@r2 = current target unit ram
mov r6, r1 
mov r7, r2 


ldrb r0, [r4, #20] @ lower bound mt 
ldrb r1, [r4, #21] @ upper bound mt
cmp r0, r1 
bgt FoundMt @ if lower bound is higher than upper bound because of user error, then we just use the lower bound 
bl GetRandBetweenXAndY
FoundMt:
mov r5, r0 @ mt 




@ terrain bonuses function ? 0802a6dc BattleSetupTerrainData









ldrb r0, [r4, #14] @ use mag bool 
mov r1, #0x14 @ str/pow 
cmp r0, #0 
beq UseStr
@ get unit str / mag 
@ add to mt 
mov r1, #0x3A @ mag byte. do not select "use mag" if no strmag split lmao
UseStr:
ldrb r0, [r6, r1] @ str or mag 

@ get unit def/res 
@ add to terrain bonus
ldrb r2, [r4, #15] @ use res bool 
mov r1, #0x17 
cmp r2, #0 
beq UseDef
mov r1, #0x18 @ Res 
UseDef: 
ldrb r1, [r7, r1] @ Def or Res 

sub r0, r1 @ Dmg to deal 
cmp r0, #0 
bgt NoCap 
mov r0, #1 @ Always deal at least 1 damage 
NoCap:

pop {r4-r7} 
pop {r1} 
bx r1

