.thumb 

.global AIWeaponsHackP0
.type AIWeaponsHackP0, %function 
.global AIWeaponsHackP1
.type AIWeaponsHackP1, %function 
@ in 0x39898 

@ p1 and p2 are in 0x39898 and just cycle through your weapons to decide to attack or not 
@ I don't think it decides which weapon to use here 

@ [0203A50C..203a513]? @ Inventory slots 2-5 for battle actor 
@ in 2AC90 "ComputeCrit" there's 2ACDA 
@ 2ACDA - if item is 0 
@ twice 

@ 2A7AE 
@ 2ACDA 
@ 2ACDA 

.align 4 
AIWeaponsHackP0:
mov r1, r4 @ Inventory slot index 
mov r0, r6 
add r0, #0x28 
ldrb r0, [r0, r1] 
mov r1, #0x0A 
lsl r1, #8 
add r0, r1 @ 0xA durability << 8 | item 
cmp r0, #0 
ldr r1, =0x802ACDD @ return point 
bx r1 

.align 4 

AIWeaponsHackP1:
mov r7, #0 

mov r8, r7 @ also 0 
mov r6, #0x0 
mov r0, #0x28 @Unit wexp 
ldrb r4, [r5, r0] 
mov r0, #0xA @ 10 durability 
lsl r0, #8 

add r4, r0 


@strh r4, [r5, #0x20]
@ldrh r4, [r5, #0x20] @ I think this only works if we look at the 2nd inv item 
					@ Maybe the first item is probably found via GetEquippedWep ? 
					@ We could take it over here to store the strongest four spells 
					@ as items into the inventory slots 2-5 and to restore them back after battle 
					@ We should probably store them as a dedicated ram location for 
					@ attacker's 5 items and defender's 5 items 
					@ we only want to do it on enemy phase, I think? Unless dynamic equip for enemies 
					@ to always use their most powerful counterattack against you 
					@ actually that's probably handled better by GetCurrentEquippedWeapon 
					@ Just look for a weapon that can counter, like dynamic equip does. 
					
					@ We don't want to do it for players, anyway, since they don't use AI 
					@ except Berserked players... 
					@ aggh I guess we add an exception for that, too 
					@ if player phase and current unit is berserked 
					@ otherwise, only for enemy on enemy phase 
cmp r4, #0x0 

ldr r0, =0x80398AD @ A few lines into GetUnitAIAttackPriority 
bx r0 

.align 4 
.global AIWeaponsHackP2
.type AIWeaponsHackP2, %function 
AIWeaponsHackP2:
@lsl r1, r6, #1 
@mov r0, r5 
@add r0, #0x1E 
@add r0, r1 
@ldrh r4, [r0] 
@cmp r4, #0 

@mov r1, r6 
mov r0, r5 
add r0, #0x28 
@add r0, r1 
ldrb r4, [r0, r6] 
mov r0, #0xA @ 10 durability 
lsl r0, #8 
cmp r4, #0 
beq DoNotAddDurability
add r4, r0 @ durability<<8|item 
DoNotAddDurability:
cmp r4, #0 @ immediately has a branch based on this cmp 
ldr r0, =0x8039915 
bx r0 

@ Stored 0 to equipped slot 
@ Stored A30 to weapon to use 


@ Vanilla scenario: 
@ [0202D022..0202D023]!
@ doesn't swap order of weapons until standing beside target 
@ at 16BE6 in 08016bc0 EquipUnitItemSlot

@ [0203A53D]! @ Weapon slot index 
@ in this version at 2A79C it has weapon slot index as 1 

@ [0203A534..203A53D]! @ 0x48 - 0x51 
@ [203A50A..203A50B]! @ Equipped item slot 

@ BattleGenerateSimulationInternal at 2A13C does a BL to 2A730 which sets the wep slot to use 
@ 802A13C
@ [3007C48]!
@ 2a33a store sp of wep slot ? 



@ [0203A534]!
@ ORG 0x2A79C
.align 4 
.global AIWeaponsHackP3
.type AIWeaponsHackP3, %function 
@ We finally will store what weapon to use at the end of this function 
@ But we don't know what slot we picked earlier, because items were re-arranged 
@ We need to hook into the function where it decided to equip one of the weapons I guess 
@ [0203AA9B]?!! // ai usedItemSlot 
@ AiSetDecision -> 8039C42
@ 39c20 AiUpdateDecision -> r6 8039C8E
@ 3CD6A: str [sp] -> 3CD76 

@ 803C581
@ AiExecAi1 at 803C4BC -> 803C4F1 
@ AiScript_Exec at 803C5DC 
@ 803C633
@ AiTryDoOffensive: 803D450 with 803CA4F in r14 
@ AiSetDecision has: 803D689 in r14  

@ Okay, so in AiTryDoOffensive it will run AIWeaponsHackP2 
@ 803D5E4 bl to AiTrySimulateBattle is before AIWeaponsHackP1/P2 
@ 803DD54 bl to AiSimulateBattle next 

@ AiBattleGetDamage at 803E0B4 ? 
@ ComputeAiAttack at 803E178 maybe ? 
@ 803E1C0 
@ 3007C98 ? 


@ 2A1C8 - BL to SetupBattleWeaponData 
@ DoSomeBattleWeaponStuff 

@ AIWeaponsHackP1 -> 803D568 -> AIWeaponsHackP2 
@ 803D568 
@ ldr r1, [r2] @ active unit 
@ load wep #1 
@ if no wep, end - we probably want to change this behaviour 



@ 803D578 @ if wep is Nightmare... 

@ 803992C
@ 918C31A




AIWeaponsHackP3:
mov r2, r5  @ Unit struct pointer 
add r2, #0x51 @ wep slot 
strb r3, [r2] @ basically always 0 because equipped wep should go to the top 
				@ ballista uses 8 and there are special cases though 
@ldrb r1, [r2] 
@lsl r1, #1 

@ldr r0, =0x203AA9B @ Slot to use also always 0.. 
@ldrb r0, [r0] 

ldrb r0, [r2] @ Inv Slot to use 

mov r1, r5 
add r1, #0x28 @Wexp #1 
add r1, r0 @ Wexp offset to use 
ldrb r1, [r1] @ Current wep 

mov r0, #0x0A @10 durability 
lsl r0, #8 @ dur << item 
add r0, r1 @ 0x0A|ItemID 



ldr r1, =0x802A7BD 
bx r1 


.align 4 




