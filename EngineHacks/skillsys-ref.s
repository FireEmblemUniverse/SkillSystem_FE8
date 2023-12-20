
.macro fun value, name
    .global \name
    .type \name, function
    .set \name, \value
.endm

.macro dat value, name
    .global \name
    .type \name, object
    .set \name, \value
.endm

@ NewSkillTester
dat 0x02026BB0, gAttackerSkillBuffer
dat 0x02026C00, gDefenderSkillBuffer 
dat 0x02026B90, gTempSkillBuffer     
dat 0x02027200, gAuraSkillBuffer     
dat 0x0202764C, gUnitRangeBuffer     

@ NewBattleFollowUpOrder
fun __divsi3,   __aeabi_idiv
fun __modsi3,   __aeabi_idivmod

dat 0x08017AB8, classTablePoin
fun 0x080cc905, PromoHandler_SetInitStat
dat 0x0203E894, gBWLDataStorage

@ PopupRework
fun 0x0878D518, gAnimScr_PopupIcon 
fun 0x08803B30, gGfx_BattlePopup 
fun 0x08803CB0, gPal_BattlePopup
fun 0x08803BD0, gGfx_BattlePopupTextBg 
dat 0x02019790, gSpellFxTsaBuffer 
fun 0x08803CD0, gTsa_BattlePopup 
fun 0x08071991, SomeBattlePlaySound_8071990 
dat 0x0203E18C, gpUnitRight_BattleStruct 
dat 0x0203E188, gpUnitLeft_BattleStruct 

@ GaidenMagic
fun (0x080171E8+1), GetUnitRangeMask
fun (0x08016750+1), CanUnitUseWeapon
fun (0x08016800+1), CanUnitUseStaff
fun (0x08016848+1), DrawItemMenuCommand
fun (0x080170D4+1), GetWeaponRangeMask
fun (0x08022B30+1), AttackUMEffect
fun (0x08088E60+1), DrawItemRText
fun (0x08089354+1), RTextUp
fun (0x08089384+1), RTextDown
fun (0x080893B4+1), RTextLeft
fun (0x080893E4+1), RTextRight

fun (0x08016B28+1), NewGetUnitEquippedWeapon
fun (0x08016B58+1), NewGetUnitEquippedWeaponSlot
fun (0x080171E8+1), NewGetUnitRangeMask
fun (0x0802A730+1), SetUpBattleWeaponDataHack
fun (0x08024588+1), NewMenuRText
fun (0x08018B28+1), NewGetUnitUseFlags
fun (0x0802FC48+1), GaidenActionStaffDoorChestUseItemHack
fun (0x0801D1D0+1), GaidenPreActionHack
fun (0x0802CB24+1), GaidenSetupBattleUnitForStaffHack
fun (0x0802EBB4+1), GaidenExecStandardHealHack
fun (0x0802F184+1), GaidenExecFortifyHack
fun (0x0802CC80+1), GaidenStaffInventoryHack
fun (0x08022780+1), GaidenTargetSelectionBPressHack
fun (0x08016884+1), GaidenMenuSpellCostHack
fun (0x08022844+1), GaidenTargetSelectionCamWaitBPressHack
fun (0x0859D3F8+1), SpellTargetSelection

dat 0x0202B6D1, SpellsBuffer
dat 0x0203F080, SelectedSpell
dat 0x0203F082, UsingSpellMenu
dat 0x0203F084, DidSelectSpell

dat 0x02003C94, StatScreenBufferMap
dat 0x02022CA8, gBG0MapBuffer
dat 0x0203A608, gpCurrentRound
dat 0x02003C08, gpStatScreenUnit
dat 0x02022CA8, gBG0TilemapBuffer2D

@ ScrollingStatscreenBackground
dat 0x02003D2C, gpStatScreenPageBg0Map
dat 0x0200422C, gpStatScreenPageBg1Map
dat 0x0200472C, gpStatScreenPageBg2Map
dat 0x02003BFC, StatScreenStruct
