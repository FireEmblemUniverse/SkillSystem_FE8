[1mdiff --git a/EngineHacks/Necessary/CalcLoops/PostBattleCalcLoop/PostBattleCalcLoop.event b/EngineHacks/Necessary/CalcLoops/PostBattleCalcLoop/PostBattleCalcLoop.event[m
[1mindex 6954cf01..c8f69be4 100644[m
[1m--- a/EngineHacks/Necessary/CalcLoops/PostBattleCalcLoop/PostBattleCalcLoop.event[m
[1m+++ b/EngineHacks/Necessary/CalcLoops/PostBattleCalcLoop/PostBattleCalcLoop.event[m
[36m@@ -14,7 +14,7 @@[m [mPostCombatSkills: //I like having savage blow as the first one because it makes[m
 POIN InitSkillBuffers //Refresh skill buffers so freshly learned post-battle skills can apply[m
 POIN SavageBlow BreathOfLife Despoil Lifetaker Fury PoisonStrike PastelVeil PoisonPoint GrislyWound//lifetaker should probably go after any messages because it can mess with the palette a bit[m
 POIN StrTaker SklTaker SpdTaker DefTaker ResTaker LukTaker MagTaker MovTaker [m
[31m-POIN Canto CantoPlus Galeforce FailGale ReMove Powerstaff CulturedPostCombat Gridmaster Pathfinder //this order for canto and friends is the only one I tested[m
[32m+[m[32mPOIN Canto CantoPlus Galeforce FailGale ReMove Powerstaff AwestruckPostCombat Gridmaster Pathfinder //this order for canto and friends is the only one I tested[m
 #ifdef GAIDEN_MAGIC[m
 	POIN ApplySupportMagicHPCost[m
 	POIN GaidenZeroOutSpellVariables // without this there was an R-text bug when obtaining an item during the end scene after KOing an enemy [m
[1mdiff --git a/EngineHacks/Necessary/CalcLoops/PreBattleCalcLoop/PreBattleCalcLoop.event b/EngineHacks/Necessary/CalcLoops/PreBattleCalcLoop/PreBattleCalcLoop.event[m
[1mindex 1871277e..c6bb72a9 100644[m
[1m--- a/EngineHacks/Necessary/CalcLoops/PreBattleCalcLoop/PreBattleCalcLoop.event[m
[1m+++ b/EngineHacks/Necessary/CalcLoops/PreBattleCalcLoop/PreBattleCalcLoop.event[m
[36m@@ -37,7 +37,7 @@[m [mPOIN LuckySeven OddRhythm EvenRhythm QuickBurn SlowBurn[m
 POIN Demoiselle Gentilhomme MaleficAura Intimidate Tantivy Focus Inspiration DivinelyInspiring Charm Solidarity VoiceOfPeace Anathema LilysPoise Charisma Hex Loyalty Infiltrator[m
 POIN Merciless StoneBody TrueStrike CriticalPierce CatchingUp Detonate SandRush SlushRush SwiftSwim Technician SolarPower Analytic ElbowRoom NaturalCover Gamble FieryBlood LifeAndDeath NoGuard WindDisciple Perfectionist Puissance Hawkeye LightWeight Trample Opportunist BattleVeteran SilentPride Thunderstorm Outrider HeavyStrikes Charge Vanity KnightAspirant AssassinateDamageBonus ArcaneBlade LadyBlade LunarBraceSkill PursuerPre[m
 POIN Daunt BloodTide WhitePool NightTide Insight Prescience Vigilance DefiantAvo DefiantCrit TowerShield ShortShield IndoorFighter OutdoorFighter Deadeye Fortune ChaosStyle StunningSmile HeavyBlade Decapitator[m
[31m-POIN BlueFlame BlueFlameAura DoubleLion Cultured Thighdeology Thotslayer Armorboost Horseguard Skyguard ForeignPrincess ChargePlus[m
[32m+[m[32mPOIN BlueFlame BlueFlameAura DoubleLion Awestruck Admirer Envious Armorboost Horseguard Skyguard ForeignPrincess ChargePlus[m
 POIN Frenzy // This was moved here because Str/Mag Split conflict, and... I'm not sure why it wouldn't be here in the first place.[m
 POIN UpWithArch[m
 POIN AxefaithHit[m
[36m@@ -86,7 +86,7 @@[m [mAuraSkillEntry(SpurMagID)[m
 AuraSkillEntry(SpurSpdID)[m
 AuraSkillEntry(SpurDefID)[m
 AuraSkillEntry(SpurResID)[m
[31m-AuraSkillEntry(NiceThighsID)[m
[32m+[m[32mAuraSkillEntry(AttractiveID)[m
 AuraSkillEntry(DauntID)[m
 AuraSkillEntry(MaleficAuraID)[m
 AuraSkillEntry(IntimidateID)[m
[1mdiff --git a/EngineHacks/SkillSystem/Internals/SkillSystem.event b/EngineHacks/SkillSystem/Internals/SkillSystem.event[m
[1mindex 98f0ab02..0fe3a43f 100644[m
[1m--- a/EngineHacks/SkillSystem/Internals/SkillSystem.event[m
[1m+++ b/EngineHacks/SkillSystem/Internals/SkillSystem.event[m
[36m@@ -346,7 +346,7 @@[m [mBYTE RallyStrID RallyMagID RallySklID RallySpdID RallyLukID RallyDefID RallyResI[m
 BYTE SpurStrID SpurMagID SpurSpdID SpurDefID SpurResID//spur, same as rally[m
 BYTE UpWithArchID DemoiselleID GentilhommeID InspirationID CharmID AmaterasuID CamaraderieID LilysPoiseID BondID//auras that don't affect the one that makes them, so same as rally[m
 BYTE DisciplineID ParagonID ArmsthriftID CantoPlusID//after battle, probably not working and probably shouldn't be nullified anyway[m
[31m-BYTE HeavyMetalID CelerityID ReliefID LockTouchID LiveToServeID NihilID PersonalityID NiceThighsID SummonID DanceID CunningID DragonsBloodID AcrobatID PassID CantoID RenewalID//other, can't be affected[m
[32m+[m[32mBYTE HeavyMetalID CelerityID ReliefID LockTouchID LiveToServeID NihilID CharmingID AttractiveID SummonID DanceID CunningID DragonsBloodID AcrobatID PassID CantoID RenewalID//other, can't be affected[m
 BYTE RightfulArchID RightfulKingID RightfulGodID//Rightful skills shouldn't really be checked by nihil since any skill that's going to be affected by them should already be nullified[m
 [m
 //TO DO:[m
[1mdiff --git a/EngineHacks/SkillSystem/RemoveSkillMenu/RemoveSkillMenu.event b/EngineHacks/SkillSystem/RemoveSkillMenu/RemoveSkillMenu.event[m
[1mindex e240038b..7cb47c78 100644[m
[1m--- a/EngineHacks/SkillSystem/RemoveSkillMenu/RemoveSkillMenu.event[m
[1m+++ b/EngineHacks/SkillSystem/RemoveSkillMenu/RemoveSkillMenu.event[m
[36m@@ -12,7 +12,7 @@[m
 	(ASMC_LearnNewSkill|1)[m
 		call through events with ASMC. Will learn to the unit defined by slot 2 the skill of index in slot 1[m
 		Ex:[m
[31m-			SVAL 1 NiceThighsID[m
[32m+[m			[32mSVAL 1 AttractiveID[m
 			SVAL 2 (-1) // (-1) is active unit[m
 			ASMC (ASMC_LearnNewSkill|1)[m
 [m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Thighdeology.dmp b/EngineHacks/SkillSystem/SkillIcons/Admirer.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Thighdeology.dmp[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Admirer.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Thighdeology.png b/EngineHacks/SkillSystem/SkillIcons/Admirer.png[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Thighdeology.png[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Admirer.png[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/NiceThighs.dmp b/EngineHacks/SkillSystem/SkillIcons/Attractive.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/NiceThighs.dmp[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Attractive.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/NiceThighs.png b/EngineHacks/SkillSystem/SkillIcons/Attractive.png[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/NiceThighs.png[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Attractive.png[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Cultured.dmp b/EngineHacks/SkillSystem/SkillIcons/Awestruck.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Cultured.dmp[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Awestruck.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Cultured.png b/EngineHacks/SkillSystem/SkillIcons/Awestruck.png[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Cultured.png[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Awestruck.png[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Personality.dmp b/EngineHacks/SkillSystem/SkillIcons/Charming.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Personality.dmp[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Charming.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Personality.png b/EngineHacks/SkillSystem/SkillIcons/Charming.png[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Personality.png[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Charming.png[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Thotslayer.dmp b/EngineHacks/SkillSystem/SkillIcons/Envious.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Thotslayer.dmp[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Envious.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/Thotslayer.png b/EngineHacks/SkillSystem/SkillIcons/Envious.png[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/SkillIcons/Thotslayer.png[m
[1mrename to EngineHacks/SkillSystem/SkillIcons/Envious.png[m
[1mdiff --git a/EngineHacks/SkillSystem/SkillIcons/png.txt b/EngineHacks/SkillSystem/SkillIcons/png.txt[m
[1mindex 3444c67f..0d7fdf7d 100644[m
[1m--- a/EngineHacks/SkillSystem/SkillIcons/png.txt[m
[1m+++ b/EngineHacks/SkillSystem/SkillIcons/png.txt[m
[36m@@ -75,7 +75,7 @@[m [mCounterMagic.png[m
 CriticalForce.png[m
 CriticalPierce.png[m
 CritUp.png[m
[31m-Cultured.png[m
[32m+[m[32mAwestruck.png[m
 Cunning.png[m
 Dance.png[m
 DancingBlade.png[m
[36m@@ -248,7 +248,7 @@[m [mMovOath.png[m
 MovTaker.png[m
 NaturalCover.png[m
 NatureRush.png[m
[31m-NiceThighs.png[m
[32m+[m[32mAttractive.png[m
 NightTide.png[m
 Nihil.png[m
 NimbleInit.png[m
[36m@@ -266,7 +266,7 @@[m [mPathfinder.png[m
 Patience.png[m
 Pavise.png[m
 perfectionist.png[m
[31m-Personality.png[m
[32m+[m[32mCharming.png[m
 Petrify.png[m
 Pivot.png[m
 PointBlank.png[m
[36m@@ -396,8 +396,8 @@[m [mSynchronize.png[m
 Tantivy.png[m
 Technician.png[m
 Tempest.png[m
[31m-Thighdeology.png[m
[31m-Thotslayer.png[m
[32m+[m[32mAdmirer.png[m
[32m+[m[32mEnvious.png[m
 Thunderstorm.png[m
 Tomebreaker.png[m
 Tomefaire.png[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/AssembleARM.bat b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AssembleARM.bat[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/AssembleARM.bat[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AssembleARM.bat[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/NiceThighsTester.dmp b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AttractiveTester.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/NiceThighsTester.dmp[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AttractiveTester.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/NiceThighsTester.s b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AttractiveTester.s[m
[1msimilarity index 86%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/NiceThighsTester.s[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AttractiveTester.s[m
[1mindex d7eb9de7..883c5f4d 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/NiceThighsTester.s[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AttractiveTester.s[m
[36m@@ -1,7 +1,7 @@[m
 .thumb[m
 .align 4[m
 [m
[31m-.equ NiceThighsID, SkillTester+4[m
[32m+[m[32m.equ AttractiveID, SkillTester+4[m
 .equ GetUnit, 0x8019431[m
 .equ UnitMap, 0x202E4D8[m
 [m
[36m@@ -9,7 +9,7 @@[m [mpush {r4-r7,r14}[m
 [m
 @r0=character struct[m
 [m
[31m-mov r4,r0 @r4 = char to test for adjacent units with Nice Thighs[m
[32m+[m[32mmov r4,r0 @r4 = char to test for adjacent units with Attractive[m
 [m
 ldrb r5,[r4,#0x10] @x coord[m
 ldrb r6,[r4,#0x11] @y coord[m
[36m@@ -20,7 +20,7 @@[m [mmov r1,r6[m
 bl GetUnitAtCoords[m
 ldr r1,SkillTester[m
 mov r14,r1[m
[31m-ldr r1,NiceThighsID[m
[32m+[m[32mldr r1,AttractiveID[m
 .short 0xF800[m
 cmp r0,#1[m
 beq RetTrue[m
[36m@@ -31,7 +31,7 @@[m [mmov r1,r6[m
 bl GetUnitAtCoords[m
 ldr r1,SkillTester[m
 mov r14,r1[m
[31m-ldr r1,NiceThighsID[m
[32m+[m[32mldr r1,AttractiveID[m
 .short 0xF800[m
 cmp r0,#1[m
 beq RetTrue[m
[36m@@ -42,7 +42,7 @@[m [msub r1,#1[m
 bl GetUnitAtCoords[m
 ldr r1,SkillTester[m
 mov r14,r1[m
[31m-ldr r1,NiceThighsID[m
[32m+[m[32mldr r1,AttractiveID[m
 .short 0xF800[m
 cmp r0,#1[m
 beq RetTrue[m
[36m@@ -53,7 +53,7 @@[m [madd r1,#1[m
 bl GetUnitAtCoords[m
 ldr r1,SkillTester[m
 mov r14,r1[m
[31m-ldr r1,NiceThighsID[m
[32m+[m[32mldr r1,AttractiveID[m
 .short 0xF800[m
 cmp r0,#1[m
 beq RetTrue[m
[36m@@ -93,4 +93,4 @@[m [mbx r1[m
 [m
 SkillTester:[m
 @POIN SkillTester[m
[31m-@WORD NiceThighsID[m
[32m+[m[32m@WORD AttractiveID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/Awestruck.event b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/Awestruck.event[m
[1mnew file mode 100644[m
[1mindex 00000000..69f8fc9b[m
[1m--- /dev/null[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/Awestruck.event[m
[36m@@ -0,0 +1,15 @@[m
[32m+[m
[32m+[m[32mALIGN 4[m
[32m+[m[32mAwestruckPostCombat:[m
[32m+[m[32m#incbin "AwestruckPostBattle.dmp"[m
[32m+[m[32mPOIN SkillTester[m
[32m+[m[32mWORD AwestruckID[m
[32m+[m[32mPOIN AwestruckEvent[m
[32m+[m[32mPOIN AttractiveTester[m
[32m+[m[32m#include "AwestruckEvent.event"[m
[32m+[m
[32m+[m[32mALIGN 4[m
[32m+[m[32mAttractiveTester:[m
[32m+[m[32m#incbin "AttractiveTester.dmp"[m
[32m+[m[32mPOIN SkillTester[m
[32m+[m[32mWORD AttractiveID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedEvent.event b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckEvent.event[m
[1msimilarity index 73%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedEvent.event[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckEvent.event[m
[1mindex c23a4d1f..b3e9e7c4 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedEvent.event[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckEvent.event[m
[36m@@ -1,4 +1,4 @@[m
[31m-CulturedEvent:[m
[32m+[m[32mAwestruckEvent:[m
 CAM1 0xFFFF[m
 SOUN 0x10F[m
 STAL 0x16[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedPostBattle.dmp b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckPostBattle.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedPostBattle.dmp[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckPostBattle.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedPostBattle.s b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckPostBattle.s[m
[1msimilarity index 75%[m
[1mrename from EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedPostBattle.s[m
[1mrename to EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckPostBattle.s[m
[1mindex f0e5f726..bfa762e1 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/CulturedPostBattle.s[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Awestruck/AwestruckPostBattle.s[m
[36m@@ -3,9 +3,9 @@[m
   mov lr, \reg[m
   .short 0xf800[m
 .endm[m
[31m-.equ CulturedID, SkillTester+4[m
[31m-.equ CulturedEvent, CulturedID+4[m
[31m-.equ NiceThighsTester, CulturedEvent+4[m
[32m+[m[32m.equ AwestruckID, SkillTester+4[m
[32m+[m[32m.equ AwestruckEvent, AwestruckID+4[m
[32m+[m[32m.equ AttractiveTester, AwestruckEvent+4[m
 .thumb[m
 [m
 push	{r14}[m
[36m@@ -17,22 +17,22 @@[m [mbeq	End[m
 [m
 @check for skill[m
 mov	r0, r4[m
[31m-ldr	r1, CulturedID[m
[32m+[m[32mldr	r1, AwestruckID[m
 ldr	r3, SkillTester[m
 mov	lr, r3[m
 .short	0xf800[m
 cmp		r0,#0[m
 beq		End[m
 [m
[31m-@check if already Cultured; if so can't trigger again[m
[32m+[m[32m@check if already Awestruck; if so can't trigger again[m
 mov r0, r4[m
 bl CheckGaleforceBit[m
 cmp r0, #0[m
 bne	End[m
 [m
 [m
[31m-@check for adjacent units that have Nice Thighs[m
[31m-ldr r0,NiceThighsTester[m
[32m+[m[32m@check for adjacent units that have Attractive[m
[32m+[m[32mldr r0,AttractiveTester[m
 mov r14,r0[m
 mov r0,r4[m
 .short 0xF800[m
[36m@@ -63,7 +63,7 @@[m [mstrb	r2, [r0][m
 Event:[m
 ldr	r0,=#0x800D07C		@event engine thingy[m
 mov	lr, r0[m
[31m-ldr	r0, CulturedEvent		@this event is just "play some sound effects"[m
[32m+[m[32mldr	r0, AwestruckEvent		@this event is just "play some sound effects"[m
 mov	r1, #0x01			@0x01 = wait for events[m
 .short	0xF800[m
 [m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/Cultured.event b/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/Cultured.event[m
[1mdeleted file mode 100644[m
[1mindex bca9c129..00000000[m
[1m--- a/EngineHacks/SkillSystem/Skills/PostBattleSkills/Cultured/Cultured.event[m
[1m+++ /dev/null[m
[36m@@ -1,15 +0,0 @@[m
[31m-[m
[31m-ALIGN 4[m
[31m-CulturedPostCombat:[m
[31m-#incbin "CulturedPostBattle.dmp"[m
[31m-POIN SkillTester[m
[31m-WORD CulturedID[m
[31m-POIN CulturedEvent[m
[31m-POIN NiceThighsTester[m
[31m-#include "CulturedEvent.event"[m
[31m-[m
[31m-ALIGN 4[m
[31m-NiceThighsTester:[m
[31m-#incbin "NiceThighsTester.dmp"[m
[31m-POIN SkillTester[m
[31m-WORD NiceThighsID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PostBattleSkills/PostBattleSkills.event b/EngineHacks/SkillSystem/Skills/PostBattleSkills/PostBattleSkills.event[m
[1mindex 289786fb..25eb5733 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PostBattleSkills/PostBattleSkills.event[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PostBattleSkills/PostBattleSkills.event[m
[36m@@ -122,7 +122,7 @@[m [mWORD PowerstaffID[m
 POIN PowerstaffEvent[m
 #include "Powerstaff/PowerstaffEvent.event"[m
 [m
[31m-#include "Cultured/Cultured.event"[m
[32m+[m[32m#include "Awestruck/Awestruck.event"[m
 [m
 [m
 #include "FailGale/Installer.event" [m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/Thighdeology.dmp b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/Admirer.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/Thighdeology.dmp[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/Admirer.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/Thighdeology.s b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/Admirer.s[m
[1msimilarity index 67%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/Thighdeology.s[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/Admirer.s[m
[1mindex 73df4a21..41ddeda9 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/Thighdeology.s[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/Admirer.s[m
[36m@@ -1,7 +1,7 @@[m
 .thumb[m
[31m-.equ ThighdeologyID, SkillTester+4[m
[31m-.equ AuraSkillCheck, ThighdeologyID+4[m
[31m-.equ NiceThighsID, AuraSkillCheck+4[m
[32m+[m[32m.equ AdmirerID, SkillTester+4[m
[32m+[m[32m.equ AuraSkillCheck, AdmirerID+4[m
[32m+[m[32m.equ AttractiveID, AuraSkillCheck+4[m
 [m
 push {r4-r7, lr}[m
 mov r4, r0 @attacker[m
[36m@@ -10,16 +10,16 @@[m [mmov r5, r1 @defendker[m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r4 @attacker data[m
[31m-ldr r1, ThighdeologyID[m
[32m+[m[32mldr r1, AdmirerID[m
 .short 0xf800[m
 cmp r0, #0[m
 beq GoBack[m
 [m
[31m-@if we have Thighdeology, check for people with Nice Thighs[m
[32m+[m[32m@if we have Admirer, check for people with Attractive[m
 ldr r0, AuraSkillCheck[m
 mov lr, r0[m
 mov r0, r4 @attacker[m
[31m-ldr r1, NiceThighsID[m
[32m+[m[32mldr r1, AttractiveID[m
 mov r2, #4 @all units[m
 mov r3, #3 @range[m
 .short 0xf800[m
[36m@@ -48,6 +48,6 @@[m [mpop {r4-r7, r15}[m
 [m
 SkillTester:[m
 @POIN SkillTester[m
[31m-@WORD ThighdeologyID[m
[32m+[m[32m@WORD AdmirerID[m
 @POIN AuraSkillCheck[m
[31m-@WORD NiceThighsID[m
[32m+[m[32m@WORD AttractiveID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/AssembleARM.bat b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/AssembleARM.bat[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/AssembleARM.bat[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Admirer/AssembleARM.bat[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/AssembleARM.bat b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/AssembleARM.bat[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thighdeology/AssembleARM.bat[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/AssembleARM.bat[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.dmp b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.dmp[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.event b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.event[m
[1mnew file mode 100644[m
[1mindex 00000000..41b3732b[m
[1m--- /dev/null[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.event[m
[36m@@ -0,0 +1,9 @@[m
[32m+[m
[32m+[m
[32m+[m[32mALIGN 4[m
[32m+[m[32mAwestruck:[m
[32m+[m[32m#incbin "Awestruck.dmp"[m
[32m+[m[32mPOIN SkillTester[m
[32m+[m[32mWORD AwestruckID[m
[32m+[m[32mWORD AttractiveID[m
[32m+[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.s b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.s[m
[1msimilarity index 67%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.s[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.s[m
[1mindex b4d11583..66979cbd 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.s[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Awestruck/Awestruck.s[m
[36m@@ -1,6 +1,6 @@[m
 .thumb[m
[31m-.equ CulturedID, SkillTester+4[m
[31m-.equ NiceThighsID, CulturedID+4[m
[32m+[m[32m.equ AwestruckID, SkillTester+4[m
[32m+[m[32m.equ AttractiveID, AwestruckID+4[m
 [m
 push {r4-r7, lr}[m
 mov r4, r0 @attacker[m
[36m@@ -9,17 +9,17 @@[m [mmov r5, r1 @defender[m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r4 @attacker data[m
[31m-ldr r1, CulturedID[m
[32m+[m[32mldr r1, AwestruckID[m
 .short 0xf800[m
 cmp r0, #0[m
 beq GoBack[m
 [m
[31m-@Cultured: -50 hit if opponent has Nice Thighs[m
[32m+[m[32m@Awestruck: -50 hit if opponent has Attractive[m
 [m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r5[m
[31m-ldr r1, NiceThighsID[m
[32m+[m[32mldr r1, AttractiveID[m
 .short 0xf800[m
 cmp r0, #1[m
 bne GoBack[m
[36m@@ -38,8 +38,8 @@[m [mpop {r4-r7, r15}[m
 [m
 SkillTester:[m
 @Poin SkillTester[m
[31m-@WORD CulturedID[m
[32m+[m[32m@WORD AwestruckID[m
 @WORD DebuffTable[m
[31m-@WORD CulturedBit[m
[32m+[m[32m@WORD AwestruckBit[m
 @WORD 8 //size of debuff table entry[m
[31m-@WORD NiceThighsID[m
[32m+[m[32m@WORD AttractiveID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.event b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.event[m
[1mdeleted file mode 100644[m
[1mindex b4898e13..00000000[m
[1m--- a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Cultured/Cultured.event[m
[1m+++ /dev/null[m
[36m@@ -1,9 +0,0 @@[m
[31m-[m
[31m-[m
[31m-ALIGN 4[m
[31m-Cultured:[m
[31m-#incbin "Cultured.dmp"[m
[31m-POIN SkillTester[m
[31m-WORD CulturedID[m
[31m-WORD NiceThighsID[m
[31m-[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/AssembleARM.bat b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/AssembleARM.bat[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/AssembleARM.bat[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/AssembleARM.bat[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/Thotslayer.dmp b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/Envious.dmp[m
[1msimilarity index 100%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/Thotslayer.dmp[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/Envious.dmp[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/Thotslayer.s b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/Envious.s[m
[1msimilarity index 71%[m
[1mrename from EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/Thotslayer.s[m
[1mrename to EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/Envious.s[m
[1mindex 85b66262..54cb31cb 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PreBattleSkills/Thotslayer/Thotslayer.s[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PreBattleSkills/Envious/Envious.s[m
[36m@@ -1,7 +1,7 @@[m
 .thumb[m
[31m-.equ ThotslayerID, SkillTester+4[m
[31m-.equ NiceThighsID, ThotslayerID+4[m
[31m-.equ PersonalityID, NiceThighsID+4[m
[32m+[m[32m.equ EnviousID, SkillTester+4[m
[32m+[m[32m.equ AttractiveID, EnviousID+4[m
[32m+[m[32m.equ CharmingID, AttractiveID+4[m
 [m
 push {r4-r7, lr}[m
 mov r4, r0 @attacker[m
[36m@@ -10,7 +10,7 @@[m [mmov r5, r1 @defendker[m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r4 @attacker data[m
[31m-ldr r1, ThotslayerID[m
[32m+[m[32mldr r1, EnviousID[m
 .short 0xf800[m
 cmp r0, #0[m
 beq GoBack[m
[36m@@ -20,7 +20,7 @@[m [mbeq GoBack[m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r5 @defender data[m
[31m-ldr r1, NiceThighsID[m
[32m+[m[32mldr r1, AttractiveID[m
 .short 0xf800[m
 cmp r0, #0[m
 bne ActivateSkill[m
[36m@@ -28,7 +28,7 @@[m [mbne ActivateSkill[m
 ldr r0, SkillTester[m
 mov lr, r0[m
 mov r0, r5 @defender data[m
[31m-ldr r1, PersonalityID[m
[32m+[m[32mldr r1, CharmingID[m
 .short 0xf800[m
 cmp r0, #0[m
 beq GoBack[m
[36m@@ -50,6 +50,6 @@[m [mpop {r4-r7, r15}[m
 [m
 SkillTester:[m
 @POIN SkillTester[m
[31m-@WORD ThotslayerID[m
[31m-@WORD NiceThighsID[m
[31m-@WORD PersonalityID[m
[32m+[m[32m@WORD EnviousID[m
[32m+[m[32m@WORD AttractiveID[m
[32m+[m[32m@WORD CharmingID[m
[1mdiff --git a/EngineHacks/SkillSystem/Skills/PreBattleSkills/PreBattleSkills.event b/EngineHacks/SkillSystem/Skills/PreBattleSkills/PreBattleSkills.event[m
[1mindex 33ca9047..7513735b 100644[m
[1m--- a/EngineHacks/SkillSystem/Skills/PreBattleSkills/PreBattleSkills.event[m
[1m+++ b/EngineHacks/SkillSystem/Skills/PreBattleSkills/PreBattleSkills.event[m
[36m@@ -313,23 +313,23 @@[m [mDoubleLion:[m
 POIN SkillTester[m
 WORD DoubleLionID[m
 [m
[31m-#include "Cultured/Cultured.event"[m
[32m+[m[32m#include "Awestruck/Awestruck.event"[m
 [m
 ALIGN 4[m
[31m-Thighdeology:[m
[31m-#incbin "Thighdeology/Thighdeology.dmp"[m
[32m+[m[32mAdmirer:[m
[32m+[m[32m#incbin "Admirer/Admirer.dmp"[m
 POIN SkillTester[m
[31m-WORD ThighdeologyID[m
[32m+[m[32mWORD AdmirerID[m
 POIN NewAuraSkillCheck[m
[31m-WORD NiceThighsID[m
[32m+[m[32mWORD AttractiveID[m
 [m
 ALIGN 4[m
[31m-Thotslayer:[m
[31m-#incbin "Thotslayer/Thotslayer.dmp"[m
[32m+[m[32mEnvious:[m
[32m+[m[32m#incbin "Envious/Envious.dmp"[m
 POIN SkillTester[m
[31m-WORD ThotslayerID[m
[31m-WORD NiceThighsID[m
[31m-WORD PersonalityID[m
[32m+[m[32mWORD EnviousID[m
[32m+[m[32mWORD AttractiveID[m
[32m+[m[32mWORD CharmingID[m
 [m
 ALIGN 4[m
 ChargePlus:[m
[1mdiff --git a/EngineHacks/SkillSystem/skill_definitions.event b/EngineHacks/SkillSystem/skill_definitions.event[m
[1mindex e114a616..728dbbae 100644[m
[1m--- a/EngineHacks/SkillSystem/skill_definitions.event[m
[1m+++ b/EngineHacks/SkillSystem/skill_definitions.event[m
[36m@@ -432,9 +432,9 @@[m
 //By circleseverywhere[m
 #define SavageBlowID 125[m
 [m
[31m-//Cultured: If unit attacks next to a unit with Nice Thighs, move again. -50 hit against units with Nice Thighs.[m
[32m+[m[32m//Awestruck: If unit attacks next to a unit with Attractive, move again. -50 hit against units with Attractive.[m
 //By Sme[m
[31m-#define CulturedID 121[m
[32m+[m[32m#define AwestruckID 121[m
 [m
 //Gridmaster: Movement skills do not end your action.[m
 //By Sme[m
[36m@@ -769,13 +769,13 @@[m
 //By Sme[m
 #define DoubleLionID 152[m
 [m
[31m-//Thighdeology: If a unit within 3 tiles has Nice Thighs, gain +2 Attack and +20 Hit.[m
[32m+[m[32m//Admirer: If a unit within 3 tiles has Attractive, gain +2 Attack and +20 Hit.[m
 //By Sme[m
[31m-#define ThighdeologyID 187[m
[32m+[m[32m#define AdmirerID 187[m
 [m
[31m-//Thotslayer: +15 crit against units with Nice Thighs or Personality.[m
[32m+[m[32m//Envious: +15 crit against units with Attractive or Charming.[m
 //By Sme[m
[31m-#define ThotslayerID 188[m
[32m+[m[32m#define EnviousID 188[m
 [m
 //Heavy Blade: +4 Damage/-2 Attack Speed when unit’s Con. is bigger than the enemy.[m
 //By Mikey Seregon[m
[36m@@ -1428,8 +1428,8 @@[m
 //Display-Only Skills[m
 [m
 #define CunningID 4[m
[31m-#define NiceThighsID 115[m
[31m-#define PersonalityID 116[m
[32m+[m[32m#define AttractiveID 115[m
[32m+[m[32m#define CharmingID 116[m
 [m
 [m
 //Broken Skills[m
[1mdiff --git a/EngineHacks/SkillSystem/skill_descriptions.event b/EngineHacks/SkillSystem/skill_descriptions.event[m
[1mindex 48c6225b..ad896d99 100644[m
[1m--- a/EngineHacks/SkillSystem/skill_descriptions.event[m
[1m+++ b/EngineHacks/SkillSystem/skill_descriptions.event[m
[36m@@ -54,7 +54,7 @@[m [mSkillDescription(DanceID,SD_Dance)[m
 SkillDescription(LifetakerID,SD_Lifetaker)[m
 SkillDescription(GaleforceID,SD_Galeforce)[m
 SkillDescription(RenewalID,SD_Renewal)[m
[31m-SkillDescription(NiceThighsID,SD_NiceThighs)[m
[32m+[m[32mSkillDescription(AttractiveID,SD_Attractive)[m
 SkillDescription(DemoiselleID,SD_Demoiselle)[m
 SkillDescription(GentilhommeID,SD_Gentilhomme)[m
 SkillDescription(MaleficAuraID,SD_MaleficAura)[m
[36m@@ -115,7 +115,7 @@[m [mSkillDescription(SealDefID,SD_SealDef)[m
 SkillDescription(SealResID,SD_SealRes)[m
 SkillDescription(DragonsBloodID,SD_DragonsBlood)[m
 SkillDescription(GambleID,SD_Gamble)[m
[31m-SkillDescription(PersonalityID,SD_Personality)[m
[32m+[m[32mSkillDescription(CharmingID,SD_Charming)[m
 SkillDescription(QuickDrawID,SD_QuickDraw)[m
 SkillDescription(WindDiscipleID,SD_WindDisciple)[m
 SkillDescription(StrongRiposteID,SD_StrongRiposte)[m
[36m@@ -275,7 +275,7 @@[m [mSkillDescription(PushDefID,SD_PushDef)[m
 SkillDescription(PushResID,SD_PushRes)[m
 SkillDescription(SkybreakerID,SD_Skybreaker)[m
 SkillDescription(ResourcefulID,SD_Resourceful)[m
[31m-SkillDescription(CulturedID,SD_Cultured)[m
[32m+[m[32mSkillDescription(AwestruckID,SD_Awestruck)[m
 SkillDescription(LullStrID,SD_LullStr)[m
 SkillDescription(LullMagID,SD_LullMag)[m
 SkillDescription(LullSklID,SD_LullSkl)[m
[36m@@ -287,8 +287,8 @@[m [mSkillDescription(LullSpectrumID,SD_LullSpectrum)[m
 SkillDescription(ShadeID,SD_Shade)[m
 SkillDescription(ShadePlusID,SD_ShadePlus)[m
 SkillDescription(ImbueID,SD_Imbue)[m
[31m-SkillDescription(ThighdeologyID,SD_Thighdeology)[m
[31m-SkillDescription(ThotslayerID,SD_Thotslayer)[m
[32m+[m[32mSkillDescription(AdmirerID,SD_Admirer)[m
[32m+[m[32mSkillDescription(EnviousID,SD_Envious)[m
 SkillDescription(CorrosionID,SD_Corrosion)[m
 SkillDescription(KeepUpID,SD_KeepUp)[m
 SkillDescription(IndoorMarchID,SD_IndoorMarch)[m
[1mdiff --git a/EngineHacks/SkillSystem/skill_icons.event b/EngineHacks/SkillSystem/skill_icons.event[m
[1mindex 0e0341bf..b69c74f3 100644[m
[1m--- a/EngineHacks/SkillSystem/skill_icons.event[m
[1m+++ b/EngineHacks/SkillSystem/skill_icons.event[m
[36m@@ -149,8 +149,8 @@[m [mORG SkillIcon(GaleforceID)[m
 ORG SkillIcon(RenewalID)[m
 #incbin "SkillIcons/Renewal.dmp"[m
 [m
[31m-ORG SkillIcon(NiceThighsID)[m
[31m-#incbin "SkillIcons/NiceThighs.dmp"[m
[32m+[m[32mORG SkillIcon(AttractiveID)[m
[32m+[m[32m#incbin "SkillIcons/Attractive.dmp"[m
 [m
 ORG SkillIcon(DemoiselleID)[m
 #incbin "SkillIcons/Demoiselle.dmp"[m
[36m@@ -332,8 +332,8 @@[m [mORG SkillIcon(DragonsBloodID)[m
 ORG SkillIcon(GambleID)[m
 #incbin "SkillIcons/Gamble.dmp"[m
 [m
[31m-ORG SkillIcon(PersonalityID)[m
[31m-#incbin "SkillIcons/Personality.dmp"[m
[32m+[m[32mORG SkillIcon(CharmingID)[m
[32m+[m[32m#incbin "SkillIcons/Charming.dmp"[m
 [m
 ORG SkillIcon(QuickDrawID)[m
 #incbin "SkillIcons/QuickDraw.dmp"[m
[36m@@ -785,8 +785,8 @@[m [mORG SkillIcon(PoiseID)[m
 ORG SkillIcon(ResourcefulID)[m
 #incbin "SkillIcons/Resourceful.dmp"[m
 [m
[31m-ORG SkillIcon(CulturedID)[m
[31m-#incbin "SkillIcons/Cultured.dmp"[m
[32m+[m[32mORG SkillIcon(AwestruckID)[m
[32m+[m[32m#incbin "SkillIcons/Awestruck.dmp"[m
 [m
 ORG SkillIcon(SkybreakerID)[m
 #incbin "SkillIcons/Skybreaker.dmp"[m
[36m@@ -848,11 +848,11 @@[m [mORG SkillIcon(LullSpectrumID)[m
 ORG SkillIcon(ImbueID)[m
 #incbin "SkillIcons/Imbue.dmp"[m
 [m
[31m-ORG SkillIcon(ThotslayerID)[m
[31m-#incbin "SkillIcons/Thotslayer.dmp"[m
[32m+[m[32mORG SkillIcon(EnviousID)[m
[32m+[m[32m#incbin "SkillIcons/Envious.dmp"[m
 [m
[31m-ORG SkillIcon(ThighdeologyID)[m
[31m-#incbin "SkillIcons/Thighdeology.dmp"[m
[32m+[m[32mORG SkillIcon(AdmirerID)[m
[32m+[m[32m#incbin "SkillIcons/Admirer.dmp"[m
 [m
 ORG SkillIcon(CorrosionID)[m
 #incbin "SkillIcons/Corrosion.dmp"[m
[1mdiff --git a/Events/Release_map.event b/Events/Release_map.event[m
[1mindex 9924c7f7..6bf492a9 100644[m
[1m--- a/Events/Release_map.event[m
[1m+++ b/Events/Release_map.event[m
[36m@@ -196,7 +196,7 @@[m [mVillageEvent:[m
 [m
 HouseEvent:[m
 	// Set parameters[m
[31m-	SVAL r1 NiceThighsID[m
[32m+[m	[32mSVAL r1 AttractiveID[m
 	SVAL r2 (-1) // (-1) is active unit[m
 	[m
 	// Check if unit has skill[m
[1mdiff --git a/Text/skilldesc_text.txt b/Text/skilldesc_text.txt[m
[1mindex 714bf9a8..0c982947 100644[m
[1m--- a/Text/skilldesc_text.txt[m
[1m+++ b/Text/skilldesc_text.txt[m
[36m@@ -206,9 +206,9 @@[m [mattacking and defeating an enemy.[X][m
 Renewal: Restore 30% of max HP[N][m
 at the start of each turn.[X][m
 [m
[31m-## SD_NiceThighs[m
[31m-Nice Thighs: No effect, really.[N][m
[31m-Just thought I'd point them out.[X][m
[32m+[m[32m## SD_Attractive[m
[32m+[m[32mAttractive: No effect. This unit has[N][m
[32m+[m[32mgood looks and immaculate style.[X][m
 [m
 ## SD_Demoiselle[m
 Demoiselle: Male allies within[N][m
[36m@@ -455,10 +455,10 @@[m [mhalved hit but doubled crit.[X][m
 Dragon's Blood: Unit is able[N][m
 to activate Dragon Veins.[X][m
 [m
[31m-## SD_Personality[m
[31m-Nice Personality: This unit has[N][m
[31m-a deep and engaging character,[N][m
[31m-bursting at the seams with development.[X][m
[32m+[m[32m## SD_Charming[m
[32m+[m[32mCharming: No effect. This unit can[N][m
[32m+[m[32meffortlessly make anyone feel[N][m
[32m+[m[32mlike an old friend.[X][m
 [m
 ## SD_QuickDraw[m
 Quick Draw: +4 Damage[N][m
[36m@@ -1119,10 +1119,10 @@[m [mdamage to flying units.[X][m
 Resourceful: Double bonus[N][m
 effectiveness multipliers.[X][m
 [m
[31m-## SD_Cultured[m
[31m-Cultured: If attacking next to a unit[N][m
[31m-with Nice Thighs, move again.[N][m
[31m--50 hit against units with Nice Thighs.[X][m
[32m+[m[32m## SD_Awestruck[m
[32m+[m[32mAwestruck: If attacking next to a unit[N][m
[32m+[m[32mwith Attractive, move again.[N][m
[32m+[m[32m-50 hit against units with Attractive.[X][m
 [m
 ## SD_LullStr[m
 Lull Str: Negates the effects of[N][m
[36m@@ -1168,14 +1168,14 @@[m [mtarget this unit.[X][m
 Imbue: Heal HP equal to magic[N][m
 at the start of each turn.[X][m
 [m
[31m-## SD_Thighdeology[m
[31m-Thighdeology: If a unit within[N][m
[31m-3 tiles has Nice Thighs, gain[N][m
[32m+[m[32m## SD_Admirer[m
[32m+[m[32mAdmirer: If a unit within[N][m
[32m+[m[32m3 tiles has Attractive, gain[N][m
 +2 Attack and +20 Hit.[X][m
 [m
[31m-## SD_Thotslayer[m
[31m-Thotslayer: +15 crit against units[N][m
[31m-with Nice Thighs or Personality.[X][m
[32m+[m[32m## SD_Envious[m
[32m+[m[32mEnvious: +15 crit against units[N][m
[32m+[m[32mwith Attractive or Charming.[X][m
 [m
 ## SD_Corrosion[m
 Corrosion: Decrease durability[N][m
